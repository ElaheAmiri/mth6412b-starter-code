include("../node.jl")
include("../edge.jl")
include("../graph.jl")
include("../read_stsp.jl")
include("../disjoint_set.jl")

filename_stsp = "bayg29.tsp"
root = normpath(joinpath(@__FILE__,"..","..",".."))
filepath_to_stsp = "instances\\stsp"
filepath = joinpath(root, filepath_to_stsp) 
filepath = joinpath(filepath, filename_stsp) 

"""Reading data form data files"""
header = read_header(filepath)

graph_nodes, graph_edges, edges_weight = read_stsp(filepath)

"""Creating the Graph form the data"""
Main_Graph = Graph{Vector{Float64}}() 
create_graph!(Main_Graph, graph_nodes, graph_edges, edges_weight)


my_disjoint_set = DisjointSet{Vector{Float64}}()

create_disjointSet!(my_disjoint_set, Main_Graph)

A = sort(Main_Graph.edges, by = x -> x.weight)

for a in A
  if is_arc_disjoint(my_disjoint_set,a)
    union_disjoint_set(my_disjoint_set, a )
  end
end

print("Hello")
plot_subgraph(Main_Graph, edges(my_disjoint_set))
savefig("tree_bayg29_v2.pdf")

println(sum(x->x.weight,edges(my_disjoint_set)))
println(edges(my_disjoint_set))
println(nodes(my_disjoint_set))