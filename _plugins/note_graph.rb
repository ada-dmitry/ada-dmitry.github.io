# _plugins/note_graph.rb
require "json"
require "fileutils"

module NoteGraph
  class Generator < Jekyll::Generator
    safe true
    priority :low

    def generate(site)
      notes = (site.collections["notes"]&.docs) || []

      nodes = []
      links = []

      notes.each do |doc|
        title = (doc.data["title"] || doc.basename_without_ext).to_s
        nodes << { id: title, url: doc.url }

        # [[Note]] / [[Note|alias]] / [[Note#Heading]] / [[Note#Heading|alias]]
        doc.content.to_s.scan(/\[\[([^\]|#]+)(?:#[^\]]*)?(?:\|[^\]]+)?\]\]/).flatten.each do |raw|
          target = raw.strip
          links << { source: title, target: target }
        end
      end

      graph = { nodes: nodes.uniq, links: links }
      site.config["note_graph_json"] = JSON.pretty_generate(graph)
    end
  end
end

# Пишем файл ПОСЛЕ сборки сайта
Jekyll::Hooks.register_once :site, :post_write do |site|
  data = site.config["note_graph_json"] || "{}"
  out_path = File.join(site.dest, "assets", "js", "graph-data.json")
  FileUtils.mkdir_p(File.dirname(out_path))
  File.write(out_path, data)
end
