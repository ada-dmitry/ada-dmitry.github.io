# _plugins/wikilinks.rb
# Автоконвертация [[wikilinks]] -> [label](url) по коллекции _notes (и др. коллекциям, если надо)

module Wikilinks
  def self.build_index(site)
    # Возьмём все документы из коллекции notes
    notes = site.collections['notes']&.docs || []
    index = {}

    notes.each do |d|
      # ключи для поиска: title и basename без расширения
      title = (d.data['title'] || File.basename(d.basename, '.*')).to_s
      slug  = File.basename(d.basename, '.*').to_s

      [title, slug].each do |k|
        next if k.empty?
        index[k.downcase] = d.url
      end
    end

    index
  end

  def self.convert(content, site)
    idx = build_index(site)

    content.gsub(/\[\[([^\]|#]+)(?:\|([^\]]+))?\]\]/) do
      key   = Regexp.last_match(1).strip
      label = (Regexp.last_match(2) || key).strip
      url   = idx[key.downcase]

      # если нашли — заменяем, иначе оставляем как есть
      url ? "[#{label}](#{site.baseurl}#{url})" : Regexp.last_match(0)
    end
  end
end

# Прогоним через фильтр все страницы/посты/доки до рендера
Jekyll::Hooks.register [:pages, :posts, :documents], :pre_render do |doc, payload|
  site = payload['site']
  doc.content = Wikilinks.convert(doc.content, site)
end
