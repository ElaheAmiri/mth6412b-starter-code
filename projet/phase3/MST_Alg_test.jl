using Test

include("../node.jl")
include("../edge.jl")
include("../graph.jl")
include("../read_stsp.jl")

include("marked_node.jl")
include("marked_edge.jl")
include("marked_graph.jl")
include("Prime_Alg.jl")
include("kruskal_Alg.jl")



"""Prime algorithm struct tests"""
P_Q = PriorityQueue(MarkedNode{Array{Float64,1}}[])
@test is_empty(P_Q)

new_node1 = MarkedNode("1", [10.0,20.0], false, 7.0, nothing, Dict())
new_node2 = MarkedNode("2", [5.0,9.0], false, 2.0, nothing, Dict())
new_node3 = MarkedNode("3", [8.0,25.0], false, 6.0, nothing, Dict())

enqueue!(P_Q, new_node1)
enqueue!(P_Q, new_node2)
enqueue!(P_Q, new_node3)

# Verify that each enqueue function has added one item to the priotity queue
@test length(P_Q.items) == 3

# Verify that dequeue function is selecting the item with highest priority (lowest min_weight)
@test dequeue!(P_Q) == new_node2
@test dequeue!(P_Q) == new_node3
@test dequeue!(P_Q) == new_node1

# the priority queue should be empty after all dequeue (lowest min_weight)
@test is_empty(P_Q)

"""kruskal algorithm struct tests"""
DS = DisjointSets(Dict(), Dict())
Make_set(new_node1, DS)
Make_set(new_node2, DS)

#verify that Make_set is assighning right parent and rank 
@test DS.parent["1"]==new_node1.name
@test DS.rank["1"]==0

@test_throws KeyError DS.parent["3"]

#verify that find set can find the root of disjoint set
@test find_set(new_node2.name, DS)=="2"

root1 = find_set(new_node1.name, DS)
root2 = find_set(new_node2.name, DS)
Union_sets(root1, root2, DS)

#verify that after union of two disjoint sets with the same rank, rank of one of them(here first one) increased by on
@test DS.rank["1"]==1
@test DS.rank["2"]==0
@test find_set(new_node2.name, DS)=="1"


"""Test and compare both methods (Prim and kruskal)"""

# -----bayg29.tsp ------
filename_stsp = "bayg29.tsp"
root = normpath(joinpath(@__FILE__,"..","..",".."))
filepath_to_stsp = "instances\\stsp"
filepath = joinpath(root, filepath_to_stsp) 
filepath = joinpath(filepath, filename_stsp) 

header = read_header(filepath)
graph_nodes, graph_edges, edges_weight = read_stsp(filepath)
Main_Graph = MarkedGraph("Graph_"*header["NAME"], MarkedNode{Array{Float64,1}}[], MarkedEdge{Array{Float64,1}}[]) 
create_MarkedGraph!(Main_Graph, graph_nodes, graph_edges, edges_weight)

W1, Prime_MST = Prime_Algo(Main_Graph, Main_Graph.nodes[1])
W2, Kruskal_MST = Kruskal(Main_Graph)

@test W1 == W2


# -----bays29.tsp ------
filename_stsp = "bays29.tsp"
root = normpath(joinpath(@__FILE__,"..","..",".."))
filepath_to_stsp = "instances\\stsp"
filepath = joinpath(root, filepath_to_stsp) 
filepath = joinpath(filepath, filename_stsp) 

header = read_header(filepath)
graph_nodes, graph_edges, edges_weight = read_stsp(filepath)
Main_Graph = MarkedGraph("Graph_"*header["NAME"], MarkedNode{Array{Float64,1}}[], MarkedEdge{Array{Float64,1}}[]) 
create_MarkedGraph!(Main_Graph, graph_nodes, graph_edges, edges_weight)

W1, Prime_MST = Prime_Algo(Main_Graph, Main_Graph.nodes[1])
W2, Kruskal_MST = Kruskal(Main_Graph)

@test W1 == W2

# -----brazil58.tsp ------
filename_stsp = "brazil58.tsp"
root = normpath(joinpath(@__FILE__,"..","..",".."))
filepath_to_stsp = "instances\\stsp"
filepath = joinpath(root, filepath_to_stsp) 
filepath = joinpath(filepath, filename_stsp) 

header = read_header(filepath)
graph_nodes, graph_edges, edges_weight = read_stsp(filepath)
Main_Graph = MarkedGraph("Graph_"*header["NAME"], MarkedNode{Array{Float64,1}}[], MarkedEdge{Array{Float64,1}}[]) 
create_MarkedGraph!(Main_Graph, graph_nodes, graph_edges, edges_weight)

W1, Prime_MST = Prime_Algo(Main_Graph, Main_Graph.nodes[1])
W2, Kruskal_MST = Kruskal(Main_Graph)

@test W1 == W2


# -----brg180.tsp ------
filename_stsp = "brg180.tsp"
root = normpath(joinpath(@__FILE__,"..","..",".."))
filepath_to_stsp = "instances\\stsp"
filepath = joinpath(root, filepath_to_stsp) 
filepath = joinpath(filepath, filename_stsp) 

header = read_header(filepath)
graph_nodes, graph_edges, edges_weight = read_stsp(filepath)
Main_Graph = MarkedGraph("Graph_"*header["NAME"], MarkedNode{Array{Float64,1}}[], MarkedEdge{Array{Float64,1}}[]) 
create_MarkedGraph!(Main_Graph, graph_nodes, graph_edges, edges_weight)

W1, Prime_MST = Prime_Algo(Main_Graph, Main_Graph.nodes[1])
W2, Kruskal_MST = Kruskal(Main_Graph)

@test W1 == W2


# -----dantzig42.tsp ------
filename_stsp = "dantzig42.tsp"
root = normpath(joinpath(@__FILE__,"..","..",".."))
filepath_to_stsp = "instances\\stsp"
filepath = joinpath(root, filepath_to_stsp) 
filepath = joinpath(filepath, filename_stsp) 

header = read_header(filepath)
graph_nodes, graph_edges, edges_weight = read_stsp(filepath)
Main_Graph = MarkedGraph("Graph_"*header["NAME"], MarkedNode{Array{Float64,1}}[], MarkedEdge{Array{Float64,1}}[]) 
create_MarkedGraph!(Main_Graph, graph_nodes, graph_edges, edges_weight)

W1, Prime_MST = Prime_Algo(Main_Graph,  Main_Graph.nodes[1])
W2, Kruskal_MST = Kruskal(Main_Graph)

@test W1 == W2


# -----fri26.tsp ------
filename_stsp = "fri26.tsp"
root = normpath(joinpath(@__FILE__,"..","..",".."))
filepath_to_stsp = "instances\\stsp"
filepath = joinpath(root, filepath_to_stsp) 
filepath = joinpath(filepath, filename_stsp) 

header = read_header(filepath)
graph_nodes, graph_edges, edges_weight = read_stsp(filepath)
Main_Graph = MarkedGraph("Graph_"*header["NAME"], MarkedNode{Array{Float64,1}}[], MarkedEdge{Array{Float64,1}}[]) 
create_MarkedGraph!(Main_Graph, graph_nodes, graph_edges, edges_weight)

W1, Prime_MST = Prime_Algo(Main_Graph, Main_Graph.nodes[1])
W2, Kruskal_MST = Kruskal(Main_Graph)

@test W1 == W2


# -----gr17.tsp ------
filename_stsp = "gr17.tsp"
root = normpath(joinpath(@__FILE__,"..","..",".."))
filepath_to_stsp = "instances\\stsp"
filepath = joinpath(root, filepath_to_stsp) 
filepath = joinpath(filepath, filename_stsp) 

header = read_header(filepath)
graph_nodes, graph_edges, edges_weight = read_stsp(filepath)
Main_Graph = MarkedGraph("Graph_"*header["NAME"], MarkedNode{Array{Float64,1}}[], MarkedEdge{Array{Float64,1}}[]) 
create_MarkedGraph!(Main_Graph, graph_nodes, graph_edges, edges_weight)

W1, Prime_MST = Prime_Algo(Main_Graph, Main_Graph.nodes[1])
W2, Kruskal_MST = Kruskal(Main_Graph)

@test W1 == W2



# -----gr21.tsp ------
filename_stsp = "gr21.tsp"
root = normpath(joinpath(@__FILE__,"..","..",".."))
filepath_to_stsp = "instances\\stsp"
filepath = joinpath(root, filepath_to_stsp) 
filepath = joinpath(filepath, filename_stsp) 

header = read_header(filepath)
graph_nodes, graph_edges, edges_weight = read_stsp(filepath)
Main_Graph = MarkedGraph("Graph_"*header["NAME"], MarkedNode{Array{Float64,1}}[], MarkedEdge{Array{Float64,1}}[]) 
create_MarkedGraph!(Main_Graph, graph_nodes, graph_edges, edges_weight)

W1, Prime_MST = Prime_Algo(Main_Graph, Main_Graph.nodes[1])
W2, Kruskal_MST = Kruskal(Main_Graph)

@test W1 == W2



# -----gr24.tsp ------
filename_stsp = "gr24.tsp"
root = normpath(joinpath(@__FILE__,"..","..",".."))
filepath_to_stsp = "instances\\stsp"
filepath = joinpath(root, filepath_to_stsp) 
filepath = joinpath(filepath, filename_stsp) 

header = read_header(filepath)
graph_nodes, graph_edges, edges_weight = read_stsp(filepath)
Main_Graph = MarkedGraph("Graph_"*header["NAME"], MarkedNode{Array{Float64,1}}[], MarkedEdge{Array{Float64,1}}[]) 
create_MarkedGraph!(Main_Graph, graph_nodes, graph_edges, edges_weight)

W1, Prime_MST = Prime_Algo(Main_Graph, Main_Graph.nodes[1])
W2, Kruskal_MST = Kruskal(Main_Graph)

@test W1 == W2



# -----gr48.tsp ------
filename_stsp = "gr48.tsp"
root = normpath(joinpath(@__FILE__,"..","..",".."))
filepath_to_stsp = "instances\\stsp"
filepath = joinpath(root, filepath_to_stsp) 
filepath = joinpath(filepath, filename_stsp) 

header = read_header(filepath)
graph_nodes, graph_edges, edges_weight = read_stsp(filepath)
Main_Graph = MarkedGraph("Graph_"*header["NAME"], MarkedNode{Array{Float64,1}}[], MarkedEdge{Array{Float64,1}}[]) 
create_MarkedGraph!(Main_Graph, graph_nodes, graph_edges, edges_weight)

W1, Prime_MST = Prime_Algo(Main_Graph, Main_Graph.nodes[1])
W2, Kruskal_MST = Kruskal(Main_Graph)

@test W1 == W2



# -----gr120.tsp ------
filename_stsp = "gr120.tsp"
root = normpath(joinpath(@__FILE__,"..","..",".."))
filepath_to_stsp = "instances\\stsp"
filepath = joinpath(root, filepath_to_stsp) 
filepath = joinpath(filepath, filename_stsp) 

header = read_header(filepath)
graph_nodes, graph_edges, edges_weight = read_stsp(filepath)
Main_Graph = MarkedGraph("Graph_"*header["NAME"], MarkedNode{Array{Float64,1}}[], MarkedEdge{Array{Float64,1}}[]) 
create_MarkedGraph!(Main_Graph, graph_nodes, graph_edges, edges_weight)

W1, Prime_MST = Prime_Algo(Main_Graph, Main_Graph.nodes[1])
W2, Kruskal_MST = Kruskal(Main_Graph)

@test W1 == W2



# -----hk48.tsp ------
filename_stsp = "hk48.tsp"
root = normpath(joinpath(@__FILE__,"..","..",".."))
filepath_to_stsp = "instances\\stsp"
filepath = joinpath(root, filepath_to_stsp) 
filepath = joinpath(filepath, filename_stsp) 

header = read_header(filepath)
graph_nodes, graph_edges, edges_weight = read_stsp(filepath)
Main_Graph = MarkedGraph("Graph_"*header["NAME"], MarkedNode{Array{Float64,1}}[], MarkedEdge{Array{Float64,1}}[]) 
create_MarkedGraph!(Main_Graph, graph_nodes, graph_edges, edges_weight)

W1, Prime_MST = Prime_Algo(Main_Graph, Main_Graph.nodes[1])
W2, Kruskal_MST = Kruskal(Main_Graph)

@test W1 == W2



# -----pa561.tsp.tsp ------
filename_stsp = "pa561.tsp"
root = normpath(joinpath(@__FILE__,"..","..",".."))
filepath_to_stsp = "instances\\stsp"
filepath = joinpath(root, filepath_to_stsp) 
filepath = joinpath(filepath, filename_stsp) 

header = read_header(filepath)
graph_nodes, graph_edges, edges_weight = read_stsp(filepath)
Main_Graph = MarkedGraph("Graph_"*header["NAME"], MarkedNode{Array{Float64,1}}[], MarkedEdge{Array{Float64,1}}[]) 
create_MarkedGraph!(Main_Graph, graph_nodes, graph_edges, edges_weight)

W1, Prime_MST = Prime_Algo(Main_Graph, Main_Graph.nodes[1])
W2, Kruskal_MST = Kruskal(Main_Graph)

@test W1 == W2



# -----swiss42.tsp ------
filename_stsp = "swiss42.tsp"
root = normpath(joinpath(@__FILE__,"..","..",".."))
filepath_to_stsp = "instances\\stsp"
filepath = joinpath(root, filepath_to_stsp) 
filepath = joinpath(filepath, filename_stsp) 

header = read_header(filepath)
graph_nodes, graph_edges, edges_weight = read_stsp(filepath)
Main_Graph = MarkedGraph("Graph_"*header["NAME"], MarkedNode{Array{Float64,1}}[], MarkedEdge{Array{Float64,1}}[]) 
create_MarkedGraph!(Main_Graph, graph_nodes, graph_edges, edges_weight)

W1, Prime_MST = Prime_Algo(Main_Graph, Main_Graph.nodes[1])
W2, Kruskal_MST = Kruskal(Main_Graph)

@test W1 == W2
