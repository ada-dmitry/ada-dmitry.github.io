---
title: "Проекты"
layout: single
permalink: /projects/
description: Подборка моих активных проектов: Домашняя лаборатория (Homelab) и конспекты Летней IT‑школы КРОК.
---

# Проекты

Ниже — мои текущие живые проекты. Это не статичные статьи, а развивающиеся хабы с практикой, конспектами и дорожной картой.

<style>
.projects-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 1rem;
  margin-top: .75rem;
}
.project-card {
  border: 1px solid #e5e7eb;
  border-radius: 12px;
  padding: 1rem 1.1rem;
  background: #fff;
  box-shadow: 0 1px 2px rgba(0,0,0,.04);
  transition: transform .18s ease, box-shadow .18s ease;
}
.project-card:hover { transform: translateY(-2px); box-shadow: 0 8px 22px rgba(0,0,0,.08); }
.project-title { margin: 0 0 .35rem; font-size: 1.15rem; }
.project-desc { margin: .35rem 0 .75rem; color: #4b5563; }
.badges { display: flex; flex-wrap: wrap; gap: .4rem; margin: 0 0 .8rem; }
.badge {
  display: inline-block; padding: .18rem .5rem; border-radius: 999px;
  font-size: .8rem; line-height: 1; background: #f3f4f6; color: #374151; border: 1px solid #e5e7eb;
}
.project-actions { display: flex; gap: .5rem; flex-wrap: wrap; }
.btn {
  display: inline-block; padding: .45rem .75rem; border-radius: 8px; font-weight: 600;
  text-decoration: none; border: 1px solid #111827; color: #111827;
}
.btn:hover { background: #111827; color: #fff; }
.btn.secondary { border-color: #6b7280; color: #374151; }
.btn.secondary:hover { background: #6b7280; color: #fff; }
@media (prefers-color-scheme: dark) {
  .project-card { background: #111; border-color: #222; box-shadow: none; }
  .project-desc { color: #c7c7c7; }
  .badge { background: #1a1a1a; color: #d1d5db; border-color: #2a2a2a; }
  .btn { border-color: #e5e7eb; color: #e5e7eb; }
  .btn:hover { background: #e5e7eb; color: #111; }
  .btn.secondary { border-color: #9ca3af; color: #d1d5db; }
  .btn.secondary:hover { background: #9ca3af; color: #111; }
}
</style>

<div class="projects-grid">

  <div class="project-card">
    <h3 class="project-title">🏠 Домашняя лаборатория (Homelab)</h3>
    <div class="badges">
      <span class="badge">Proxmox VE</span>
      <span class="badge">KVM/LXC</span>
      <span class="badge">WireGuard</span>
      <span class="badge">VPS + Reverse‑proxy</span>
    </div>
    <p class="project-desc">
      Практический цикл о мини‑ПК и Proxmox: виртуалки и контейнеры, публикация сервисов через туннели и VPS,
      инфраструктурные принципы и безопасность. Внутри — обзор, быстрые ссылки и дорожная карта.
    </p>
    <div class="project-actions">
      <a class="btn" href="/homelab/">Перейти в хаб</a>
      <a class="btn secondary" href="/homelab/#публикации">Публикации</a>
    </div>
  </div>

  <div class="project-card">
    <h3 class="project-title">📘 Летняя IT‑школа КРОК (Системная инженерия)</h3>
    <div class="badges">
      <span class="badge">Виртуализация</span>
      <span class="badge">Сети</span>
      <span class="badge">Мониторинг</span>
      <span class="badge">Бэкапы</span>
    </div>
    <p class="project-desc">
      Конспекты и практические заметки по курсу системной инженерии: основы инфраструктуры, автоматизация,
      виртуализация, базовые сетевые службы, СРК и мониторинг. Постепенно пополняется.
    </p>
    <div class="project-actions">
      <a class="btn" href="/system-engineer/">Перейти в хаб</a>
      <a class="btn secondary" href="/system-engineer/#📘-теория">Оглавление</a>
    </div>
  </div>

</div>

---

Подобные страницы‑хабы помогают отслеживать прогресс и быстро переходить к нужным разделам. Если видите неточности — дайте знать, поправлю.