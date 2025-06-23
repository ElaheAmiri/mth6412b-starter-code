"""Abstract type from which other types of edges will derive."""
abstract type AbstractEdge{T} end

"""Type representing an edge as a set of nodes.

Exemple :
    node1 = Node("1", 3.14)
    node2 = Node("2", exp(1))
    E = Edge("(1,2)", edges_weight[1,2], (node1 , node2))

Be careful, all nodes must have data of the same type.
"""
mutable struct Edge{T} <: AbstractEdge{T}
  name::String
  weight::Float64  
  adjacentnodes::Tuple{Node{T},Node{T}}
end


# we assume that all edges deriving from AbstractEdge
# will have `weight` and` nodes` fields.

"""Returns the weight of the edge."""
weight(edge::AbstractEdge) = edge.weight

"""Returns the adjacent nodes of the edge."""
adjacentnodes(edge::AbstractEdge) = edge.adjacentnodes


"""Display an edge"""
function show(edge::Edge)
  println("Between Node ", name(edge.adjacentnodes[1]), " and Node ", name(edge.adjacentnodes[2]), " edge weight ", edge.weight)
end
