---
layout: single
title: Все заметки
permalink: /notes/
---

<ul>
{% assign sorted = site.notes | sort: "title" %}
{% for note in sorted %}
  <li><a href="{{ note.url | relative_url }}">{{ note.title }}</a></li>
{% endfor %}
</ul>
