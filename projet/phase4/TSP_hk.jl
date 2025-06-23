using InteractiveUtils
using LinearAlgebra

include("../phase3/marked_node.jl")
include("../phase3/marked_edge.jl")
include("../phase3/marked_graph.jl")
include("../phase3/Prime_Alg.jl")
include("../phase3/kruskal_Alg.jl")

include("one_tree.jl")


# function to calculate step size
function Calc_step(n::Int64, k::Int64, period::Int64, period_dur::Float64, period_doubled::Bool, method::Int64)
    t = 1.0
    if method ==1
        t = t/2^(period-1) 
    end
    
    if method == 2
        k = max(1.0,k)
        t = t/k
    end
    
    if method ==3
        k = max(1.0,k)
        t = t/sqrt(k)
    end 
    
    if method == 4
        t = 1.0
    end
    return t
end


# function to calculate degree of nodes in a graph/tree
function compute_deg(Tree::MarkedGraph{T}) where T
    n = length(Tree.nodes)
    dᵏ = zeros(n)
    for node in Tree.nodes
        index = parse(Int, node.name)
        dᵏ[index]=length(adjacent(node))
    end
    return dᵏ
end


# function for solving TSP with Held and Karp algorithm

function HK_MST(Graph::MarkedGraph{T}, MST_Algorithm::Int64, source::MarkedNode{T}, step::Int64, iteration::Int64) where T
    n = length(Graph.nodes)
    iter = 0
    final_weight = 0.0
    final_TSP = nothing
    final_Πᵏ = zeros(n)
    flag = 0
    
    # initialization of variables
    W = -Inf
    W_prev = -Inf
    wᵏ = Inf
    wᵏ⁻¹ = -Inf
    
    Πᵏ = zeros(n)
    Tᵏ = nothing          # a mimimum 1-tree
    tᵏ = 1                # step size (a positive scalar)
    Lᵏ = Inf              # total weight of Tᵏ mimimum 1-Tree
    dᵏ = zeros(n)         # vector of node degrees
    vᵏ = NaN*zeros(n)
    vᵏ⁻¹ = NaN*zeros(n)    

    period = 1            # the number of periods     
    period_dur = n/2      # number of iterations in period
    period_doubled = true 

    k = 0
    
    best_iter = 0
    temp_Graph = deepcopy(Graph)        
    initial_edges = temp_Graph.edges
    initial_nodes = temp_Graph.nodes
    
    while (iter == 0) || ((vᵏ !=zeros(n) && (iter< iteration) && abs(tᵏ)>1e-13 ))
    
        # step(2): initializing the temporary graph and selecting the root vert
 
        Lᵏ,Tᵏ = Minimum_1Tree(temp_Graph, MST_Algorithm, source)
        
        # step 3
        wᵏ⁻¹ = wᵏ
        
        wᵏ = Lᵏ-2*sum(Πᵏ)
    
        # step 4
        W_prev = W
        W = max(W,wᵏ)
        if W > W_prev
            final_TSP = Tᵏ
            final_Πᵏ = Πᵏ
            best_iter = iter
        end
    
        #step 5
        vᵏ⁻¹ = vᵏ
        dᵏ = compute_deg(Tᵏ)
        vᵏ = dᵏ.-2
        if iter ==0
            vᵏ⁻¹ = vᵏ
        end

        # step 6
        if norm(vᵏ)==0.0
            final_TSP = Tᵏ
            final_Πᵏ = Πᵏ
            best_iter = iter
            break
        end
    
        # step 7: choosing the step size
        if (period ==1)&& (wᵏ - wᵏ⁻¹ <0.0)&&(period_doubled == true)&&(k!=0)
            period_doubled = false
        end
    
        # if last iteration leads to increment of W
        if k == Int(floor(period_dur)) && W > W_prev
            period_dur *= 2
        end
        
    
        if k > period_dur
            period_dur /= 2
            period +=1
            k = 0
        end
        
        if (period ==1) && period_doubled 
            tᵏ *= 2.0
        elseif (period !=1)
            tᵏ = Calc_step(n, k, period, period_dur, period_doubled, step)
        end
    
        # step 8: updating the value of Πᵏ
        # Πᵏ = Πᵏ.+ tᵏ.*(0.7.*vᵏ+0.3.*vᵏ⁻¹)
        Πᵏ = Πᵏ.+ tᵏ.*vᵏ
        # update weight of edges
        temp_Graph = deepcopy(Graph)
        for edge in temp_Graph.edges
            i = parse(Int, edge.adjacentnodes[1].name)
            j = parse(Int, edge.adjacentnodes[2].name)
            edge.weight = edge.weight + Πᵏ[i]+ Πᵏ[j]
        end
    
        #step 9
        k = k +1 
        iter += 1   
    end 
    for edge in final_TSP.edges
        edge.weight = graph_edgeweight(Graph, edge.adjacentnodes[1], edge.adjacentnodes[2])
        final_weight = final_weight + edge.weight
    end
    dᵏ = compute_deg(final_TSP)
    final_weight = final_weight-sum(final_Πᵏ.*dᵏ)
    println("number of iteration: ", iter)
 #   println("period_dur: ", period_dur)
 #   println("tᵏ: ", tᵏ)
    if vᵏ == zeros(n)
        println("The algorithm converged successfully ")
        println("The final weight of TSP: ", final_weight)
    else
        println("The algorithm doesn't reach to a tour")
        println("The weight of the Bset found 1_Tree: ", final_weight)
    end
    return final_weight, final_TSP, final_Πᵏ
end


# function to create tour after solving TSP with Held and Karp algorithm if it does not converge
function create_tour!(one_Tree::MarkedGraph{T}, Graph::MarkedGraph{T}, Weight::Float64) where T
    start_V = nothing
    for node in one_Tree.nodes
        if length(adjacent(node)) == 1
            start_V = node
            break
        end
    end
    if start_V != nothing
        node_list = []
        push!(node_list, start_V.name)
        Run_cri = true
        curr_node = one_Tree.nodes[findfirst(x->x.name == node_list[end], one_Tree.nodes)]
        while Run_cri
            prev_node = curr_node
            curr_node = one_Tree.nodes[findfirst(x->x.name == node_list[end], one_Tree.nodes)]
            if length(adjacent(curr_node)) != 0
                next = (adjacent(curr_node)[1][1] != prev_node.name) ? adjacent(curr_node)[1][1] : adjacent(curr_node)[2][1]               
                next_node = one_Tree.nodes[findfirst(x->x.name == next , one_Tree.nodes)]
                
                if length(adjacent(next_node)) > 2
                    cut_name = adjacent(next_node)[findfirst(x->x[1] != curr_node.name , adjacent(next_node))][1]
                    cut_node = one_Tree.nodes[findfirst(x->x.name == cut_name , one_Tree.nodes)]
                    # remove the edge 
                    edge_name = "("*cut_node.name*","*next_node.name*")"
                    Weight = Weight - graph_edgeweight(Graph, cut_node, next_node)
                    delete!(cut_node.adjacents, next_node.name)
                    delete!(next_node.adjacents, cut_node.name)
                    
                    if isempty(findall(x->x.name==edge_name, one_Tree.edges))
                        edge_name = "("*next_node.name*","*cut_node.name*")"
                        deleteat!(one_Tree.edges, findall(x->x.name==edge_name, one_Tree.edges)) 
                    else
                        deleteat!(one_Tree.edges, findall(x->x.name==edge_name, one_Tree.edges))
                    end                           
                    
                    # add a new edge
                    new_Ename = "("*cut_node.name*","*start_V.name*")"
                    edge_weight = graph_edgeweight(Graph, cut_node, start_V)
                    new_edge = MarkedEdge(new_Ename, edge_weight, (cut_node , start_V))
                    
                    add_adj_node!(start_V, cut_node, edge_weight)
                    add_adj_node!(cut_node, start_V, edge_weight)
                    add_markededge!(one_Tree, new_edge)
                    Weight = Weight + edge_weight
                    Run_cri = false
                    
                else
                    push!(node_list, next_node.name)
                end
            end
        end
        create_tour!(one_Tree, Graph, Weight)
    end 
    return one_Tree, Weight
end
    
    
    
# function to improve the total weight of the TSP tour by swaping edges
function Improve_path!(TSP_Tour::MarkedGraph{T}, Graph::MarkedGraph{T} , Weight::Float64) where T  
    k = 1
    find_improve = true
    while find_improve
        start_e = TSP_Tour.edges[findall(x->x.adjacentnodes[1].name == "1", TSP_Tour.edges)][1]
        Edge_list = create_touredge_list!(TSP_Tour, start_e)
        eb = sort(Edge_list, by = x->x.weight, rev=true)[k]
        if eb.adjacentnodes[1].name == "1" || eb.adjacentnodes[2].name == "1" 
            k = k+1
        else
            Weight, find_improve = Improve_path_intit!(Edge_list, TSP_Tour, Graph, Weight, eb, k)
            println(Weight)
        end
    end
    num = 0
    for k in 1:length(TSP_Tour.edges)
        if num > 3
            break
        end
        find_improve = true
        Best_weight = Weight
        while find_improve
            start_e = TSP_Tour.edges[findall(x->x.adjacentnodes[1].name == "1", TSP_Tour.edges)][1]
            Edge_list = create_touredge_list!(TSP_Tour, start_e)
            eb = sort(Edge_list, by = x->x.weight, rev=true)[k]
            if eb.adjacentnodes[1].name == "1" || eb.adjacentnodes[2].name == "1" 
                break
            else
                Weight, find_improve = Improve_path_intit!(Edge_list, TSP_Tour, Graph, Weight, eb, k)
                println(Weight)
            end
        end
        if Best_weight == Weight
            num = num+1
        end
    end
    return Weight
end




# function to find an edge to swap with a specified edge (eb) in a Tour to reduce total weight of the Tour 
    function Improve_path_intit!(Edge_list::Vector{MarkedEdge{T}}, TSP_Tour::MarkedGraph{T}, Graph::MarkedGraph{T} , Weight::Float64, eb::MarkedEdge{T}, k) where T
    
        e = eb.adjacentnodes[1]   
        b = eb.adjacentnodes[2]
        
        stop = false
        find_improve = false
        
        for i in k:length(Edge_list)
            xy = Edge_list[i]
            x = xy.adjacentnodes[1]
            y = xy.adjacentnodes[2]
            if (x != e)&&(x != b)&&(y != e)&&(y != b)&&(x.name != "1")&&(y.name != "1")
                weight_improve = Weight - xy.weight - eb.weight + graph_edgeweight(Graph, y, b) + graph_edgeweight(Graph, e, x)
                if weight_improve < Weight
                    Weight = weight_improve
                        
                    # swap edges eb with xy and update tour
                        
                    Swap_edge!(TSP_Tour, Graph, eb, xy)
    
                    find_improve = true
                    break
                end
            end
        end        
        return Weight , find_improve
    end


    function create_touredge_list!(TSP_Tour::MarkedGraph{T}, start_e::MarkedEdge{T}) where T
        n = length(TSP_Tour.edges)
        edge_list = MarkedEdge{Array{Float64,1}}[]
        graph_edges = TSP_Tour.edges
        push!(edge_list, start_e)
        while length(edge_list) != n
            if isempty(findall(x->x.adjacentnodes[1].name == edge_list[end].adjacentnodes[2].name, graph_edges))
                e = graph_edges[findfirst(x->x.adjacentnodes[2].name == edge_list[end].adjacentnodes[2].name, graph_edges)]
                rev_name = "("*e.adjacentnodes[2].name*","*e.adjacentnodes[1].name*")"
                rev_edge = MarkedEdge(rev_name, e.weight , (e.adjacentnodes[2] , e.adjacentnodes[1]))
                push!(edge_list, rev_edge) 
                deleteat!(graph_edges, findall(x->x.name==e.name, graph_edges))
            else
                e = TSP_Tour.edges[findfirst(x->x.adjacentnodes[1].name == edge_list[end].adjacentnodes[2].name, TSP_Tour.edges)]
                push!(edge_list, e)
                deleteat!(graph_edges, findall(x->x.name==e.name, graph_edges))
            end
        end
        TSP_Tour.edges = edge_list
        return edge_list
    end


    function Swap_edge!(TSP_Tour::MarkedGraph{T}, Graph::MarkedGraph{T}, eb::MarkedEdge, xy::MarkedEdge)  where T
        e = eb.adjacentnodes[1]   
        b = eb.adjacentnodes[2]
        
        x = xy.adjacentnodes[1]
        y = xy.adjacentnodes[2]
        
        xe_name = "("*x.name*","*e.name*")"
        yb_name = "("*y.name*","*b.name*")"
                                   
        xe = MarkedEdge(xe_name, graph_edgeweight(Graph, x, e), (x , e))
        yb = MarkedEdge(yb_name, graph_edgeweight(Graph, y, b), (y , b))
                           
        delete!(e.adjacents, b.name)
        delete!(b.adjacents, e.name)
        delete!(x.adjacents, y.name)
        delete!(y.adjacents, x.name)
                               
                               
        add_adj_node!(e, x, xe.weight)
        add_adj_node!(x, e, xe.weight)
        add_adj_node!(b, y, yb.weight)
        add_adj_node!(y, b, yb.weight)
                           
                               
        add_markededge!(TSP_Tour, xe)
        add_markededge!(TSP_Tour, yb)
       
        deleteat!(TSP_Tour.edges, findall(x->x.name==eb.name, TSP_Tour.edges))
        deleteat!(TSP_Tour.edges, findall(x->x.name==xy.name, TSP_Tour.edges))
        
    end