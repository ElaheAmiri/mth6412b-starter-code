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
#opt_tour["brg180.tsp"]= 1950
opt_tour["dantzig42.tsp"]= 699
opt_tour["fri26.tsp"]= 937
opt_tour["gr17.tsp"]= 2085
opt_tour["gr21.tsp"]= 2707
opt_tour["gr24.tsp"]= 1272
opt_tour["gr48.tsp"]= 5046
opt_tour["gr120.tsp"]= 6942
opt_tour["hk48.tsp"]= 11461
#opt_tour["pa561.tsp"]= 2763
opt_tour["swiss42.tsp"]= 1273


filename_stsp = "bayg29.tsp"
root = normpath(joinpath(@__FILE__,"..","..",".."))
filepath_to_stsp = "instances\\stsp"
filepath = joinpath(root, filepath_to_stsp) 
filepath = joinpath(filepath, filename_stsp) 

"""Reading data form data files"""
header = read_header(filepath)

graph_nodes, graph_edges, edges_weight = read_stsp(filepath)

"""Creating the marked Graph form the data"""

Main_Graph = MarkedGraph("Graph_"*header["NAME"], MarkedNode{Array{Float64,1}}[], MarkedEdge{Array{Float64,1}}[]) 
create_MarkedGraph!(Main_Graph, graph_nodes, graph_edges, edges_weight)

source1 = Calc_source(Main_Graph)
n = length(Main_Graph.nodes)
source2 = Main_Graph.nodes[rand(1:n)]
source3 = Main_Graph.nodes[rand(1:n)]
source4 = Main_Graph.nodes[rand(1:n)]
source_array = [source1, source2] #, source3, source4]
global Weight = Inf
global best_methods = 0
global best_iterations = 0 
global best_source = 0
for source in source_array
  for methods in 1:4
    for iteration in [500, 3000]
      w, TSP_Graph, Π = HK_MST(Main_Graph, 1 , source, methods, iteration)
      if w<Weight
        global Weight=min(w,Weight)
        global best_methods =methods
        global best_iterations = iteration 
        global best_source = source
      end
    end
  end
end
println("The weight of TSP using Held, Karp algorithm: ", Weight)
println("The best methods :", best_methods)
println("The best iterations :", best_iterations)
println("The best source :", name(best_source))
#plot_markedgraph(TSP_Graph)
