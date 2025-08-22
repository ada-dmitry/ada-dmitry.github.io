# _plugins/note_graph.rb
# Генерирует /graph.json с узлами и рёбрами между заметками из коллекции :notes.
# Понимает [[target]], [[target|alias]], вложенные папки, alias'ы во front matter:
# aliases: ["Короткое имя", "Другое имя"]

require "json"

module NoteGraph
  class Generator < Jekyll::Generator
    safe true
    priority :low

    WIKI_RX = /\[\[([^\]|#]+)(?:#[^\]|]+)?(?:\|[^\]]+)?\]\]/.freeze

    def generate(site)
      notes = (site.collections["notes"]&.docs || [])
      return if notes.empty?

      # Карта идентификаторов заметок -> объект
      # id = относительный путь внутри _notes без расширения, в нижнем регистре
      index = {}
      aliases = {}

      notes.each do |doc|
        id = norm_id(doc.relative_path) # напр. "it-school/04-auto"
        index[id] = {
          "id"    => id,
          "title" => (doc.data["title"] || File.basename(id)),
          "url"   => doc.url
        }

        # поддержка front matter aliases
        Array(doc.data["aliases"]).each do |al|
          aliases[norm_key(al)] = id
        end

        # ещё можно сопоставлять обычное название файла без папок
        base = File.basename(id)
        aliases[norm_key(base)] = id
      end

      # Узлы
      nodes = index.values

      # Рёбра
      links = []

      notes.each do |doc|
        src = norm_id(doc.relative_path)
        content = doc.content.to_s

        content.scan(WIKI_RX).each do |m|
          raw = m.first # то, что внутри [[ ... ]]
          # цель без якоря/алиаса и расширения
          target = raw.strip
          target = target.sub(/\|.*/, "")      # отрезать |alias
          target = target.sub(/#.*/, "")       # отрезать #heading
          target = target.sub(/\.md$/i, "")    # убрать .md

          # 1) прямое совпадение по относительному пути
          dst = index[norm_id("_notes/#{target}.md")]&.dig("id")
          # 2) совпадение по alias/названию файла
          dst ||= aliases[norm_key(target)]
          next unless dst && index[dst]

          links << { "source" => src, "target" => dst }
        end
      end

      data = { "nodes" => nodes, "links" => links }

      site.static_files << GeneratedJson.new(site, data)
    end

    # нормализуем «ключ»
    def norm_key(s)
      s.to_s.downcase.strip.gsub("\\", "/")
    end

    # делаем id из относительного пути документа
    # "_notes/IT-School/04-auto.md" -> "it-school/04-auto"
    def norm_id(relative_path)
      p = relative_path.to_s
      p = p.sub(%r!^_notes/!i, "")
      p = p.sub(/\.md$/i, "")
      p.downcase
    end

    # Объект статического файла, который кладём в _site/graph.json
    class GeneratedJson < Jekyll::StaticFile
      def initialize(site, data)
        @site = site
        @base = site.source
        @dir  = "/"
        @name = "graph.json"
        @data = data
        super(site, @base, @dir, @name, nil)
      end

      def write(dest)
        dest_path = Jekyll.sanitized_path(dest, @dir, @name)
        FileUtils.mkdir_p(File.dirname(dest_path))
        File.write(dest_path, JSON.pretty_generate(@data))
        true
      end
    end
  end
end
