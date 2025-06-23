using Markdown
using InteractiveUtils

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


function main_fct(filename = "bayg29.tsp")
  filename_stsp = filename
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

  W1, TSP_Graph = RSL_TSP(Main_Graph, Main_Graph.nodes[1])
  println("The weight of TSP using Rosenkrantz, Stearns and Lewis algorithm: ", W1)
  #display(plot_markedgraph(TSP_Graph))

  Source = Calc_source(Main_Graph)
  W2, HK_Graph = HK_MST(Main_Graph, 1, Source, 3, 1000) # method::Int64=0, t_step::Float64 = -1.0, stop_method::Int64 = 0)
  println("The weight of TSP using HK algorithm: ", W2)
  #display(plot_markedgraph(HK_Graph))
 return W1, TSP_Graph, W2, HK_Graph 
end

W1, TSP_Graph, W2, HK_Graph = main_fct("bayg29.tsp")
display(plot_markedgraph(TSP_Graph))
display(plot_markedgraph(HK_Graph))