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



# ****************************************************     
# The best combination for instance abstract-light-painting
# Step method number = 2 and number of iterations = 10     
# MST_Algo = 2
# Total weight of best tour is 1.2310679e7
# **************************************************** 

reconstruct_image("abstract-light-painting",false, 2, 2, 10) 

# ****************************************************     
# The best combination for instance alaska-railroad        
# Step method number = 2 and number of iterations = 10     
# MST_Algo = 2
# Total weight of best tour is 7.663826e6
# ****************************************************

reconstruct_image("alaska-railroad",false, 2, 2, 10) 
# ****************************************************
# The best combination for instance blue-hour-paris
# Step method number = 1 and number of iterations = 20
# MST_Algo = 1
# Total weight of best tour is 3.941921e6
# ****************************************************

reconstruct_image("blue-hour-paris",false, 1, 1, 20) 

# ****************************************************
# The best combination for instance lower-kananaskis-lake
# Step method number = 2 and number of iterations = 10
# MST_Algo = 2
# Total weight of best tour is 4.222666e6
# ****************************************************

reconstruct_image("lower-kananaskis-lake",false, 2, 2, 10) 

# ****************************************************
# The best combination for instance marlet2-radio-board
# Step method number = 4 and number of iterations = 20
# MST_Algo = 1
# Total weight of best tour is 8.823499e6
# ****************************************************

reconstruct_image("marlet2-radio-board",false, 1, 4, 20) 

# ****************************************************
# The best combination for instance nikos-cat
# Step method number = 4 and number of iterations = 20
# MST_Algo = 1
# Total weight of best tour is 3.035828e6
# ****************************************************

reconstruct_image("nikos-cat",false, 1, 4, 20) 
# ****************************************************
# The best combination for instance pizza-food-wallpaper
# Step method number = 2 and number of iterations = 10
# MST_Algo = 2
# Total weight of best tour is 5.037248e6
# ****************************************************

reconstruct_image("pizza-food-wallpaper",false, 2, 2, 10) 

# ****************************************************
# The best combination for instance the-enchanted-garden
# Step method number = 2 and number of iterations = 10
# MST_Algo = 2
# Total weight of best tour is 1.9910312e7
# ****************************************************

reconstruct_image("the-enchanted-garden",false, 2, 2, 10) 

# ****************************************************
# The best combination for instance tokyo-skytree-aerial
# Step method number = 2 and number of iterations = 10
# MST_Algo = 2
# Total weight of best tour is 1.360595e7
# ****************************************************
reconstruct_image("tokyo-skytree-aerial",false, 2, 2, 10) 









 









