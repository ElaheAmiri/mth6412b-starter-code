using Markdown
using InteractiveUtils


include("../phase3/marked_node.jl")
include("../phase3/marked_edge.jl")
include("../phase3/marked_graph.jl")
include("../phase3/Prime_Alg.jl")
include("../phase3/kruskal_Alg.jl")


function Minimum_1Tree(Graph::MarkedGraph{T},method::Int64, start_node::MarkedNode{T}) where T
    #source = deepcopy(start_node)

    temp_Graph = deepcopy(Graph)
    source = temp_Graph.nodes[findfirst(x->x.name==start_node.name, temp_Graph.nodes)]

    # removing the node from the graph
    deleteat!(temp_Graph.nodes, findall(x->x.name==source.name, temp_Graph.nodes))
    # removing the esges connected to that node
    deleteat!(temp_Graph.edges, findall(x->x.adjacentnodes[1].name==source.name, temp_Graph.edges))
    deleteat!(temp_Graph.edges, findall(x->x.adjacentnodes[2].name==source.name, temp_Graph.edges))
    
    
    # calculating the minimm spaning tree
    if method ==1
        W, one_tree = Prime_Algo(temp_Graph, temp_Graph.nodes[rand(1:length(temp_Graph.nodes))])
    elseif method ==2
        W, one_tree = Kruskal(temp_Graph)
    end
    
    #adding root to the minimum spaning tree
    source_adj = deepcopy(adjacent(source))
    empty!(source.adjacents)
    k = 0
    for i in 1:length(one_tree.nodes)
        if source_adj[i][1] != source.name
            node = one_tree.nodes[findfirst(x->x.name == source_adj[i][1], one_tree.nodes)]
            edge_name =  "("*source.name*","*node.name*")"
            new_edge = MarkedEdge(edge_name, source_adj[i][2], (source , node))
            W = W + new_edge.weight
            add_adj_node!(source, node, source_adj[i][2])
            add_adj_node!(node, source, source_adj[i][2])
            add_markededge!(one_tree, new_edge)
            k += 1
        end
        if k == 2
            break
        end
    end
    add_markednode!(one_tree, source)
    return W, one_tree
end



# function to calculate source (the vertex which has the longest second nearest neighbor distance)
function Calc_source(Graph::MarkedGraph{T}) where T
    second_NN = Dict()    # second nearest neighbours of graph nodes
    for node in Graph.nodes
        second_NN[node.name] = adjacent(node)[2][2]
    end

    index = sort(collect(second_NN), by=x->x[2], rev=true)[1][1]
    source = Graph.nodes[findfirst(x->x.name == index, Graph.nodes)]
    return source
end






