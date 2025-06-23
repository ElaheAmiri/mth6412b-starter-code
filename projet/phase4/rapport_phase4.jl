### A Pluto.jl notebook ###
# v0.12.11

using Markdown
using InteractiveUtils

# ╔═╡ c2c6fa80-2ddb-11eb-0fe4-bbea6321ff71
begin
include("../display.jl")
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


end

# ╔═╡ 4239e6e0-1d67-11eb-15c3-0399b9b830f4
md" # Rapport de projet: Phase 4"

# ╔═╡ 50084b90-1d67-11eb-05d5-ab7f35c5ba19
md" Équipe: Elahe Amiri et Louis-Philippe Proulx"

# ╔═╡ 57762690-1d67-11eb-13a0-997b7f3e95ff
md"Lien Github du code: [Branche Phase 4 du projet](https://github.com/louproul/mth6412b-starter-code.git)"

# ╔═╡ 91762c50-1d67-11eb-0e8f-a9b89638fe7d
md" Il y a une réplique du code dans \"projet\phase4\main.jl\""

# ╔═╡ f045b4fe-2ddb-11eb-0069-adb658237737
md" Toute les combinaisons sont testés \"projet\phase4\TSP_test.jl\""

# ╔═╡ efe67660-1d66-11eb-22f1-711bbc0a018a
md" #### Voici l'implémentation de l'algorithme RSL:"

# ╔═╡ 3c358e90-2ddc-11eb-0cdc-59af43d96fbd
display("TSP_rsl.jl",37,70)

# ╔═╡ f2ba7690-1d69-11eb-1bc5-457a28f8d9b3
md" L'algorithme RSL utilise l'algorithme de Prim pour trouver l'arbre de recouvrement minimal. On parcours par la suite en pré-ordre les noeuds pour créer un tour. On renvoie une nouvelle copie du tour"

# ╔═╡ 51575ce0-2de6-11eb-0dd6-45819a100bd3
md" #### Voici l'implémentation de l'algorithme HK:"

# ╔═╡ c58c7ef0-2de2-11eb-39f6-693d8645017e
display("TSP_hk.jl",51,189)

# ╔═╡ 9624de30-2df8-11eb-0227-43b46be92541
md" #### Voici un fichier (\"TSP\_test.jl\") pour effectuer des tests unitaires sur l'algorithme RSL"

# ╔═╡ a9449880-1d7b-11eb-23bc-c7103cba2292
display("TSP_test.jl",19,55)

# ╔═╡ 16e795a0-2df7-11eb-0bc4-d5b417a59861
md" Dans le fichier TSP_test.jl, nous testons l'algorithme RSL sur différentes instances. Nous vérifions le théorème vu en laboratoire qui stipule que la tournée trouvée par RSL est inférieur à 2 fois le poids de la tournée optimale."

# ╔═╡ d8981670-2df7-11eb-3e14-07d1430253ba
md" #### Voici un fichier (\"TSP\_hk\_test.jl\") pour trouver les meilleurs paramètres de l'algorihtme HK"

# ╔═╡ 7fe3a710-2df7-11eb-2aa0-7354e22cda2f
display("TSP_hk_test.jl",58,74)

# ╔═╡ c5f10090-2df7-11eb-03de-b94d7228ce46
md" Dans ce fichier, on utilise une approche iérative, où l'on fait varier les paramètres d'entrée de l'algorithme HK. Cela permet d'identifier une combinaison qui fonctionne bien sur une instance. Dans ce cas-ci, nous avons évaluer les meilleurs paramètres pour l'instance bayg29.tsp"

# ╔═╡ 28699d60-2e00-11eb-0d1b-6d6a9715d3c6
md" #### Voici la fonction principal qui permet de tester les 2 algorithmes. Elle est disponible dans main.jl"

# ╔═╡ bea2db30-2dfa-11eb-300a-f3e69dc1194a
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
  Source = Calc_source(Main_Graph)
  
  W1, TSP_Graph = RSL_TSP(Main_Graph, Source)
  println("The weight of TSP using Rosenkrantz, Stearns and Lewis algorithm: ", W1)
  #display(plot_markedgraph(TSP_Graph))

  
  W2, HK_Graph = HK_MST(Main_Graph, 1, Source, 3, 3000) # method::Int64=0, t_step::Float64 = -1.0, stop_method::Int64 = 0)
  println("The weight of TSP using HK algorithm: ", W2)
  #display(plot_markedgraph(HK_Graph))
 return W1, TSP_Graph, W2, HK_Graph 
end

# ╔═╡ b08e8520-2e00-11eb-29e3-d71b02c8b8f8
md" Elle renvoie la tournée générée avec RSL et HK"

# ╔═╡ c60f7dae-2dfa-11eb-296d-d164a6612917
W1, TSP_Graph, W2, HK_Graph = main_fct("bayg29.tsp")

# ╔═╡ c576aa00-2e03-11eb-2157-4da004c22518
md"Nous présentons le résultat graphique pour RSL"

# ╔═╡ ee01a050-2dfa-11eb-3d10-c5aba1637182
plot_markedgraph(TSP_Graph)

# ╔═╡ f13e3ea0-2e03-11eb-3efb-f16fb4e7b647
md"Nous présentons le résultat graphique pour HK. Avec un poids de 1645 légèrement supérieur au poids optimal."

# ╔═╡ 10ddbaa0-2dfb-11eb-2f04-75cbbc8ad2bc
plot_markedgraph(HK_Graph)

# ╔═╡ 0e1ed2a0-2e04-11eb-1fe0-b56860f26bd2
md" Finalement le calcul pour un autre instance \"gr17.tsp\""

# ╔═╡ 5928fc90-2e03-11eb-0cfa-07159c013c63
W1_gr17, TSP_Graph_gr17, W2_gr17, HK_Graph_gr17 = main_fct("gr17.tsp")

# ╔═╡ 30d11dd0-2e04-11eb-279f-e187c227d74f
md" #### Voici un fichier (\"test\_hk.jl\") pour calculer l'erreur relative"

# ╔═╡ a9c19652-2e06-11eb-0af0-cd3f10fa64bd
begin
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

  W1, TSP_Graph, Π = HK_MST(Main_Graph, 1 , Main_Graph.nodes[4], 4, 1000)
  errors[key] = 100*(W1-value)/value

end
println(errors)
end

# ╔═╡ 932cb990-2e08-11eb-2a92-c7f340b49cbb
errors

# ╔═╡ 9ddec310-2e08-11eb-3cff-99cbad5311af
md" On a un bug au niveau du calcul de l'erreur relative. Bien qu'on est des tournées, il semble qu'il y est un erreur lorsqu'on revient au coût original des arrêtes. Il faut bien sûr enlever les pénalités, mais quelques choses nous échappent ici"

# ╔═╡ Cell order:
# ╟─4239e6e0-1d67-11eb-15c3-0399b9b830f4
# ╟─50084b90-1d67-11eb-05d5-ab7f35c5ba19
# ╟─57762690-1d67-11eb-13a0-997b7f3e95ff
# ╟─91762c50-1d67-11eb-0e8f-a9b89638fe7d
# ╟─f045b4fe-2ddb-11eb-0069-adb658237737
# ╠═c2c6fa80-2ddb-11eb-0fe4-bbea6321ff71
# ╟─efe67660-1d66-11eb-22f1-711bbc0a018a
# ╟─3c358e90-2ddc-11eb-0cdc-59af43d96fbd
# ╟─f2ba7690-1d69-11eb-1bc5-457a28f8d9b3
# ╟─51575ce0-2de6-11eb-0dd6-45819a100bd3
# ╠═c58c7ef0-2de2-11eb-39f6-693d8645017e
# ╟─9624de30-2df8-11eb-0227-43b46be92541
# ╠═a9449880-1d7b-11eb-23bc-c7103cba2292
# ╟─16e795a0-2df7-11eb-0bc4-d5b417a59861
# ╟─d8981670-2df7-11eb-3e14-07d1430253ba
# ╠═7fe3a710-2df7-11eb-2aa0-7354e22cda2f
# ╟─c5f10090-2df7-11eb-03de-b94d7228ce46
# ╟─28699d60-2e00-11eb-0d1b-6d6a9715d3c6
# ╠═bea2db30-2dfa-11eb-300a-f3e69dc1194a
# ╟─b08e8520-2e00-11eb-29e3-d71b02c8b8f8
# ╠═c60f7dae-2dfa-11eb-296d-d164a6612917
# ╟─c576aa00-2e03-11eb-2157-4da004c22518
# ╠═ee01a050-2dfa-11eb-3d10-c5aba1637182
# ╟─f13e3ea0-2e03-11eb-3efb-f16fb4e7b647
# ╠═10ddbaa0-2dfb-11eb-2f04-75cbbc8ad2bc
# ╠═0e1ed2a0-2e04-11eb-1fe0-b56860f26bd2
# ╠═5928fc90-2e03-11eb-0cfa-07159c013c63
# ╟─30d11dd0-2e04-11eb-279f-e187c227d74f
# ╠═a9c19652-2e06-11eb-0af0-cd3f10fa64bd
# ╠═932cb990-2e08-11eb-2a92-c7f340b49cbb
# ╠═9ddec310-2e08-11eb-3cff-99cbad5311af
