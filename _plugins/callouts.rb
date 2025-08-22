# _plugins/obsidian_callouts.rb
# Конвертирует Obsidian callouts ( > [!type] title ... )
# в HTML блоки .callout.<type>

module Jekyll
  class ObsidianCallouts
    CALLOUTS = {
      "note"    => {label: "Заметка",  css: "note"},
      "info"    => {label: "Инфо",     css: "info"},
      "tip"     => {label: "Подсказка",css: "tip"},
      "success" => {label: "Готово",   css: "success"},
      "warning" => {label: "Внимание", css: "warning"},
      "bug"     => {label: "Баг",      css: "bug"},
      "danger"  => {label: "Опасно",   css: "danger"},
      "error"   => {label: "Ошибка",   css: "danger"},
      "quote"   => {label: "Цитата",   css: "quote"}
    }.freeze

    # > [!TYPE] Optional title
    # > line
    # > line
    REGEX = /
      ^>\s*\[!(?<type>[A-Za-z_-]+)\]\s*(?<title>[^\n]*)\n   # шапка callout
      (?<body>(?:^>.*\n)+)                                  # все следующие строки, начинающиеся с >
    /x

    # запустим перед рендером markdown → html
    Jekyll::Hooks.register [:pages, :documents], :pre_render do |doc|
      next unless doc.content
      content = doc.content.dup

      content.gsub!(REGEX) do
        m      = Regexp.last_match
        type   = (m[:type] || "").downcase
        title  = (m[:title] || "").strip
        body   = (m[:body]  || "").gsub(/^>\s?/, '')   # убираем ведущие '> '

        meta   = CALLOUTS[type] || {label: type.capitalize, css: type}
        heading = title.empty? ? meta[:label] : title

        %Q(
<div class="callout #{meta[:css]}">
  <div class="callout-title">#{heading}</div>
  <div class="callout-content">
#{body}
  </div>
</div>
)
      end

      doc.content = content
    end
  end
end
