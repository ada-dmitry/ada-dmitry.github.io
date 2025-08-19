---
layout: single
title: Все заметки
permalink: /notes/
---

{%- comment -%}
Группируем _notes/<ПАПКА>/<NN>-name.md по "<ПАПКА>".
Внутри группы сортируем по NN (числовой префикс из basename).
Если файл лежит прямо в _notes/ без подпапки — группа "Без проекта".
{%- endcomment -%}

{%- assign by_folder = site.notes
  | group_by_exp: "n", "n.path | remove_first: '_notes/' | split: '/' | first" -%}

{%- for g in by_folder -%}
  {%- assign folder = g.name -%}
  {%- if folder contains '.md' -%}{% assign folder = "Без проекта" %}{% endif %}

### {{ folder }} ({{ g.items | size }})

{%- assign items_with_ord = "" | split: "" -%}
{%- for n in g.items -%}
  {%- assign base = n.path | split: '/' | last | split: '.' | first -%}
  {%- assign num_str = base | split: '-' | first -%}
  {%- assign ord = num_str | plus: 0 -%}
  {%- if ord == 0 and num_str != "0" -%}{% assign ord = 9999 %}{% endif %}
  {%- assign n2 = n | merge: {"ord": ord} -%}
  {%- assign items_with_ord = items_with_ord | push: n2 -%}
{%- endfor -%}

<ul>
{%- assign items = items_with_ord | sort: "ord" -%}
{%- for n in items -%}
  <li><a href="{{ n.url | relative_url }}">{{ n.title }}</a></li>
{%- endfor -%}
</ul>

{%- endfor -%}
