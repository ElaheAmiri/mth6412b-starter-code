using Markdown
using InteractiveUtils

include("../node.jl")
include("../edge.jl")
include("../graph.jl")
include("../read_stsp.jl")

include("marked_node.jl")
include("marked_edge.jl")
include("marked_graph.jl")
include("Prime_Alg.jl")
include("kruskal_Alg.jl")


"""The main kruskal algorithm steps"""

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

"""Calculating the minimum spanning tree using Prim algorithm"""
W1, Prime_MST = Prime_Algo(Main_Graph, Main_Graph.nodes[1])
println("The weight of MST using Prim Algorithm: ", W1)
plot_markedgraph(Prime_MST)

"""Calculating the minimum spanning tree using Kruskal algorithm"""
W2, Kruskal_MST = Kruskal(Main_Graph)
println("The weight of MST using Kruskal Algorithm: ", W2)
plot_markedgraph(Kruskal_MST)