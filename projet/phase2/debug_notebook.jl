### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ 8f58e950-01d6-11eb-3b06-11db973b964b
begin
include("../node.jl")
include("../edge.jl")
include("../graph.jl")
include("../read_stsp.jl")
end

# ╔═╡ 8aae7410-01d6-11eb-29a8-dbbfd7b97be7


# ╔═╡ 2a069b70-01d5-11eb-3b54-a1a0a9cdda52
md" Debug Phase 2"

# ╔═╡ 977098e0-01d6-11eb-344c-4d8de2d2bb0a
Ex_Graph = Graph("Graph_Ex_Notes_de_Cours", Node{Array{Float64,1}}[], Edge{Array{Float64,1}}[])

# ╔═╡ ee760890-02ae-11eb-1716-5f2eb6d4e42d
my_node_dict = Dict{String,Any}()

# ╔═╡ aed0ca00-01d6-11eb-147f-0701797fc391
for node_name in ["a","b","c","d","e","f","g","h","i"]
	my_node_dict[node_name]=Node{Array{Float64,1}}(node_name,[])
	add_node!(Ex_Graph,my_node_dict[node_name])
end

# ╔═╡ bd0b1a70-01d7-11eb-02b1-074e7301e326
begin	
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
end

# ╔═╡ ee867490-02b4-11eb-193b-37f7d0f5cc46
A₀ = Set()

# ╔═╡ 168aca30-02b6-11eb-2cb1-5d7880c41fc4
k=0

# ╔═╡ 005d3240-01dd-11eb-11a7-1b3d58f99b4e
A = sort(Ex_Graph.edges, by = x -> x.weight)

# ╔═╡ 427465c0-02b6-11eb-05ff-a38d6bb857df
A[1].adjacentnodes[2]

# ╔═╡ 2419f110-02b8-11eb-1e91-772e21a46abb


# ╔═╡ df5304ce-02b8-11eb-2aa4-8975447fe43a
Connex_Node = Dict{Node,Tuple{String, Set{Any}}}()

# ╔═╡ 5b711360-02b7-11eb-3f87-2b84048d9964
for node in Ex_Graph.nodes
	Connex_Node[node] = (node.name, Set([node])) 
end

# ╔═╡ bb9ba8e0-02bc-11eb-1f4a-1dfe360e81b3
Connex_Node

# ╔═╡ 4180a0d0-02bf-11eb-01ed-bdc75b0d42d1
Connex_Node[A[1].adjacentnodes[1]][1]

# ╔═╡ 1d5f7270-02b6-11eb-2e6c-a5c58c8559c5
for a in A
	if Connex_Node[a.adjacentnodes[1]][1] != Connex_Node[a.adjacentnodes[2]][1]
		union!(A₀, Set([a]))
		New_Set = union(Connex_Node[a.adjacentnodes[1]][2],Connex_Node[a.adjacentnodes[2]][2])
		New_Set_Name = Connex_Node[a.adjacentnodes[1]][1]
		
		for element in New_Set
			Connex_Node[element] =  (New_Set_Name, New_Set)
		end
	end
	if length(A₀) + 1 == length(Ex_Graph.nodes)
				break
	end
end


# ╔═╡ 10b15130-02be-11eb-3613-a7a07b46dc2b
A₀

# ╔═╡ 761e1a00-02c1-11eb-2263-9fd5f64d26ed
sum(x->x.weight,A₀)

# ╔═╡ 0b7d2040-02c3-11eb-3c3f-0381f1e58b45
length(A₀)

# ╔═╡ 6af2fe00-02c3-11eb-2690-ff394e50087e
length(Ex_Graph.nodes)

# ╔═╡ Cell order:
# ╠═8aae7410-01d6-11eb-29a8-dbbfd7b97be7
# ╠═2a069b70-01d5-11eb-3b54-a1a0a9cdda52
# ╠═8f58e950-01d6-11eb-3b06-11db973b964b
# ╠═977098e0-01d6-11eb-344c-4d8de2d2bb0a
# ╠═ee760890-02ae-11eb-1716-5f2eb6d4e42d
# ╠═aed0ca00-01d6-11eb-147f-0701797fc391
# ╠═bd0b1a70-01d7-11eb-02b1-074e7301e326
# ╠═ee867490-02b4-11eb-193b-37f7d0f5cc46
# ╠═168aca30-02b6-11eb-2cb1-5d7880c41fc4
# ╠═005d3240-01dd-11eb-11a7-1b3d58f99b4e
# ╠═427465c0-02b6-11eb-05ff-a38d6bb857df
# ╠═2419f110-02b8-11eb-1e91-772e21a46abb
# ╠═df5304ce-02b8-11eb-2aa4-8975447fe43a
# ╠═5b711360-02b7-11eb-3f87-2b84048d9964
# ╠═bb9ba8e0-02bc-11eb-1f4a-1dfe360e81b3
# ╠═4180a0d0-02bf-11eb-01ed-bdc75b0d42d1
# ╠═1d5f7270-02b6-11eb-2e6c-a5c58c8559c5
# ╠═10b15130-02be-11eb-3613-a7a07b46dc2b
# ╠═761e1a00-02c1-11eb-2263-9fd5f64d26ed
# ╠═0b7d2040-02c3-11eb-3c3f-0381f1e58b45
# ╠═6af2fe00-02c3-11eb-2690-ff394e50087e
