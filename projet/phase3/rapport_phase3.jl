### A Pluto.jl notebook ###
# v0.12.6

using Markdown
using InteractiveUtils

# ╔═╡ 51f00a40-1d5a-11eb-3b32-0b220d8ffed6
begin
using Test

include("../node.jl")
include("../edge.jl")
include("../graph.jl")
include("../read_stsp.jl")

include("marked_node.jl")
include("marked_edge.jl")
include("marked_graph.jl")
include("Prime_Alg.jl")
include("kruskal_Alg.jl")
include("../display.jl")
end

# ╔═╡ 4239e6e0-1d67-11eb-15c3-0399b9b830f4
md" # Rapport de projet: Phase 3"

# ╔═╡ 50084b90-1d67-11eb-05d5-ab7f35c5ba19
md" Équipe: Elahe Amiri et Louis-Philippe Proulx"

# ╔═╡ 57762690-1d67-11eb-13a0-997b7f3e95ff
md"Lien Github du code: [Branche Phase 3 du projet](https://github.com/louproul/mth6412b-starter-code.git)"

# ╔═╡ 91762c50-1d67-11eb-0e8f-a9b89638fe7d
md" Il y a une réplique du code dans \"projet\phase3\main.jl\""

# ╔═╡ efe67660-1d66-11eb-22f1-711bbc0a018a
md" #### Voici l'implémentation des deux heuristiques d'accélération:"

# ╔═╡ f2ba7690-1d69-11eb-1bc5-457a28f8d9b3
md" 1. L'union via le rang"

# ╔═╡ 48ce2360-1d6a-11eb-32d7-9ffc4c81e2b2
display("kruskal_Alg.jl",40,49)

# ╔═╡ 0864cf70-1d6c-11eb-199a-73c1aff34acf
md"Notre implémentation permet de prendre la valeur maximum de rang. Si les deux root nodes ont un rang égal, on ajoute 1 à un des deux noeuds. On met à jour le parent."

# ╔═╡ 52d2b960-1d6b-11eb-03cd-b5d795af4498
md" 2. La compression des chemins"

# ╔═╡ d8a5a562-1d6c-11eb-22a6-f1e9f77dd34e
display("kruskal_Alg.jl",65,73)

# ╔═╡ 15c92380-1d73-11eb-2ba5-b9797ab1cfb3
md" Chaque fois qu'il y a union de deux ensembles disjoints, cela se fait toujours au niveau de la racine. La racine d'un des ensemble devient le parent de l'autre racine. Cela permet la compression des chemins en ajoutant uniquement de la profondeur si deux ensemble disjoints sont de même rang."

# ╔═╡ 7caa5d7e-1d6e-11eb-2100-9f2db71bc5bb
md" #### Question théorique: voir pièce jointe à la fin du rappport"

# ╔═╡ bf97d960-1d6e-11eb-2c64-7712abd9b576
md" #### Notre implémentation de l'algorithme de Prim"

# ╔═╡ e98c0d90-1d6e-11eb-0a42-0dd54ba39a2e
display("Prime_Alg.jl",41,82)

# ╔═╡ 368cbade-1d6f-11eb-1a84-1d6436093d54
md" La fonction Prim_Algo dans le fichier *Prime\_Alg.jl* calcule l'arbre de recouvrement minimal d'un graph et le poids total. Le noeud source sera entré dans la file de priorité avec un poids de 0 et tous les autres noeuds avec un poids Inf. Par la suite la boucle principale enlèvera le noeud avec un poids associé minimal jusqu'à ce que la file soit vide. Ce qui correspond à ajouter un arrête légère à notre sous-arbre de recouvrement minimum. On met à jour le poids des noeuds isolés en fonction du dernier noeud ajouté à l'arbre de recouvrement minimal, uniquement si cela réduit son poids. À la fin on crée un graph pour représenter l'arbre de recouvrement minimal."

# ╔═╡ 5a77b380-1d77-11eb-02bb-4350c2c48959
md" Testons note implémentation sur l'exemple des notes de cours"

# ╔═╡ cebe5a62-1d76-11eb-1741-b7ffcb19f428
begin
Ex_Graph1 = MarkedGraph("Graph_Ex_Notes_de_Cours", MarkedNode{Array{Float64,1}}[], MarkedEdge{Vector{Float64}}[])
my_node_dict = Dict{String,Any}()
for node_name in ["1","2","3","4","5","6","7","8","9"]
  my_node_dict[node_name]=MarkedNode(Float64[],name=node_name)
  add_markednode!(Ex_Graph1,my_node_dict[node_name])
end
add_markededge!(Ex_Graph1,MarkedEdge("(1,2)",4.0,(my_node_dict["1"],my_node_dict["2"])))
add_markededge!(Ex_Graph1,MarkedEdge("(1,8)",8.0,(my_node_dict["1"],my_node_dict["8"])))
add_markededge!(Ex_Graph1,MarkedEdge("(2,3)",8.0,(my_node_dict["2"],my_node_dict["3"])))
add_markededge!(Ex_Graph1,MarkedEdge("(2,8)",11.0,(my_node_dict["2"],my_node_dict["8"])))
add_markededge!(Ex_Graph1,MarkedEdge("(3,4)",7.0,(my_node_dict["3"],my_node_dict["4"])))
add_markededge!(Ex_Graph1,MarkedEdge("(3,6)",4.0,(my_node_dict["3"],my_node_dict["6"])))
add_markededge!(Ex_Graph1,MarkedEdge("(3,9)",2.0,(my_node_dict["3"],my_node_dict["9"])))
add_markededge!(Ex_Graph1,MarkedEdge("(4,5)",9.0,(my_node_dict["4"],my_node_dict["5"])))
add_markededge!(Ex_Graph1,MarkedEdge("(4,6)",14.0,(my_node_dict["4"],my_node_dict["6"])))
add_markededge!(Ex_Graph1,MarkedEdge("(5,6)",10.0,(my_node_dict["5"],my_node_dict["6"])))
add_markededge!(Ex_Graph1,MarkedEdge("(6,7)",2.0,(my_node_dict["6"],my_node_dict["7"])))
add_markededge!(Ex_Graph1,MarkedEdge("(7,8)",1.0,(my_node_dict["7"],my_node_dict["8"])))
add_markededge!(Ex_Graph1,MarkedEdge("(7,9)",6.0,(my_node_dict["7"],my_node_dict["9"])))
add_markededge!(Ex_Graph1,MarkedEdge("(8,9)",7.0,(my_node_dict["8"],my_node_dict["9"])))
my_edge_weight = Dict{Tuple{Int64,Int64},Float64}()
my_edge_weight[(1,2)]=4.0
my_edge_weight[(1,8)]=8.0
my_edge_weight[(2,3)]=8.0
my_edge_weight[(2,8)]=11.0
my_edge_weight[(3,4)]=7.0
my_edge_weight[(3,6)]=4.0
my_edge_weight[(3,9)]=2.0
my_edge_weight[(4,5)]=9.0
my_edge_weight[(4,6)]=14.0
my_edge_weight[(5,6)]=10.0
my_edge_weight[(6,7)]=2.0
my_edge_weight[(7,8)]=1.0
my_edge_weight[(7,9)]=6.0
my_edge_weight[(8,9)]=7.0
end

# ╔═╡ b1d3456e-1d7e-11eb-3187-ef543d2c6dda
W1, Prime_MST = Prime_Algo(Ex_Graph1, Ex_Graph1.nodes[1])

# ╔═╡ e7ae3290-1d7e-11eb-0e4d-6bee23299e77
md"The weight of MST using Prim Algorithm: "

# ╔═╡ 219837f0-1d82-11eb-23c8-efab54683e2f
W1

# ╔═╡ 79127aa0-1d77-11eb-312d-732d1c1e44a4
md"Le fichier *MST\_Alg\_test.jl* contient le résultat des tests sur les instances stsp. Il vérifie les structures implémentés tels que les files et les ensembles disjoinsts. Par la suite, il compare le poids de l'arbre de recouvrment minimal trouvé par l'algorithme de Kruskal à celui de Prim. Les réponses devraient être égal s'il n'y a pas d'erreurs d'implémentation. Après avoir rouler le fichier, il n'y avait pas d'erreurs. Voici un example pour *bayg29.tsp*"

# ╔═╡ a9449880-1d7b-11eb-23bc-c7103cba2292
display("MST_Alg_test.jl",65,80)

# ╔═╡ Cell order:
# ╟─4239e6e0-1d67-11eb-15c3-0399b9b830f4
# ╟─50084b90-1d67-11eb-05d5-ab7f35c5ba19
# ╟─57762690-1d67-11eb-13a0-997b7f3e95ff
# ╟─91762c50-1d67-11eb-0e8f-a9b89638fe7d
# ╠═51f00a40-1d5a-11eb-3b32-0b220d8ffed6
# ╟─efe67660-1d66-11eb-22f1-711bbc0a018a
# ╟─f2ba7690-1d69-11eb-1bc5-457a28f8d9b3
# ╠═48ce2360-1d6a-11eb-32d7-9ffc4c81e2b2
# ╟─0864cf70-1d6c-11eb-199a-73c1aff34acf
# ╟─52d2b960-1d6b-11eb-03cd-b5d795af4498
# ╠═d8a5a562-1d6c-11eb-22a6-f1e9f77dd34e
# ╟─15c92380-1d73-11eb-2ba5-b9797ab1cfb3
# ╟─7caa5d7e-1d6e-11eb-2100-9f2db71bc5bb
# ╟─bf97d960-1d6e-11eb-2c64-7712abd9b576
# ╠═e98c0d90-1d6e-11eb-0a42-0dd54ba39a2e
# ╟─368cbade-1d6f-11eb-1a84-1d6436093d54
# ╟─5a77b380-1d77-11eb-02bb-4350c2c48959
# ╠═cebe5a62-1d76-11eb-1741-b7ffcb19f428
# ╠═b1d3456e-1d7e-11eb-3187-ef543d2c6dda
# ╠═e7ae3290-1d7e-11eb-0e4d-6bee23299e77
# ╠═219837f0-1d82-11eb-23c8-efab54683e2f
# ╟─79127aa0-1d77-11eb-312d-732d1c1e44a4
# ╠═a9449880-1d7b-11eb-23bc-c7103cba2292
