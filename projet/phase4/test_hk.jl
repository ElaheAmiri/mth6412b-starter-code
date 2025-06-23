using Test

include("../node.jl")
include("../edge.jl")
include("../graph.jl")
include("../read_stsp.jl")

include("../phase3/marked_node.jl")
include("../phase3/marked_edge.jl")
include("../phase3/marked_graph.jl")
include("../phase3/Prime_Alg.jl")
include("../phase3/kruskal_Alg.jl")

include("one_tree.jl")
include("TSP_hk.jl")
include("TSP_rsl.jl")

#Use these values to compore solutions to optimality
opt_tour = Dict()
opt_tour["bayg29.tsp"]= 1610
opt_tour["bays29.tsp"]= 2020
opt_tour["brazil58.tsp"]= 25395
opt_tour["dantzig42.tsp"]= 699
opt_tour["fri26.tsp"]= 937
opt_tour["gr17.tsp"]= 2085
opt_tour["gr21.tsp"]= 2707
opt_tour["gr24.tsp"]= 1272
opt_tour["gr48.tsp"]= 5046
opt_tour["gr120.tsp"]= 6942
opt_tour["hk48.tsp"]= 11461
opt_tour["swiss42.tsp"]= 1273


"""Test HK algorithm on instances and calculate the error"""
i=0
W = zeros(length(opt_tour))
errors = Dict()

for (key, value) in opt_tour
  global i+=1
  filename_stsp = key
  root = normpath(joinpath(@__FILE__,"..","..",".."))
  filepath_to_stsp = "instances\\stsp"
  filepath = joinpath(root, filepath_to_stsp) 
  filepath = joinpath(filepath, filename_stsp) 

  header = read_header(filepath)
  graph_nodes, graph_edges, edges_weight = read_stsp(filepath)
  Main_Graph = MarkedGraph("Graph_"*header["NAME"], MarkedNode{Array{Float64,1}}[], MarkedEdge{Array{Float64,1}}[]) 
  create_MarkedGraph!(Main_Graph, graph_nodes, graph_edges, edges_weight)

  W1, TSP_Graph, Π = HK_MST(Main_Graph, 2 , Main_Graph.nodes[4], 4, 2000)
  errors[key] = (W1-value)/value

end
println("the error gap between the achived result and best found result is:")
for (key, value) in opt_tour
    println(key, " : ", errors[key])
end
    