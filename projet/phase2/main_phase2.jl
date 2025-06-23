include("../node.jl")
include("../edge.jl")
include("../graph.jl")
include("../read_stsp.jl")



Ex_Graph = Graph("Graph_Ex_Notes_de_Cours", Node{Array{Float64,1}}[], Edge{Array{Float64,1}}[])


my_node_dict = Dict{String,Any}()
for node_name in ["a","b","c","d","e","f","g","h","i"]
	my_node_dict[node_name]=Node{Array{Float64,1}}(node_name,[])
	add_node!(Ex_Graph,my_node_dict[node_name])
end



add_edge!(Ex_Graph,Edge("(a,b)",4.0,(my_node_dict["a"],my_node_dict["b"])))
add_edge!(Ex_Graph,Edge("(a,h)",8.0,(my_node_dict["a"],my_node_dict["h"])))
add_edge!(Ex_Graph,Edge("(b,c)",8.0,(my_node_dict["b"],my_node_dict["c"])))
add_edge!(Ex_Graph,Edge("(b,h)",11.0,(my_node_dict["b"],my_node_dict["h"])))
add_edge!(Ex_Graph,Edge("(c,d)",7.0,(my_node_dict["c"],my_node_dict["d"])))
add_edge!(Ex_Graph,Edge("(c,f)",4.0,(my_node_dict["c"],my_node_dict["f"])))
add_edge!(Ex_Graph,Edge("(c,i)",2.0,(my_node_dict["c"],my_node_dict["i"])))
add_edge!(Ex_Graph,Edge("(d,e)",9.0,(my_node_dict["d"],my_node_dict["e"])))
add_edge!(Ex_Graph,Edge("(d,f)",14.0,(my_node_dict["d"],my_node_dict["f"])))
add_edge!(Ex_Graph,Edge("(e,f)",10.0,(my_node_dict["e"],my_node_dict["f"])))
add_edge!(Ex_Graph,Edge("(f,g)",2.0,(my_node_dict["f"],my_node_dict["g"])))
add_edge!(Ex_Graph,Edge("(g,h)",1.0,(my_node_dict["g"],my_node_dict["h"])))
add_edge!(Ex_Graph,Edge("(g,i)",6.0,(my_node_dict["g"],my_node_dict["i"])))
add_edge!(Ex_Graph,Edge("(h,i)",7.0,(my_node_dict["h"],my_node_dict["i"])))

A₀ = Set()
k=0
A = sort(Ex_Graph.edges, by = x -> x.weight)

Connex_Node = Dict{String,Tuple{String, Set{Any}}}()

for node in Ex_Graph.nodes
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
  if length(A₀) + 1 == length(Ex_Graph.nodes)
        break
  end
end

#plot_subgraph(Ex_Graph, A₀) 

print(sum(x->x.weight,A₀))

