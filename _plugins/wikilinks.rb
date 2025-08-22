# _plugins/wikilinks.rb
# Конвертирует [[wikilinks]] и [[slug|Текст]] в обычные markdown-ссылки
# Ищет цели по коллекции `notes` (title и basename).

module Wikilinks
  def self.build_index(site)
    col  = site.collections['notes']
    docs = col ? col.docs : []
    idx  = {}

    docs.each do |d|
      title = (d.data['title'] || File.basename(d.basename, '.*')).to_s
      slug  = File.basename(d.basename, '.*').to_s

      [title, slug].each do |k|
        k = k.to_s.downcase.strip
        next if k.empty?
        idx[k] = d.url
      end
    end

    idx
  end

  def self.convert(content, site)
    return content if content.nil? || content.empty?

    idx = build_index(site)

    content.gsub(/\[\[([^\]|#]+?)(?:\|([^\]]+))?\]\]/) do
      key   = Regexp.last_match(1).strip
      label = (Regexp.last_match(2) || key).strip
      url   = idx[key.downcase]

      url ? "[#{label}](#{site.baseurl}#{url})" : Regexp.last_match(0)
    end
  end
end

# Важно: используем doc.site, а не payload['site']
Jekyll::Hooks.register [:pages, :posts, :documents], :pre_render do |doc|
  doc.content = Wikilinks.convert(doc.content, doc.site)
end
