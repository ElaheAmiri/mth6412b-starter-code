### A Pluto.jl notebook ###
# v0.12.17

using Markdown
using InteractiveUtils

# ╔═╡ 2af41e20-3d7d-11eb-200d-91bfbcb79a97
using Random, FileIO, Images, ImageView, ImageMagick, Plots

# ╔═╡ 1eaed3d0-3d64-11eb-332c-eb82da38927e
begin
include("../display.jl")
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
end

# ╔═╡ 5add1620-3d62-11eb-0b3b-e7330edf7a66
md" # Rapport de projet: Phase 5"

# ╔═╡ 1ec02e60-3d63-11eb-3a85-f729b432454e
md" Équipe: Elahe Amiri et Louis-Philippe Proulx"

# ╔═╡ 263e8420-3d63-11eb-03ad-71629e8d52a4
md"Lien Github du code: [Branche Phase 5 du projet](https://github.com/louproul/mth6412b-starter-code.git)"

# ╔═╡ 3d253f80-3d63-11eb-2259-b91a9c35e95f
md" Il y a une réplique du code dans \"projet\phase5\main.jl\""

# ╔═╡ 48773282-3d63-11eb-3446-51a601da3cd8
md" Toute les combinaisons sont testés \"projet\phase5\best\_parameters\_search.jl\""

# ╔═╡ 59a42b82-3d63-11eb-22ea-0153e935a154
md" ## Voici la fonction principale qui permet de créeer les images reconstruites"

# ╔═╡ 192aee80-3d64-11eb-0189-21f8f2bd2b23
display("reconstruct_img.jl",22,59)

# ╔═╡ 7cd4f800-3e80-11eb-1001-b5fdffb8a5a9
md" La fonction va créer un tour, reconstruire un image et l'enregister dans le sous-dossier \"tour\_and\_reconstructed\_image\" "

# ╔═╡ 0d5fe720-3e65-11eb-0927-c13f10fd3f9f
display(joinpath(normpath(joinpath(@__FILE__,".."))*"best_parameters_search.jl"),22,45)

# ╔═╡ d01fe7e0-3e80-11eb-3f20-cdd75f9a238f
md" Voici notre fonction de recherche des meilleurs paramètres. Elle va test tester la fonction principale sur chaque instance en modifiant l'algorithme MST, la méthode de pas et le nombre d'itérations." 

# ╔═╡ f0a502a0-3dab-11eb-2cfb-db5e7b5a4052
function path_to_original_and_constructed(filename_stsp)
	root = normpath(joinpath(@__FILE__,"..","..",".."))
	inputpath_to_stsp = "instances\\images\\original"
	inputpath = joinpath(root, inputpath_to_stsp)
    inputpath_to_original_image = joinpath(inputpath, filename_stsp * ".png") 
    path_reconstructed_image = 		              joinpath(normpath(joinpath(@__FILE__,"..")),"tour_and_reconstructed_image", 	   "construted_" * filename_stsp * ".png")
	return(inputpath_to_original_image,path_reconstructed_image)
end

# ╔═╡ 72c30620-3d6f-11eb-029e-179314b7d3b0
md"### Example abstract-light-painting"

# ╔═╡ b89bd4c0-3db4-11eb-37f3-7f2e659b8100
md"
The best combination for instance abstract-light-painting

Step method number = 2 and number of iterations = 10     

MST_Algo = 2

Total weight of best tour is 1.2310679e7"

# ╔═╡ 82bca0d0-3e83-11eb-3443-91a606126a68
reconstruct_image("abstract-light-painting",false, 2, 2, 10) 

# ╔═╡ 3f21ff40-3d76-11eb-38f1-bfcef25826be
(original_image_alp,reconstructed_image_alp)=path_to_original_and_constructed("abstract-light-painting")

# ╔═╡ 788c5610-3db5-11eb-2908-058e04fa69ba
md" ### Originale (gauche) vs reconstruite (droite)"

# ╔═╡ 0f4c7f50-3d7d-11eb-06c1-ef19431b6e49
[load(original_image_alp) load(reconstructed_image_alp)]

# ╔═╡ 87cf53d0-3d7d-11eb-3ab2-a33f4eb97de2
md"### Example alaska-railroad"

# ╔═╡ cb2952b0-3db5-11eb-385a-49b2266f0b27
md"

The best combination for instance alaska-railroad        

Step method number = 2 and number of iterations = 10     

MST_Algo = 2

Total weight of best tour is 7.663826e6"

# ╔═╡ e3e8c5ae-3db5-11eb-186a-8d0499586456
reconstruct_image("alaska-railroad",false, 2, 2, 10) 

# ╔═╡ f33a9610-3db5-11eb-3dd8-81cd1ac2e13d
(original_image_ar,reconstructed_image_ar)=path_to_original_and_constructed("alaska-railroad")

# ╔═╡ 12174830-3db6-11eb-337b-afba33cb1cd6
md" ### Originale (gauche) vs reconstruite (droite)"

# ╔═╡ 1315cc6e-3db6-11eb-140d-a7b188a5ed22
[load(original_image_ar) load(reconstructed_image_ar)]

# ╔═╡ 5df96620-3db6-11eb-3bcc-57424b8e4d96
md"### Example blue-hour-paris"

# ╔═╡ 71b4f940-3db6-11eb-049b-9f05ac582709
md"
The best combination for instance blue-hour-paris

Step method number = 1 and number of iterations = 20

MST_Algo = 1

Total weight of best tour is 3.941921e6"

# ╔═╡ 7f43e3f0-3db6-11eb-1ec2-1da5d0aec9f5
reconstruct_image("blue-hour-paris",false, 1, 1, 20) 

# ╔═╡ b26f4170-3db6-11eb-1ed1-dbe17435e2b5
(original_image_bhp,reconstructed_image_bhp)=path_to_original_and_constructed("blue-hour-paris")

# ╔═╡ c12212b0-3db6-11eb-2d06-7bc110bcd2ed
md" ### Originale (gauche) vs reconstruite (droite)"

# ╔═╡ c6473630-3db6-11eb-37ee-4b7a66e4e1f6
[load(original_image_bhp) load(reconstructed_image_bhp)]

# ╔═╡ e5016c30-3db6-11eb-10f2-2bc58014544d
md"### Example lower-kananaskis-lake"

# ╔═╡ fb649fb0-3db6-11eb-13fa-4faac11c259d
md"
The best combination for instance lower-kananaskis-lake

Step method number = 2 and number of iterations = 10

MST_Algo = 2

Total weight of best tour is 4.222666e6"

# ╔═╡ 0933c7b0-3db7-11eb-136c-3d25fb3f54bb
reconstruct_image("lower-kananaskis-lake",false, 2, 2, 10) 

# ╔═╡ 1c31d730-3db7-11eb-1a30-cbb3c9edb1d9
(original_image_lkl,reconstructed_image_lkl)=path_to_original_and_constructed("lower-kananaskis-lake")

# ╔═╡ 33dfda30-3db7-11eb-1b6c-3db1a0a766c7
md" ### Originale (gauche) vs reconstruite (droite)"

# ╔═╡ 38996aa0-3db7-11eb-3b76-fd0d456c8952
[load(original_image_lkl) load(reconstructed_image_lkl)]

# ╔═╡ 4c541360-3db7-11eb-1d2c-65aba83380d4
md"### Example marlet2-radio-board"

# ╔═╡ 5a401230-3db7-11eb-109f-ededf126c40a
md"
The best combination for instance marlet2-radio-board

Step method number = 4 and number of iterations = 20

MST_Algo = 1

Total weight of best tour is 8.823499e6"

# ╔═╡ 6ad0cb2e-3db7-11eb-1a3a-0be5a6b3d0a0
reconstruct_image("marlet2-radio-board",false, 1, 4, 20) 

# ╔═╡ 7912b230-3db7-11eb-2cea-013e59a0f72e
(original_image_mrb,reconstructed_image_mrb)=path_to_original_and_constructed("marlet2-radio-board")

# ╔═╡ a1cba740-3db7-11eb-2037-0169ea85d91e
md" ### Originale (gauche) vs reconstruite (droite)"

# ╔═╡ a66b952e-3db7-11eb-1c28-b57dc2b9b6e5
[load(original_image_mrb) load(reconstructed_image_mrb)]

# ╔═╡ c1294930-3db7-11eb-38cc-11fd9587ea9b
md"### Example nikos-cat"

# ╔═╡ d1cb4040-3db7-11eb-207b-59b6ebb0afed
md"
The best combination for instance nikos-cat

Step method number = 4 and number of iterations = 20

MST_Algo = 1

Total weight of best tour is 3.035828e6"

# ╔═╡ acd6cd40-3db7-11eb-3509-f90811f5c8e4
reconstruct_image("nikos-cat",false, 1, 4, 20) 

# ╔═╡ 0cd38e40-3db8-11eb-0711-9fc0ede890e3
(original_image_nc,reconstructed_image_nc)=path_to_original_and_constructed("nikos-cat")

# ╔═╡ 3a0b7bc0-3db8-11eb-3621-8fb4f59c7c40
md" ### Originale (gauche) vs reconstruite (droite)"

# ╔═╡ 3f95c9b0-3db8-11eb-30ea-734a27bc4503
[load(original_image_nc) load(reconstructed_image_nc)]

# ╔═╡ 53d050d0-3db8-11eb-16f0-3d0347f9e8c6
md"### Example pizza-food-wallpaper"

# ╔═╡ 62023240-3db8-11eb-074d-21c72d558f04
md"
The best combination for instance pizza-food-wallpaper

Step method number = 2 and number of iterations = 10

MST_Algo = 2

Total weight of best tour is 5.037248e6"

# ╔═╡ ee2d5570-3db7-11eb-167d-c3c36f6e2b2e
reconstruct_image("pizza-food-wallpaper",false, 2, 2, 10) 

# ╔═╡ 7f56bdc0-3db8-11eb-217e-6b9145e9bc60
(original_image_pfw,reconstructed_image_pfw)=path_to_original_and_constructed("pizza-food-wallpaper")

# ╔═╡ 8be96e20-3db8-11eb-0908-03cb9153837e
md" ### Originale (gauche) vs reconstruite (droite)"

# ╔═╡ 934017a0-3db8-11eb-058f-4b791c5c5fd6
[load(original_image_pfw) load(reconstructed_image_pfw)]

# ╔═╡ bae552c2-3db8-11eb-01ad-d3176cffaa3b
md"### Example the-enchanted-garden"

# ╔═╡ c5220530-3db8-11eb-215f-eb4aa1e48623
md"
The best combination for instance the-enchanted-garden

Step method number = 2 and number of iterations = 10

MST_Algo = 2

Total weight of best tour is 1.9910312e7"

# ╔═╡ d87a90c0-3db8-11eb-3729-f1bbc5f7dadb
reconstruct_image("the-enchanted-garden",false, 2, 2, 10) 

# ╔═╡ e652e080-3db8-11eb-3b79-b9876dffd596
(original_image_teg,reconstructed_image_teg)=path_to_original_and_constructed("the-enchanted-garden")

# ╔═╡ d11b5bc0-3db8-11eb-101d-9729c18266fc
md" ### Originale (gauche) vs reconstruite (droite)"

# ╔═╡ 034c7ac0-3db9-11eb-3955-01786dcd9e2a
[load(original_image_teg) load(reconstructed_image_teg)]

# ╔═╡ 1979f840-3db9-11eb-0499-6b74b62dbaaa
md"### Example tokyo-skytree-aerial"

# ╔═╡ 28c11a40-3db9-11eb-0d82-fbb859243c5c
md"
The best combination for instance tokyo-skytree-aerial

Step method number = 2 and number of iterations = 10

MST_Algo = 2

Total weight of best tour is 1.360595e7
"

# ╔═╡ 35e2eb40-3db9-11eb-3576-d723b3d7cdae
reconstruct_image("tokyo-skytree-aerial",false, 1, 4, 10) 

# ╔═╡ 429a1390-3db9-11eb-11c8-a7eceb510e53
(original_image_tsa,reconstructed_image_tsa)=path_to_original_and_constructed("tokyo-skytree-aerial")

# ╔═╡ 59b6ac00-3db9-11eb-30d0-8bdb53d8a16e
md" ### Originale (gauche) vs reconstruite (droite)"

# ╔═╡ 630c32c2-3db9-11eb-3b37-654b4f80fd26
[load(original_image_tsa) load(reconstructed_image_tsa)]

# ╔═╡ 560c1650-3e84-11eb-2f63-e99cc2339daf
md"fin"

# ╔═╡ Cell order:
# ╟─5add1620-3d62-11eb-0b3b-e7330edf7a66
# ╟─1ec02e60-3d63-11eb-3a85-f729b432454e
# ╟─263e8420-3d63-11eb-03ad-71629e8d52a4
# ╟─3d253f80-3d63-11eb-2259-b91a9c35e95f
# ╟─48773282-3d63-11eb-3446-51a601da3cd8
# ╟─2af41e20-3d7d-11eb-200d-91bfbcb79a97
# ╟─1eaed3d0-3d64-11eb-332c-eb82da38927e
# ╟─59a42b82-3d63-11eb-22ea-0153e935a154
# ╠═192aee80-3d64-11eb-0189-21f8f2bd2b23
# ╟─7cd4f800-3e80-11eb-1001-b5fdffb8a5a9
# ╠═0d5fe720-3e65-11eb-0927-c13f10fd3f9f
# ╟─d01fe7e0-3e80-11eb-3f20-cdd75f9a238f
# ╟─f0a502a0-3dab-11eb-2cfb-db5e7b5a4052
# ╟─72c30620-3d6f-11eb-029e-179314b7d3b0
# ╟─b89bd4c0-3db4-11eb-37f3-7f2e659b8100
# ╠═82bca0d0-3e83-11eb-3443-91a606126a68
# ╠═3f21ff40-3d76-11eb-38f1-bfcef25826be
# ╟─788c5610-3db5-11eb-2908-058e04fa69ba
# ╠═0f4c7f50-3d7d-11eb-06c1-ef19431b6e49
# ╟─87cf53d0-3d7d-11eb-3ab2-a33f4eb97de2
# ╟─cb2952b0-3db5-11eb-385a-49b2266f0b27
# ╠═e3e8c5ae-3db5-11eb-186a-8d0499586456
# ╠═f33a9610-3db5-11eb-3dd8-81cd1ac2e13d
# ╟─12174830-3db6-11eb-337b-afba33cb1cd6
# ╠═1315cc6e-3db6-11eb-140d-a7b188a5ed22
# ╟─5df96620-3db6-11eb-3bcc-57424b8e4d96
# ╟─71b4f940-3db6-11eb-049b-9f05ac582709
# ╠═7f43e3f0-3db6-11eb-1ec2-1da5d0aec9f5
# ╟─b26f4170-3db6-11eb-1ed1-dbe17435e2b5
# ╟─c12212b0-3db6-11eb-2d06-7bc110bcd2ed
# ╠═c6473630-3db6-11eb-37ee-4b7a66e4e1f6
# ╠═e5016c30-3db6-11eb-10f2-2bc58014544d
# ╟─fb649fb0-3db6-11eb-13fa-4faac11c259d
# ╠═0933c7b0-3db7-11eb-136c-3d25fb3f54bb
# ╟─1c31d730-3db7-11eb-1a30-cbb3c9edb1d9
# ╟─33dfda30-3db7-11eb-1b6c-3db1a0a766c7
# ╟─38996aa0-3db7-11eb-3b76-fd0d456c8952
# ╟─4c541360-3db7-11eb-1d2c-65aba83380d4
# ╟─5a401230-3db7-11eb-109f-ededf126c40a
# ╠═6ad0cb2e-3db7-11eb-1a3a-0be5a6b3d0a0
# ╟─7912b230-3db7-11eb-2cea-013e59a0f72e
# ╟─a1cba740-3db7-11eb-2037-0169ea85d91e
# ╠═a66b952e-3db7-11eb-1c28-b57dc2b9b6e5
# ╟─c1294930-3db7-11eb-38cc-11fd9587ea9b
# ╟─d1cb4040-3db7-11eb-207b-59b6ebb0afed
# ╠═acd6cd40-3db7-11eb-3509-f90811f5c8e4
# ╟─0cd38e40-3db8-11eb-0711-9fc0ede890e3
# ╟─3a0b7bc0-3db8-11eb-3621-8fb4f59c7c40
# ╠═3f95c9b0-3db8-11eb-30ea-734a27bc4503
# ╟─53d050d0-3db8-11eb-16f0-3d0347f9e8c6
# ╟─62023240-3db8-11eb-074d-21c72d558f04
# ╠═ee2d5570-3db7-11eb-167d-c3c36f6e2b2e
# ╟─7f56bdc0-3db8-11eb-217e-6b9145e9bc60
# ╟─8be96e20-3db8-11eb-0908-03cb9153837e
# ╠═934017a0-3db8-11eb-058f-4b791c5c5fd6
# ╟─bae552c2-3db8-11eb-01ad-d3176cffaa3b
# ╟─c5220530-3db8-11eb-215f-eb4aa1e48623
# ╠═d87a90c0-3db8-11eb-3729-f1bbc5f7dadb
# ╟─e652e080-3db8-11eb-3b79-b9876dffd596
# ╟─d11b5bc0-3db8-11eb-101d-9729c18266fc
# ╠═034c7ac0-3db9-11eb-3955-01786dcd9e2a
# ╟─1979f840-3db9-11eb-0499-6b74b62dbaaa
# ╟─28c11a40-3db9-11eb-0d82-fbb859243c5c
# ╠═35e2eb40-3db9-11eb-3576-d723b3d7cdae
# ╟─429a1390-3db9-11eb-11c8-a7eceb510e53
# ╟─59b6ac00-3db9-11eb-30d0-8bdb53d8a16e
# ╠═630c32c2-3db9-11eb-3b37-654b4f80fd26
# ╠═560c1650-3e84-11eb-2f63-e99cc2339daf
