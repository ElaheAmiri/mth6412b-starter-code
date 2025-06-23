include("marked_node.jl")

mutable struct MarkedEdge{T} <: AbstractEdge{T}
    name::String
    weight::Float64  
    adjacentnodes::Tuple{MarkedNode{T},MarkedNode{T}}
end
  
  
  
"""Display an edge"""
function show(edge::MarkedEdge)
    println("Between Node ", name(edge.adjacentnodes[1]), " and Node ", name(edge.adjacentnodes[2]), " edge weight ", edge.weight)
 end