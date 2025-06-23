### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ 52d487ce-06a6-11eb-2482-dd65e447df8d
begin
include("../node.jl")
include("../edge.jl")
include("../graph.jl")
include("../read_stsp.jl")
include("../disjoint_set.jl")
include("../display.jl")
end

# ╔═╡ 72c34a50-0763-11eb-1737-a3ec8cf3e8a1
begin
include("graph_test.jl")
include("disjoint_set_test.jl")
end

# ╔═╡ 443ad950-06a5-11eb-1ebf-9fed2a75fa07
md" # Rapport de projet: Phase 2"

# ╔═╡ 58c70d70-06a6-11eb-2ce1-253886b97427
md" Équipe: Elahe Amiri et Louis-Philippe Proulx"

# ╔═╡ 47bbcd40-06a6-11eb-32bd-2b3bc3b16626
md"Lien Github du code: [Branche Phase 2 du projet](https://github.com/louproul/mth6412b-starter-code.git)"

# ╔═╡ f7027d50-076c-11eb-1e91-69b144f77e62
md" Il y a une réplique du code dans \"projet\phase2\main.jl\""

# ╔═╡ 9d9effb0-0760-11eb-000e-b116ba9b6f98
md" Voici le type DisjointSet que nous proposons. L'information de chaque noeud est emmagasiné dans un dictionnaire. L'information inclut le nom de l'ensemble connexe (String), l'ensemble des noeuds qui font parti de cet ensemble (Set(Node)) ainsi que l'ensemble des arrêtes qui font partis de cet ensemble (Set(Edge))"


# ╔═╡ 0f31526e-0754-11eb-001f-df6b7cf78cf9
display("../disjoint_set.jl") 

# ╔═╡ 990fdaa0-0760-11eb-152e-8b030d2a7c61
md" ## Nous allons maintenat implémenter l'algorithme the Kruskal sur l'exemple des notes de cours"

# ╔═╡ 7436e96e-0761-11eb-3111-e9394e6a6f65
md" Nous créons un graph avec les même caractéristiques que celui des notes de cours"

# ╔═╡ ebb78e00-0752-11eb-1b0a-43cfa0521da7
begin
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
end

# ╔═╡ 9e4e8420-0761-11eb-0aac-6fe7a1514255
md" Nous créons maintenant une composante connexe par noeud"

# ╔═╡ 2cd338b0-06a6-11eb-3e54-0ff9884b75ac
begin
my_disjoint_set_toy = DisjointSet{Vector{Float64}}()
create_disjointSet!(my_disjoint_set_toy, Ex_Graph)
end

# ╔═╡ bbcbcd50-0761-11eb-1020-1f341e554815
md" Nous trions les arrêtes selon leur poids"

# ╔═╡ 6fc4caa0-0753-11eb-0335-c52b7f54c11d
A = sort(Ex_Graph.edges, by = x -> x.weight)

# ╔═╡ d38f2d10-0761-11eb-1f44-a91e507d381b
md"Nous appliquons l'algorithme de Kruskal"

# ╔═╡ c806f030-0753-11eb-34b1-4b2a0ebce572
for a in A
  if is_arc_disjoint(my_disjoint_set_toy,a)
    union_disjoint_set(my_disjoint_set_toy, a )
  end
end

# ╔═╡ ea62fcb2-0761-11eb-2b89-21eac49d6557
md" Nous affichons le poids de l'arbre de recouvrement minimal"

# ╔═╡ db7f11b0-0753-11eb-29c4-0df72443d55a
sum(x->x.weight,edges(my_disjoint_set_toy))

# ╔═╡ 0a88d0a0-0762-11eb-2dd8-ad9b45df474b
md" ## Dans cet 2e partie nous appliquerons l'algorithme à une instance TSP symétrique: \"bayg29.tsp\""

# ╔═╡ 41092580-0762-11eb-2ac1-83ba10bb39a1
md" Création du graph à paritir du fichier de données"

# ╔═╡ 578a97c0-0754-11eb-3d8d-210e61eded8f
begin
Main_Graph = Graph{Vector{Float64}}() 
graph_nodes, graph_edges, edges_weight = read_stsp("../../instances/stsp/bayg29.tsp")
create_graph!(Main_Graph, graph_nodes,graph_edges, edges_weight)
end

# ╔═╡ 548f29b0-0762-11eb-1677-01691b6ea799
md" Création des composantes connexes pour chaque noeud"

# ╔═╡ b368a8c0-0754-11eb-367b-438a97e2490f
begin
my_disjoint_set = DisjointSet{Vector{Float64}}()
create_disjointSet!(my_disjoint_set, Main_Graph)
end

# ╔═╡ 63201b12-0762-11eb-2a67-d7d11b5bde58
md" Nous trions les arrêtes selon le poids"

# ╔═╡ 4cf56fa0-0755-11eb-2bc7-0f622b8a44f0
A1 = sort(Main_Graph.edges, by = x -> x.weight)

# ╔═╡ 70a65330-0762-11eb-09d7-7d098d727f91
md"Nous appliquons encore une fois l'algorithme de Kruskal"

# ╔═╡ d0011030-0754-11eb-2042-c597142a89c6
for a in A1
  if is_arc_disjoint(my_disjoint_set,a)
    union_disjoint_set(my_disjoint_set, a )
  end
end

# ╔═╡ 87b18680-0762-11eb-14f2-0d4603dcd909
md" Nous avons créé une nouvelle méthode \"plot_subgraph()\" qui permet d'afficher un sous-ensemble d'arrêtes. Nous affichons donc l'arbre de recouvrement minimal que nous venons de trouver"

# ╔═╡ d8c10db0-0754-11eb-01f3-a10b0747e5e1
plot_subgraph(Main_Graph, edges(my_disjoint_set))

# ╔═╡ cbeae350-0762-11eb-00b2-0bea51a7fa6f
md" Le poids de l'arbre de recouvrement minimal:"

# ╔═╡ ddb33a50-0754-11eb-36ac-1909ab268a31
sum(x->x.weight,edges(my_disjoint_set))

# ╔═╡ dc4d8770-0762-11eb-027c-bf8f0e94e6ef
md" Les arrêtes de l'arbre de recouvrement minimal."

# ╔═╡ f59f57c0-0754-11eb-1ed3-f1391c18bc0d
edges(my_disjoint_set)

# ╔═╡ 0775f5e0-0763-11eb-29c3-ed6ec049f541
md" ## Finalement, nous avons créé deux fichiers de test unitaire qui permettent de valider la bon fonctionnment du type DisjointSet et Graph"

# ╔═╡ b810caae-076d-11eb-1c51-c7c4cd74791d
md" Voici le code de \"disjoint\_set\_test.jl\""

# ╔═╡ 29794d50-076c-11eb-1be8-fd148ca71bee
display("disjoint_set_test.jl")

# ╔═╡ Cell order:
# ╟─443ad950-06a5-11eb-1ebf-9fed2a75fa07
# ╟─58c70d70-06a6-11eb-2ce1-253886b97427
# ╟─47bbcd40-06a6-11eb-32bd-2b3bc3b16626
# ╟─f7027d50-076c-11eb-1e91-69b144f77e62
# ╠═52d487ce-06a6-11eb-2482-dd65e447df8d
# ╟─9d9effb0-0760-11eb-000e-b116ba9b6f98
# ╠═0f31526e-0754-11eb-001f-df6b7cf78cf9
# ╟─990fdaa0-0760-11eb-152e-8b030d2a7c61
# ╟─7436e96e-0761-11eb-3111-e9394e6a6f65
# ╠═ebb78e00-0752-11eb-1b0a-43cfa0521da7
# ╟─9e4e8420-0761-11eb-0aac-6fe7a1514255
# ╠═2cd338b0-06a6-11eb-3e54-0ff9884b75ac
# ╟─bbcbcd50-0761-11eb-1020-1f341e554815
# ╠═6fc4caa0-0753-11eb-0335-c52b7f54c11d
# ╟─d38f2d10-0761-11eb-1f44-a91e507d381b
# ╠═c806f030-0753-11eb-34b1-4b2a0ebce572
# ╟─ea62fcb2-0761-11eb-2b89-21eac49d6557
# ╠═db7f11b0-0753-11eb-29c4-0df72443d55a
# ╟─0a88d0a0-0762-11eb-2dd8-ad9b45df474b
# ╟─41092580-0762-11eb-2ac1-83ba10bb39a1
# ╠═578a97c0-0754-11eb-3d8d-210e61eded8f
# ╟─548f29b0-0762-11eb-1677-01691b6ea799
# ╠═b368a8c0-0754-11eb-367b-438a97e2490f
# ╟─63201b12-0762-11eb-2a67-d7d11b5bde58
# ╠═4cf56fa0-0755-11eb-2bc7-0f622b8a44f0
# ╟─70a65330-0762-11eb-09d7-7d098d727f91
# ╠═d0011030-0754-11eb-2042-c597142a89c6
# ╟─87b18680-0762-11eb-14f2-0d4603dcd909
# ╠═d8c10db0-0754-11eb-01f3-a10b0747e5e1
# ╟─cbeae350-0762-11eb-00b2-0bea51a7fa6f
# ╠═ddb33a50-0754-11eb-36ac-1909ab268a31
# ╟─dc4d8770-0762-11eb-027c-bf8f0e94e6ef
# ╠═f59f57c0-0754-11eb-1ed3-f1391c18bc0d
# ╟─0775f5e0-0763-11eb-29c3-ed6ec049f541
# ╠═72c34a50-0763-11eb-1737-a3ec8cf3e8a1
# ╟─b810caae-076d-11eb-1c51-c7c4cd74791d
# ╠═29794d50-076c-11eb-1be8-fd148ca71bee
