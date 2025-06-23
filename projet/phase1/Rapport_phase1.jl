### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ 3dbe1810-01a2-11eb-19b5-69655d609b72
using PlutoUI

# ╔═╡ 5f71b5d0-00cf-11eb-067c-6f7fafd83b3f
begin
	include("node.jl")
	include("edge.jl")
	include("graph.jl")
	include("read_stsp.jl")
end

# ╔═╡ 396f4ab0-00ce-11eb-291f-cd5630db2bb7
md"# Rapport de projet: Phase 1"

# ╔═╡ a238b362-00ce-11eb-06bf-dbf6dce7add9
md" Équipe: Elahe Amiri et Louis-Philippe Proulx"

# ╔═╡ c4749610-00ce-11eb-1a2f-8f0e60e9c0a2
md"Lien Github du code: [Branche Phase 1 du projet](https://github.com/louproul/mth6412b-starter-code.git)"

# ╔═╡ 65d67cce-01a1-11eb-1250-8bdcc57d44a8
import Pkg; Pkg.add("PlutoUI")

# ╔═╡ 893616e0-0110-11eb-1b68-5fada7e38619
md" On pointe vers un des fichier sources de façon à ce que le code fonctionne sur différent poste de travail"

# ╔═╡ 07312170-00d0-11eb-2214-5f83463faa58
begin
	filename_stsp = "brazil58.tsp"
	root = normpath(joinpath(@__FILE__,"..","..",".."))
	filepath_to_stsp = "instances\\stsp"
	filepath = joinpath(root, filepath_to_stsp) 
	filepath = joinpath(filepath, filename_stsp) 
end

# ╔═╡ 6b944bf0-01a3-11eb-08ea-bbefa548a79f
md" Voici le type Edge que nous proposons. Il est constitué d'un couple de Noeuds et d'un poids (scalaire réel). Nous lui donnons également un nom de type \"(1,2)\""

# ╔═╡ dc9d0b7e-0116-11eb-184b-3fb24615e939
with_terminal() do
	open("edge.jl","r") do file
		for line in readlines(file)
			println(stdout,line)
		end
	end
end

# ╔═╡ 0015dff0-01a4-11eb-0f4a-c941a490b248
md" Voici le type Graph que nous proposons. Nous avons ajouté un vecteur d'arrêtes et la fonction correspondante pour ajouter un arrête à la fois. La fonction \"show\" a été modifié afin d'afficher les arrêtes."

# ╔═╡ f2d95b00-01a3-11eb-1ccb-175cad25aefb
with_terminal() do
	open("graph.jl","r") do file
		for line in readlines(file)
			println(stdout,line)
		end
	end
end

# ╔═╡ 02d57fb0-01a5-11eb-21f6-bd0e8c7fed23
md" ## _Exemple de création d'un graph_"

# ╔═╡ e66c8bf0-0110-11eb-1cee-f3e6d9cd495f
md" Lecture du fichier, la fonction a également été modifié afin de retourner un dictionnaire contenant le poids des arrêtes"

# ╔═╡ 1734aa10-00da-11eb-297e-fd626ae614e5
graph_nodes, graph_edges, edges_weight = read_stsp(filepath)

# ╔═╡ 3be53140-0111-11eb-026e-23e30d8d4dfd
md" Création de notre graph vide. On lui donne le nom du fichier source (.tsp)"

# ╔═╡ b1329a90-00e0-11eb-1d3f-c9999ef689d7
my_graph = Graph(filename_stsp,Node{Array{Float64,1}}[],Edge{Array{Float64,1}}[])

# ╔═╡ 5b02bcee-0111-11eb-1e5d-bd361582a078
md" On ajoute les noeuds et les arrête à notre objet \"my_graph\" en itérant sur les données récoltées du fichier. S'il n'y a pas de noeuds, on créee des noeuds vides. "

# ╔═╡ 279400c0-0104-11eb-30f2-23b812fd577f
begin
	T = valtype(graph_nodes)
	for k = 1 : length(graph_edges)
		if isempty(graph_nodes)
			new_node1 = Node{T}(string(k),T())
		else
    		new_node1 = Node(string(k),graph_nodes[k])
		end
    	add_node!(my_graph, new_node1)
    	for j in graph_edges[k]
			if isempty(graph_nodes)
				new_node2 = Node{T}(string(j),T())
			else
    			new_node2 = Node(string(j),graph_nodes[j])
			end
        	edge_name = "("*string(k)*","*string(j)*")"
        	new_edge = Edge(edge_name, edges_weight[k,j], (new_node1 , new_node2))
        	add_edge!(my_graph, new_edge)
    	end
	end
end

# ╔═╡ 5e15f120-01a5-11eb-0580-b7ac4d750571
md" Voici le résultat. Le graph contient les noeuds et les arrêtes."

# ╔═╡ d6584e90-0113-11eb-1aa1-dbea375c1fed
my_graph

# ╔═╡ Cell order:
# ╟─396f4ab0-00ce-11eb-291f-cd5630db2bb7
# ╟─a238b362-00ce-11eb-06bf-dbf6dce7add9
# ╟─c4749610-00ce-11eb-1a2f-8f0e60e9c0a2
# ╠═65d67cce-01a1-11eb-1250-8bdcc57d44a8
# ╠═3dbe1810-01a2-11eb-19b5-69655d609b72
# ╠═5f71b5d0-00cf-11eb-067c-6f7fafd83b3f
# ╟─893616e0-0110-11eb-1b68-5fada7e38619
# ╠═07312170-00d0-11eb-2214-5f83463faa58
# ╟─6b944bf0-01a3-11eb-08ea-bbefa548a79f
# ╟─dc9d0b7e-0116-11eb-184b-3fb24615e939
# ╟─0015dff0-01a4-11eb-0f4a-c941a490b248
# ╟─f2d95b00-01a3-11eb-1ccb-175cad25aefb
# ╟─02d57fb0-01a5-11eb-21f6-bd0e8c7fed23
# ╟─e66c8bf0-0110-11eb-1cee-f3e6d9cd495f
# ╠═1734aa10-00da-11eb-297e-fd626ae614e5
# ╟─3be53140-0111-11eb-026e-23e30d8d4dfd
# ╠═b1329a90-00e0-11eb-1d3f-c9999ef689d7
# ╟─5b02bcee-0111-11eb-1e5d-bd361582a078
# ╠═279400c0-0104-11eb-30f2-23b812fd577f
# ╟─5e15f120-01a5-11eb-0580-b7ac4d750571
# ╠═d6584e90-0113-11eb-1aa1-dbea375c1fed
