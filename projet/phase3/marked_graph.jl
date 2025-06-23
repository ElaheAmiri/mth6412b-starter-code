import Base.show
include("marked_node.jl")
include("marked_edge.jl")


"""Type representant un graphe comme un ensemble de noeuds.

"""
mutable struct MarkedGraph{T} <: AbstractGraph{T}
  name::String
  nodes::Vector{MarkedNode{T}}
  edges::Vector{MarkedEdge{T}}
end

"""Let's you instanciate an empty graph"""
MarkedGraph{T}() where T = MarkedGraph("", MarkedNode{T}[], MarkedEdge{T}[]) 

"""Adds a node to the graph."""
function add_markednode!(graph::MarkedGraph{T}, node::MarkedNode{T}) where T
  push!(graph.nodes, node)
  graph
end


"""Adds an edge to the graph."""
function add_markededge!(graph::MarkedGraph{T} where T, edge::MarkedEdge{T} where T) 
  push!(graph.edges, edge)
  graph
end



function create_MarkedGraph!(graph::MarkedGraph, graph_nodes::Dict{Int64,Vector{Float64}},graph_edges::Array{Any,1}, edges_weight::Dict{Tuple{Int64,Int64},Float64})
    T = valtype(graph_nodes)
    for k = 1 : length(graph_edges)
        if isempty(graph_nodes)
            new_node = MarkedNode{T}(string(k), T(), false, Inf, nothing, Dict())
        else
            new_node = MarkedNode(string(k), graph_nodes[k], false, Inf, nothing, Dict())
        end
        add_markednode!(graph, new_node)
    end
    for k = 1 : length(graph_edges)
        for j in graph_edges[k]
            edge_name = "("*string(k)*","*string(j)*")"
            add_adj_node!(graph.nodes[k], graph.nodes[j], edges_weight[k,j])
            add_adj_node!(graph.nodes[j], graph.nodes[k], edges_weight[k,j])
            new_edge = MarkedEdge(edge_name, edges_weight[k,j], (graph.nodes[k] , graph.nodes[j]))
            add_markededge!(graph, new_edge)
        end
    end
end



function plot_markedgraph(graph::MarkedGraph)

    fig = plot(legend=false)
  
    # edge positions
    for edge in graph.edges
        plot!([edge.adjacentnodes[1].data[1], edge.adjacentnodes[2].data[1]],
        [edge.adjacentnodes[1].data[2], edge.adjacentnodes[2].data[2]],
            linewidth=1.5, alpha=0.75, color=:lightgray)
    end
  
    # node positions
    xys = graph.nodes
    x = [xy.data[1] for xy in xys]
    y = [xy.data[2] for xy in xys]
    scatter!(x, y)
  
    fig
  end

# function to get the weight of a particular edge with its name
function graph_edgeweight(Graph::MarkedGraph, node1::MarkedNode, node2::MarkedNode)
    weight = 0.0
    try
        name1 = "("*node1.name*","*node2.name*")"
        weight = Graph.edges[findfirst(x->x.name == name1, Graph.edges)].weight
    catch
        name2 = "("*node2.name*","*node1.name*")"
        weight = Graph.edges[findfirst(x->x.name == name2, Graph.edges)].weight
    end
    return weight
end


function create_img_Graph!(graph::MarkedGraph, graph_nodes::Dict{Int64,Vector{Float64}},graph_edges::Array{Any,1}, edges_weight::Dict{Tuple{Int64,Int64},Float64})
    T = valtype(graph_nodes)
    for k = 1 : length(graph_edges)
        new_node = MarkedNode{T}(string(k), [k], false, Inf, nothing, Dict())
        add_markednode!(graph, new_node)
    end
    for k = 1 : length(graph_edges)
        for j in graph_edges[k]
            edge_name = "("*string(k)*","*string(j)*")"
            add_adj_node!(graph.nodes[k], graph.nodes[j], edges_weight[k,j])
            add_adj_node!(graph.nodes[j], graph.nodes[k], edges_weight[k,j])
            new_edge = MarkedEdge(edge_name, edges_weight[k,j], (graph.nodes[k] , graph.nodes[j]))
            add_markededge!(graph, new_edge)
        end
    end
end