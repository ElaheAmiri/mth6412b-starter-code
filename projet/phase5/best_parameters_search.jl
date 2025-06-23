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
include("reconstruct_img.jl")

# 1 = Prim Algo,  2 = Kruskal 
MST_Algorithm = [1,2] 

#    if method ==1 ==> t = t/2^(period-1) 
#    if method == 2 ==> k = max(1.0,k); t = t/k
#    if method == 3 ==> k = max(1.0,k); t = t/sqrt(k)
#    if method == 4 ==> t = 1.0
step_method = [1,2,3,4] 

nb_iteration = [10,20]
weight_dict = Dict()
all_files = ["abstract-light-painting","alaska-railroad","blue-hour-paris",
              "lower-kananaskis-lake","marlet2-radio-board","nikos-cat","pizza-food-wallpaper",
              "the-enchanted-garden","tokyo-skytree-aerial"]

for filename_bps in all_files
  weight_dict[filename_bps] = Dict()
  for mst_method in MST_Algorithm
    for step_mt in step_method
      for nb_iter in nb_iteration
        println("Name of the instance = ", filename_bps)
        println(" Performing search grid with parameters step method = ", step_mt, " and nb of iterations = ", nb_iter)
        weight_dict[filename_bps][(step_mt, nb_iter,mst_method)] =  reconstruct_image(filename_bps,false, mst_method, step_mt, nb_iter) 
      end
    end
  end
println("****************************************************")
println("The best combination for instance ", filename_bps)
println("Step method number = ", findmin(weight_dict[filename_bps])[2][1], " and number of iterations = ", findmin(weight_dict[filename_bps])[2][2] )
println("MST_Algo = ", findmin(weight_dict[filename_bps])[2][3] )
println("Total weight of best tour is ", findmin(weight_dict[filename_bps])[1] )
println("****************************************************")
end



for filename_bps in all_files
  println("****************************************************")
  println("The best combination for instance ", filename_bps)
  println("Step method number = ", findmin(weight_dict[filename_bps])[2][1], " and number of iterations = ", findmin(weight_dict[filename_bps])[2][2] )
  println("MST_Algo = ", findmin(weight_dict[filename_bps])[2][3] )
  println("Total weight of best tour is ", findmin(weight_dict[filename_bps])[1] )
  println("****************************************************")
end



