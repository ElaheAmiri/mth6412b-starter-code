using Test
include("../graph.jl")
include("../read_stsp.jl")


filename_stsp = "pa561.tsp"
root = normpath(joinpath(@__FILE__,"..","..",".."))
filepath_to_stsp = "instances\\stsp"
filepath = joinpath(root, filepath_to_stsp) 
filepath = joinpath(filepath, filename_stsp) 

my_graph = Graph{Vector{Float64}}() #The type of data containted in a node is a vector, (x,y) coordinate
graph_nodes, graph_edges, edges_weight = read_stsp(filepath)
create_graph!(my_graph, graph_nodes,graph_edges, edges_weight)


@test nb_nodes(my_graph) == 561  # test that all nodes I've been added to the graph
@test nb_edges(my_graph) == sum(1:1:561)


filename_stsp = "bayg29.tsp"
root = normpath(joinpath(@__FILE__,"..","..",".."))
filepath_to_stsp = "instances\\stsp"
filepath = joinpath(root, filepath_to_stsp) 
filepath = joinpath(filepath, filename_stsp) 

my_graph = Graph{Vector{Float64}}() #The type of data containted in a node is a vector, (x,y) coordinate
graph_nodes, graph_edges, edges_weight = read_stsp(filepath)
create_graph!(my_graph, graph_nodes,graph_edges, edges_weight)


@test nb_nodes(my_graph) == 29  # test that all nodes I've been added to the graph
@test nb_edges(my_graph) == sum(1:1:28)


filename_stsp = "brazil58.tsp"
root = normpath(joinpath(@__FILE__,"..","..",".."))
filepath_to_stsp = "instances\\stsp"
filepath = joinpath(root, filepath_to_stsp) 
filepath = joinpath(filepath, filename_stsp) 

my_graph = Graph{Vector{Float64}}() #The type of data containted in a node is a vector, (x,y) coordinate
graph_nodes, graph_edges, edges_weight = read_stsp(filepath)
create_graph!(my_graph, graph_nodes,graph_edges, edges_weight)


@test nb_nodes(my_graph) == 58  # test that all nodes I've been added to the graph
@test nb_edges(my_graph) == sum(1:1:57)



#= x = 3.14  # add and remove one element
push!(s, x)
@test length(s) == 1
@test top(s) == x
@test pop!(s) == x

@test is_empty(s)  # stack should now be empty
@test_throws ArgumentError pop!(s)
@test_throws BoundsError top(s)

for i = 1 : 5  # add a few elements and test length
    push!(s, rand())
end
@test length(s) == 4 =#