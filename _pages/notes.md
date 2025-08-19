---
layout: single
title: Все заметки
permalink: /notes/
---

{%- assign notes_with_project = "" | split: "" -%}
{%- for n in site.notes -%}
  {%- assign parts = n.path | split: "/" -%}
  {%- assign project_name = parts[1] -%}  {# parts[0] = "_notes", parts[1] = подпапка #}
  {%- assign n = n | merge: { "project": project_name } -%}
  {%- assign notes_with_project = notes_with_project | push: n -%}
{%- endfor -%}

{%- assign groups = notes_with_project | group_by: "project" | sort: "name" -%}

{%- for g in groups -%}
### {{ g.name }} ({{ g.items | size }})

<ul>
  {%- assign items = g.items | sort: "basename" -%}
  {%- for n in items -%}
    <li><a href="{{ n.url | relative_url }}">{{ n.title }}</a></li>
  {%- endfor -%}
</ul>
{%- endfor -%}
