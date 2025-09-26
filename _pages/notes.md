---
layout: single
title: "Все заметки"
permalink: /notes/
sidebar:
  nav: mobile_nav
---

{%- assign by_folder = site.notes
  | group_by_exp: "n", "n.path | remove_first: '_notes/' | split: '/' | first" -%}

{%- for g in by_folder -%}
  {%- assign folder = g.name -%}
  {%- if folder == g.items[0].path -%}{% assign folder = "Без проекта" %}{% endif %}

### {{ folder }} ({{ g.items | size }})

<ul>
{%- assign items = g.items | sort: "basename" -%}
{%- for n in items -%}
  <li><a href="{{ n.url | relative_url }}">{{ n.title }}</a></li>
{%- endfor -%}
</ul>

{%- endfor -%}
