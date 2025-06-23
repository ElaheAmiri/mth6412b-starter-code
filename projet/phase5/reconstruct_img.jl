using Markdown
using InteractiveUtils

include("../node.jl")
include("../edge.jl")
include("../graph.jl")

include("../phase3/marked_node.jl")
include("../phase3/marked_edge.jl")
include("../phase3/marked_graph.jl")
include("../phase3/Prime_Alg.jl")
include("../phase3/kruskal_Alg.jl")

include("../phase4/one_tree.jl")
include("../phase4/TSP_hk.jl")
include("../phase4/TSP_rsl.jl")

include("read_stsp_new.jl")
include("tools.jl")


function reconstruct_image(filename_stsp::String, view::Bool=false, MST_Algorithm=1, step_method=3, nb_iteration=10)
    root = normpath(joinpath(@__FILE__,"..","..",".."))
    filepath_to_stsp = "instances\\tsp\\instances"
    filepath = joinpath(root, filepath_to_stsp) 
    filepath = joinpath(filepath, filename_stsp * ".tsp")

    """Reading data form data files"""
    header = read_img_header(filepath)
    graph_nodes, graph_edges, edges_weight = read_img_stsp(filepath)

    #creating the main graph
    Main_Graph = MarkedGraph("Graph_image", MarkedNode{Array{Float64,1}}[], MarkedEdge{Array{Float64,1}}[]) 
    create_img_Graph!(Main_Graph, graph_nodes, graph_edges, edges_weight)

    # solving the TSP problem using Held and Karp algorithm
    W2, HK_Graph = HK_MST(Main_Graph, MST_Algorithm, Main_Graph.nodes[1], step_method, nb_iteration) # method::Int64=0, t_step::Float64 = -1.0, stop_method::Int64 = 0)

    New_TSP, tour_W = create_tour!(deepcopy(HK_Graph), Main_Graph, W2)
    println("The weight of TSP Tour: ", tour_W)


    start_e = New_TSP.edges[findall(x->x.adjacentnodes[1].name == "1", New_TSP.edges)][1]
    Edge_list = create_touredge_list!(New_TSP, start_e)
    node_tour = Tour_nodes_list(New_TSP)

    path_name_tour = joinpath(normpath(joinpath(@__FILE__,"..")),"tour_and_reconstructed_image", "tour_" * filename_stsp * ".tour")
    write_tour(path_name_tour, node_tour, convert(Float32, tour_W))
    inputpath_to_stsp = "instances\\images\\shuffled"

    inputpath = joinpath(root, inputpath_to_stsp)

    inputpath_to_shuffle_image = joinpath(inputpath, filename_stsp * ".png") 
    path_reconstructed_image = joinpath(normpath(joinpath(@__FILE__,"..")),"tour_and_reconstructed_image", "construted_" * filename_stsp * ".png") 
    reconstruct_picture(path_name_tour, inputpath_to_shuffle_image, path_reconstructed_image, view)

    return(tour_W)

end


