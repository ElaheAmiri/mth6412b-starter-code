using Plots

"""Analyse un fichier .tsp et renvoie un dictionnaire avec les données de l'entête."""
function read_img_header(filename::String)

  file = open(filename, "r")
  header = Dict{String}{String}()
  sections = ["NAME", "TYPE", "DIMENSION", "EDGE_WEIGHT_TYPE", "EDGE_WEIGHT_FORMAT",
  "NODE_COORD_TYPE", "DISPLAY_DATA_TYPE"]

  # Initialize header
  for section in sections
    header[section] = "None"
  end

  for line in eachline(file)
    line = strip(line)
    data = split(line, ":")
    if length(data) >= 2
      firstword = strip(data[1])
      if firstword in sections
        header[firstword] = strip(data[2])
      end
    end
  end
  close(file)
  return header
end



"""Analyse un fichier .tsp et renvoie l'ensemble des arêtes sous la forme d'un tableau."""
function read_img_edges(header::Dict{String}{String}, filename::String)
  edges_weight = Dict{Tuple{Int64,Int64}}{Float64}()
  edges = []

  edge_weight_format = header["EDGE_WEIGHT_FORMAT"]

  file = open(filename, "r")
  dim = parse(Int, header["DIMENSION"])
  edge_weight_section = false
  k = 0
  n_edges = 0
  i = 0
  n_to_read = dim-k-1
  flag = false

  for line in eachline(file)
    line = strip(line)
    if !flag
      if occursin(r"^EDGE_WEIGHT_SECTION", line)
        edge_weight_section = true
        continue
      end

      if edge_weight_section
        data = split(line)
        n_data = length(data)
        start = 0
        while n_data > 0
          n_on_this_line = min(n_to_read, n_data)

          for j = start : start + n_on_this_line - 1
            n_edges = n_edges + 1
            weight = parse(Int64, data[j+1])
            edge = (k+1, i+k+2)
            edge2 = (i+k+2, k+1)
            push!(edges, edge)
            edges_weight[edge] = parse(Float64, data[j+1])
            edges_weight[edge2] = parse(Float64, data[j+1])
            i += 1
          end

          n_to_read -= n_on_this_line
          n_data -= n_on_this_line

          if n_to_read <= 0
            start += n_on_this_line
            k += 1
            i = 0
            n_to_read = dim-k-1
          end

          if k >= dim
            n_data = 0
            flag = true
          end
        end
      end
    end
  end
  close(file)
  return edges, edges_weight
end

"""Renvoie les noeuds et les arêtes du graphe."""
function read_img_stsp(filename::String)
  Base.print("Reading of header : ")
  header = read_img_header(filename)
  println("✓")
  dim = parse(Int, header["DIMENSION"])
  edge_weight_format = header["EDGE_WEIGHT_FORMAT"]

  Base.print("Reading of nodes : ")
  graph_nodes = Dict{Int}{Vector{Float64}}()
  println("✓")

  Base.print("Reading of edges : ")
  edges_brut, edges_weight = read_img_edges(header, filename)
  graph_edges = []
  for k = 1 : dim
    edge_list = Int[]
    push!(graph_edges, edge_list)
  end

  for edge in edges_brut
    if edge_weight_format in ["UPPER_ROW", "LOWER_COL", "UPPER_DIAG_ROW", "LOWER_DIAG_COL"]
      push!(graph_edges[edge[1]], edge[2])
    else
      push!(graph_edges[edge[2]], edge[1])
    end
  end

  for k = 1 : dim
    graph_edges[k] = sort(graph_edges[k])
  end
  println("✓")
  return graph_nodes, graph_edges, edges_weight
end

