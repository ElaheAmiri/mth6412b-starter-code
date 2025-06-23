include("../node.jl")
include("../edge.jl")
include("../graph.jl")
include("../read_stsp.jl")
include("../disjoint_set.jl")
include("../display.jl")



# Nous créons un graph avec les même caractéristiques que celui des notes de cours"
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



# Nous créons maintenant une composante connexe par noeud

my_disjoint_set_toy = DisjointSet{Vector{Float64}}()
create_disjointSet!(my_disjoint_set_toy, Ex_Graph)



# Nous trions les arrêtes selon leur poids"
A = sort(Ex_Graph.edges, by = x -> x.weight)


# Nous appliquons l'algorithme de Kruskal"
for a in A
  if is_arc_disjoint(my_disjoint_set_toy,a)
    union_disjoint_set(my_disjoint_set_toy, a )
  end
end

# Nous affichons le poids de l'arbre de recouvrement minimal"
println(sum(x->x.weight,edges(my_disjoint_set_toy)))


# Création du graph à paritir du fichier de données
filename_stsp = "bayg29.tsp"
root = normpath(joinpath(@__FILE__,"..","..",".."))
filepath_to_stsp = "instances\\stsp"
filepath = joinpath(root, filepath_to_stsp) 
filepath = joinpath(filepath, filename_stsp) 

Main_Graph = Graph{Vector{Float64}}() 
graph_nodes, graph_edges, edges_weight = read_stsp(filepath)
create_graph!(Main_Graph, graph_nodes,graph_edges, edges_weight)


# Création des composantes connexes pour chaque noeud"
my_disjoint_set = DisjointSet{Vector{Float64}}()
create_disjointSet!(my_disjoint_set, Main_Graph)

A1 = sort(Main_Graph.edges, by = x -> x.weight)

for a in A1
  if is_arc_disjoint(my_disjoint_set,a)
    union_disjoint_set(my_disjoint_set, a )
  end
end

# Nous avons créé une nouvelle méthode \"plot_subgraph()\" qui permet d'afficher un sous-ensemble d'arrêtes. Nous affichons donc l'arbre de recouvrement minimal"
plot_subgraph(Main_Graph, edges(my_disjoint_set))
println(sum(x->x.weight,edges(my_disjoint_set)))

# Les arrêtes de l'arbre de recouvrement minimal."
edges(my_disjoint_set)



