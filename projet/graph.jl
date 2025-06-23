import Base.show
include("node.jl")
include("edge.jl")

"""Type abstrait dont d'autres types de graphes dériveront."""
abstract type AbstractGraph{T} end

"""Type representant un graphe comme un ensemble de noeuds.

Exemple :

    node1 = Node("Joe", 3.14)
    node2 = Node("Steve", exp(1))
    node3 = Node("Jill", 4.12)
    G = Graph("Ick", [node1, node2, node3])

Attention, tous les noeuds doivent avoir des données de même type.
"""
mutable struct Graph{T} <: AbstractGraph{T}
  name::String
  nodes::Vector{Node{T}}
  edges::Vector{Edge{T}}
end

"""Let's you instanciate an empty graph"""
Graph{T}() where T = Graph("", Node{T}[], Edge{T}[]) 

"""Adds a node to the graph."""
function add_node!(graph::Graph{T}, node::Node{T}) where T
  push!(graph.nodes, node)
  graph
end

"""Adds an edge to the graph."""
function add_edge!(graph::Graph{T} where T, edge::Edge{T} where T) 
  push!(graph.edges, edge)
  graph
end


# we assume that all graphs deriving from AbstractGraph
# will have fields `name` and `nodes`.

"""Returns the name of the graph."""
name(graph::AbstractGraph) = graph.name

"""Returns the list of nodes of the graph."""
nodes(graph::AbstractGraph) = graph.nodes

"""Returns the number of nodes in the graph."""
nb_nodes(graph::AbstractGraph) = length(graph.nodes)

"""Returns the list of edges of the graph."""
edges(graph::AbstractGraph) = graph.edges

"""Returns the number of edges in the graph."""
nb_edges(graph::AbstractGraph) = length(graph.edges)

"""Display a graph"""
function show(graph::Graph)
  println("Graph ", name(graph), " has ", nb_nodes(graph), " nodes.")
  for node in nodes(graph)
    show(node)
  end
  println("Graph ", name(graph), " has ", nb_edges(graph), " edges.")
  for edge in edges(graph)
    show(edge)
  end
end

function create_graph!(graph::Graph, graph_nodes::Dict{Int64,Vector{Float64}},graph_edges::Array{Any,1}, edges_weight::Dict{Tuple{Int64,Int64},Float64})
   T = valtype(graph_nodes)
   for k = 1 : length(graph_edges)
       if isempty(graph_nodes)
       new_node1 = Node{T}(string(k),T())
     else
          new_node1 = Node(string(k),graph_nodes[k])
     end
       add_node!(graph, new_node1)
       for j in graph_edges[k]
           if isempty(graph_nodes)
           new_node2 = Node{T}(string(j),T())
         else
           new_node2 = Node(string(j),graph_nodes[j])
         end
           edge_name = "("*string(k)*","*string(j)*")"
           new_edge = Edge(edge_name, edges_weight[k,j], (new_node1 , new_node2))
           add_edge!(graph, new_edge)
       end
   end
end


function plot_subgraph(graph::Graph,subset_edges::Set)

  fig = plot(legend=false)

  # edge positions
  for edge in subset_edges
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