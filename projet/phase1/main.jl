using Markdown
using InteractiveUtils

include("node.jl")
include("edge.jl")
include("graph.jl")
include("read_stsp.jl")

"""Access to data files"""

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

T = valtype(graph_nodes)
for k = 1 : length(graph_edges)
    if isempty(graph_nodes)
		new_node1 = Node{T}(string(k),T())
	else
   		new_node1 = Node(string(k),graph_nodes[k])
	end
    add_node!(Main_Graph, new_node1)
    for j in graph_edges[k]
        if isempty(graph_nodes)
	    	new_node2 = Node{T}(string(j),T())
    	else
		    new_node2 = Node(string(j),graph_nodes[j])
	    end
        edge_name = "("*string(k)*","*string(j)*")"
        new_edge = Edge(edge_name, edges_weight[k,j], (new_node1 , new_node2))
        add_edge!(Main_Graph, new_edge)
    end
end

gr()
using Plots
plot_graph(filepath)

show(Main_Graph)