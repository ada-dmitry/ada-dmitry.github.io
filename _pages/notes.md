---
layout: single
title: Все заметки
permalink: /notes/
---

{%- comment -%}
Группируем по project (лучше проставлять через defaults по подпапке),
внутри каждой группы сортируем по order (число), потом по title.
{%- endcomment -%}

{%- assign groups = site.notes | group_by: "project" | sort: "name" -%}

{%- for g in groups -%}
### {{ g.name | default: "Без проекта" }} ({{ g.items | size }})

<ul>
  {%- assign items = g.items | sort: "title" -%}        {# вторичный ключ #}
  {%- assign items = items   | sort: "order" -%}        {# первичный ключ  #}
  {%- for n in items -%}
    <li>
      <a href="{{ n.url | relative_url }}">{{ n.title }}</a>
      {%- if n.order and n.order != 999 -%} <small>(№{{ n.order }})</small>{%- endif -%}
    </li>
  {%- endfor -%}
</ul>

{%- endfor -%}
