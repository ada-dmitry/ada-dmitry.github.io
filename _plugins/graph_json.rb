require 'json'

Jekyll::Hooks.register :site, :post_write do |site|
  notes = site.collections["notes"].docs
  nodes = []
  edges = []

  notes.each do |note|
    id = note.url
    nodes << { id: id, title: note.data["title"] || note.basename_without_ext, url: note.url }

    # ищем [[ссылки]]
    note.content.scan(/\[\[(.*?)\]\]/).each do |m|
      target = m[0].downcase.strip.gsub(" ", "-")
      target_doc = notes.find { |n| n.basename_without_ext.downcase == target }
      edges << { source: id, target: target_doc.url } if target_doc
    end
  end

  graph = { nodes: nodes, edges: edges }
  File.write(File.join(site.dest, "graph.json"), JSON.pretty_generate(graph))
end
