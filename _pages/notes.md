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
  {%- comment -%} Проверяем, является ли "папка" на самом деле файлом {%- endcomment -%}
  {%- if folder == g.items.first.path | split: '/' | last | split: '.' | first -%}
    {%- assign folder = "Без проекта" -%}
  {%- endif -%}

### {{ folder }} ({{ g.items | size }})

{%- comment -%}
  Создаем массив пар "префикс|заметка" для сортировки
{%- endcomment -%}
{%- assign sorted_pairs = "" | split: "" -%}
{%- for n in g.items -%}
  {%- assign base = n.path | split: '/' | last | split: '.' | first -%}   {# 01-hs -> "01-hs" #}
  {%- assign num_str = base | split: '-' | first -%}                       {# "01" #}
  {%- assign ord = num_str | plus: 0 -%}                                   {# 0 если нет числа #}
  {%- if ord == 0 and num_str != "0" -%}{% assign ord = 9999 %}{% endif %} {# без префикса — в конец #}

  {%- comment -%} Форматируем порядковый номер с ведущими нулями для правильной сортировки {%- endcomment -%}
  {%- assign ord_padded = ord -%}
  {%- if ord < 10 -%}{% assign ord_padded = ord | prepend: "000" %}{% endif -%}
  {%- if ord < 100 and ord >= 10 -%}{% assign ord_padded = ord | prepend: "00" %}{% endif -%}
  {%- if ord < 1000 and ord >= 100 -%}{% assign ord_padded = ord | prepend: "0" %}{% endif -%}

  {%- assign pair = ord_padded | append: "|" | append: forloop.index0 -%}
  {%- assign sorted_pairs = sorted_pairs | push: pair -%}
{%- endfor -%}

<ul>
{%- assign sorted_pairs = sorted_pairs | sort -%}
{%- for pair in sorted_pairs -%}
  {%- assign parts = pair | split: "|" -%}
  {%- assign index = parts[1] | plus: 0 -%}
  {%- assign n = g.items[index] -%}
  <li><a href="{{ n.url | relative_url }}">{{ n.title }}</a></li>
{%- endfor -%}
</ul>

{%- endfor -%}
