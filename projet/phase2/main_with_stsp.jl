include("../node.jl")
include("../edge.jl")
include("../graph.jl")
include("../read_stsp.jl")

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


create_graph!(Main_Graph, graph_nodes, graph_edges, edges_weight)


A₀ = Set()
k=0
A = sort(Main_Graph.edges, by = x -> x.weight)

Connex_Node = Dict{String,Tuple{String, Set{Node{Vector{Float64}}}}}()

for node in Main_Graph.nodes
  Connex_Node[node.name] = (node.name, Set([node])) 
end

for a in A
  if Connex_Node[a.adjacentnodes[1].name][1] != Connex_Node[a.adjacentnodes[2].name][1]
    union!(A₀, Set([a]))
    New_Set = union(Connex_Node[a.adjacentnodes[1].name][2],
    Connex_Node[a.adjacentnodes[2].name][2])
    New_Set_Name = Connex_Node[a.adjacentnodes[1].name][1]
    
    for element in New_Set
      Connex_Node[element.name] =  (New_Set_Name, New_Set)
    end
  end
  if length(A₀) + 1 == length(Main_Graph.nodes)
        break
  end
end


#plot_subgraph(Main_Graph, A₀)
#savefig("tree_bayg29.pdf")

print(sum(x->x.weight,A₀))