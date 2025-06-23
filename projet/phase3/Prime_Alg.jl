import Base.show

include("marked_node.jl")
include("marked_edge.jl")
include("marked_graph.jl")


import Base.show


"""Structure for Priority list """
mutable struct PriorityQueue{T}
    items::Vector{MarkedNode{T}}
end

PriorityQueue{T}() where T = PriorityQueue(T[])

"""function to select the item with the highest priority(lowest min_weight) """
function dequeue!(q::PriorityQueue)
    highest = q.items[1]
    for item in q.items[2:end]
        if item.min_weight < highest.min_weight
            highest = item
        end
    end
    idx = findall(x -> x == highest, q.items)[1]
    deleteat!(q.items, idx)
    highest
end

"""function to add items to the priority list """
function enqueue!(q::PriorityQueue, item::MarkedNode{T}) where T
    push!(q.items, item)
    q
end


is_empty(q::PriorityQueue) = length(q.items) == 0

"""Prime Algorithm function """
function Prime_Algo(graph::MarkedGraph{T}, source::MarkedNode{T}) where T
    W = 0.0
    PQ = PriorityQueue(MarkedNode{Array{Float64,1}}[])
    MST = MarkedNode{Array{Float64,1}}[]    
    
    for node in graph.nodes
        U = deepcopy(node)
        if U.name == source.name
            set_min_weight!(U, 0.0)
            set_parent!(U, U)
        end
        empty!(U.adjacents)
        enqueue!(PQ, U)
    end
    
    edges_weight = Dict{Tuple{Int64,Int64}}{Float64}()
    for edge in graph.edges
        edges_weight[parse(Int64, edge.adjacentnodes[1].name) , parse(Int64, edge.adjacentnodes[2].name)]=edge.weight
        edges_weight[parse(Int64, edge.adjacentnodes[2].name) , parse(Int64, edge.adjacentnodes[1].name)]=edge.weight
    end
    
    while !is_empty(PQ)
        V = dequeue!(PQ)
        set_visited!(V)
        push!(MST,V)
        W = W + V.min_weight
        for U in PQ.items
            if haskey(edges_weight,(parse(Int64, V.name) , parse(Int64, U.name)))
                if U.visited == false && U.min_weight > edges_weight[parse(Int64, V.name) , parse(Int64, U.name)]
                    U.min_weight = edges_weight[parse(Int64, V.name) , parse(Int64, U.name)]
                    set_parent!(U, V)
                end
            end
        end                
    end
    #*header["NAME"]
    MST_Graph = MarkedGraph("MSTGraph_", MST, MarkedEdge{Array{Float64,1}}[]) 
    for node in MST[2:end]
        edge_name = "("*node.parent.name*","*node.name*")"
        new_edge = MarkedEdge(edge_name, node.min_weight, (node.parent , node))
        add_adj_node!(node.parent, node, node.min_weight)
        add_adj_node!(node, node.parent, node.min_weight)
        add_markededge!(MST_Graph, new_edge)
    end    
    return W, MST_Graph
end




function plot_MST(MST::Vector{MarkedNode{T}}) where T

    fig = plot(legend=false)
  
    # edge positions
    for node in MST[2:end]
        plot!([node.data[1], node.parent.data[1]],
        [node.data[2], node.parent.data[2]],
        linewidth=1.5, alpha=0.75, color=:lightgray)
    end
  
    # node positions
    x = [xy.data[1] for xy in MST]
    y = [xy.data[2] for xy in MST]
    scatter!(x, y)
  
    fig
  end