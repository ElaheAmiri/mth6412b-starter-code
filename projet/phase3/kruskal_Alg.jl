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
function Make_set(node::MarkedNode{T}, DS::DisjointSets) where T
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

"""The function Union_sets is used to join two trees"""

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
function Kruskal(Graph::MarkedGraph{T}) where T
    W = 0.0
    DS = DisjointSets(Dict(), Dict())

    MST_nodes = MarkedNode{Array{Float64,1}}[]
    MST_edges = MarkedEdge{Array{Float64,1}}[]


    for node in Graph.nodes
        Make_set(node, DS)
    end
    Edge_sort = sort(Graph.edges, by = x -> x.weight)
    for edge in Edge_sort
        root1 = find_set(edge.adjacentnodes[1].name, DS)
        root2 = find_set(edge.adjacentnodes[2].name, DS)
        if root1 != root2
            push!(MST_edges, edge)
            W = W + edge.weight
            Union_sets(root1, root2, DS)
        end
    end
    MST = MarkedGraph("MSTGraph_", MST_nodes, MST_edges) 
    for edge in MST.edges
        if !(edge.adjacentnodes[1] in MST.nodes)
            add_markednode!(MST, edge.adjacentnodes[1])
        end
        if !(edge.adjacentnodes[2] in MST.nodes)
            add_markednode!(MST, edge.adjacentnodes[2])
        end
    end
    MST_Graph = deepcopy(MST)
    for node in MST_Graph.nodes
        empty!(node.adjacents)
    end
    for edge in MST_Graph.edges
        add_adj_node!(edge.adjacentnodes[1], edge.adjacentnodes[2], edge.weight)
        add_adj_node!(edge.adjacentnodes[2], edge.adjacentnodes[1], edge.weight)
    end
    return W, MST_Graph
end

