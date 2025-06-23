using Markdown
using InteractiveUtils

include("../node.jl")
include("../edge.jl")
include("../graph.jl")
include("../read_stsp.jl")


"""Data structure representing disjoint sets
Exemple :
    parent = Dict("1"=> "2", "2" => "2") each node points to its parent
    rank = Dict("1"=> 0, "2" => 2) 

"""

mutable struct DisjointSets
    parent::Dict{Any,Any}
    rank::Dict{Any,Any}
end

"""The function Make_set is used to create a tree for each node which has just one element and zero rank"""
function Make_set(node::Node{T}, DS::DisjointSets) where T
    DS.parent[node.name] = node.name
    DS.rank[node.name] = 0
end

"""The function find_set is used to find the the realted tree of a node and return the root of the tree """

function find_set(node_name::String, DS::DisjointSets) where T
    if DS.parent[node_name] == node_name
        DS.parent[node_name]
    else
        find_set(DS.parent[node_name],DS)
    end             
end

"""The function Union_sets is used to join twe trees"""

function Union_sets(Root_node1::String, Root_node2::String, DS::DisjointSets)
    if DS.rank[Root_node1] > DS.rank[Root_node2]
        DS.parent[Root_node2] = Root_node1
    elseif DS.rank[Root_node1] < DS.rank[Root_node2]
        DS.parent[Root_node1] = Root_node2
    else
        DS.parent[Root_node2] = Root_node1
        DS.rank[Root_node1] =+1
    end
end


"""The kruskal algorithm function"""
function Kruskal(Graph::Graph{T},Min_Span_Tree::Array{Edge{Array{Float64,1}},1},A::Set{Any}, W::Float64) where T

    DS = DisjointSets(Dict(), Dict())

    for node in Graph.nodes
        Make_set(node, DS)
    end
    Edge_sort = sort(Graph.edges, by = x -> x.weight)
    for edge in Edge_sort
        root1 = find_set(edge.adjacentnodes[1].name, DS)
        root2 = find_set(edge.adjacentnodes[2].name, DS)
        if root1 != root2
            push!(Min_Span_Tree, edge)
            union!(A, Set([edge]))
            W = W + edge.weight
            Union_sets(root1, root2, DS)
        end
    end
    return A,W
end






"""The main kruskal algorithm steps"""

filename_stsp = "bayg29.tsp"
root = normpath(joinpath(@__FILE__,"..","..",".."))
filepath_to_stsp = "instances\\stsp"
filepath = joinpath(root, filepath_to_stsp) 
filepath = joinpath(filepath, filename_stsp) 

"""Reading data form data files"""
header = read_header(filepath)

graph_nodes, graph_edges, edges_weight = read_stsp(filepath)

"""Creating the Graph form the data"""

Main_Graph = Graph("Graph_"*header["NAME"], Node{Array{Float64,1}}[], Edge{Array{Float64,1}}[]) 


create_graph!(Main_Graph, graph_nodes, graph_edges, edges_weight)



#DS = DisjointSets(Dict(), Dict())
Min_Span_Tree = Edge{Array{Float64,1}}[]
W = 0.0
A = Set()

A,W = Kruskal(Main_Graph,Min_Span_Tree,A,W)

println("The total weight of the solution is: ", W)

plot_subgraph(Main_Graph, A) 
