using Test
include("../disjoint_set.jl")
include("../graph.jl")
include("../read_stsp.jl")

filename_stsp = "bayg29.tsp"
root = normpath(joinpath(@__FILE__,"..","..",".."))
filepath_to_stsp = "instances\\stsp"
filepath = joinpath(root, filepath_to_stsp) 
filepath = joinpath(filepath, filename_stsp) 

my_graph = Graph{Vector{Float64}}() #The type of data containted in a node is a vector, (x,y) coordinate
graph_nodes, graph_edges, edges_weight = read_stsp(filepath)
create_graph!(my_graph, graph_nodes,graph_edges, edges_weight)

my_disjoint_set = DisjointSet{Vector{Float64}}()
create_disjointSet!(my_disjoint_set, my_graph)

# Verify that the number of sets is equal to the number of nodes at first
@test length(my_disjoint_set.dict_sets) == length(my_graph.nodes)

#Every edge should be disjoint_set
for a in my_graph.edges
  @test is_arc_disjoint(my_disjoint_set,a)
end

#Apply Kruskal Algo
A = sort(my_graph.edges, by = x -> x.weight)

for a in A
  if is_arc_disjoint(my_disjoint_set,a)
    union_disjoint_set(my_disjoint_set, a )
  end
end

#The number of edges should be the number of nodes minus one
@test length(edges(my_disjoint_set)) == length(my_graph.nodes)-1