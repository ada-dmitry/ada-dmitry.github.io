# _plugins/note_graph.rb
require "json"

module Jekyll
  class NoteGraphGenerator < Generator
    safe true
    priority :low

    def generate(site)
      notes = site.collections["notes"].docs

      nodes = []
      links = []

      notes.each do |note|
        # Добавляем узел
        nodes << { id: note.data["title"] || note.basename_without_ext }

        # Парсим wiki-ссылки [[...]]
        content = note.content
        content.scan(/\[\[([^\]|]+)(?:\|[^\]]+)?\]\]/).flatten.each do |target|
          links << {
            source: note.data["title"] || note.basename_without_ext,
            target: target
          }
        end
      end

      graph_hash = { nodes: nodes, links: links }
      json_str   = JSON.pretty_generate(graph_hash)

      site.static_files << GeneratedJson.new(site, json_str)
    end
  end

  class GeneratedJson < Jekyll::StaticFile
    def initialize(site, content)
      @site    = site
      @content = content
      super(site, site.dest, "assets/js", "graph-data.json", nil)
    end

    def write(_dest)
      out_path = @site.in_dest_dir("assets/js/graph-data.json")
      FileUtils.mkdir_p(File.dirname(out_path))
      File.write(out_path, @content)
      true
    end
  end
end
