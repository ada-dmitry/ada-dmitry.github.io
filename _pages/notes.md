---
layout: single
title: Все заметки
permalink: /notes/
---

{%- comment -%}
Берём _notes/HomeServer/hs1.md → группируем по "HomeServer".
Если файл лежит прямо в _notes/, кладём его в группу "Без проекта".
{%- endcomment -%}

{%- assign by_folder = site.notes
  | group_by_exp: "n", "n.path | remove_first: '_notes/' | split: '/' | first" -%}

{%- for g in by_folder -%}
  {%- assign folder = g.name -%}
  {%- if folder == g.items[0].path -%}{% assign folder = "Без проекта" %}{% endif %}

### {{ folder }} ({{ g.items | size }})

<ul>
{%- assign items = g.items | sort: "title" -%} {# или "date" | reverse #}
{%- for n in items -%}
  <li><a href="{{ n.url | relative_url }}">{{ n.title }}</a></li>
{%- endfor -%}
</ul>

{%- endfor -%}
