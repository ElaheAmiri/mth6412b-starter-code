import Base.show
include("node.jl")
include("edge.jl")
include("graph.jl")

"""Type abstrait dont d'autres types d'ensemble dériveront."""
abstract type AbstractDisjointSet{T} end

"""Type representant les composantes connexes d'un graphe.

Exemple :
my_disjoint_set = DisjointSet{Vector{Float64}}()
create_disjointSet!(my_disjoint_set, Main_Graph)

Each nodes will point to the name of the set, to a set of nodes and to a set of edges
"""
mutable struct DisjointSet{T} <: AbstractDisjointSet{T}
  dict_sets::Dict{String, Tuple{String, Set{Node{T}}, Set{Edge{T}}}}
end
                                                                                                                                                                                                                                                                                                                                              
"""Creation of an empty disjoint sets"""
DisjointSet{T}() where T = DisjointSet(Dict{String,Tuple{String, Set{Node{T}}, Set{Edge{T}}}}())

"""Creation of disjoint sets from a graph"""
function create_disjointSet!(disjointset::DisjointSet{T}, graph::Graph{T}) where T 
  #At first, each node has its own set
  for node in graph.nodes
    disjointset.dict_sets[node.name] = (node.name, Set([node]), Set(Edge{T}[])) 
  end
end

"""Returns the edges"""
edges(disjointset::DisjointSet{T}) where T = collect(values(disjointset.dict_sets))[1][3]

"""Returns the nodes"""
nodes(disjointset::DisjointSet{T}) where T = collect(values(disjointset.dict_sets))[1][2]

"""Find the name of the set of the node"""
function find_root(disjointset::DisjointSet{T},node::Node{T}) where T
  disjointset.dict_sets[node.name][1]
end

"""Return true if the two nodes of the edge are form two different sets"""
function is_arc_disjoint(disjointset::DisjointSet{T},edge::Edge{T}) where T
  return(find_root(disjointset,edge.adjacentnodes[1]) != find_root(disjointset,edge.adjacentnodes[2]))
end

"""Merge the two sets together based on the edge that join them """
function union_disjoint_set(disjointset::DisjointSet{T}, new_edge::Edge{T} ) where T
  node_name=new_edge.adjacentnodes[1].name
  node_name2=new_edge.adjacentnodes[2].name
  
  # The new sets includes all the nodes of the two sets
  New_Set = union(disjointset.dict_sets[node_name][2],
  disjointset.dict_sets[node_name2][2])
  #The new set includes all of the edges of the two sets
  New_Set_Edges = union(disjointset.dict_sets[node_name][3],
  disjointset.dict_sets[node_name2][3])
  #The new set also include the new edge
  New_Set_Edges = union(New_Set_Edges, Set([new_edge]))
  #The new set will be name base on the name of the first set
  New_Set_Name = disjointset.dict_sets[node_name][1]
  
  #update the information of all nodes that are part of the new set
  for element in New_Set
    disjointset.dict_sets[element.name]=  (New_Set_Name, New_Set, New_Set_Edges)
  end
end