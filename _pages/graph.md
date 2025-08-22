---
layout: single
title: "Граф заметок"
permalink: /graph/
---

<div id="graph" style="height:70vh"></div>

<script src="https://unpkg.com/force-graph"></script>
<script>
  fetch('{{ "/graph.json" | relative_url }}')
    .then(r => r.json())
    .then(data => {
      const el = document.getElementById('graph');
      const Graph = ForceGraph()(el)
        .graphData(data)
        .nodeId('id')
        .nodeLabel(n => n.title)
        .nodeAutoColorBy('group')
        .backgroundColor(getComputedStyle(document.body).backgroundColor || '#111')
        .linkColor(() => 'rgba(173,216,230,0.6)')
        .linkDirectionalParticles(2)
        .linkDirectionalParticleSpeed(0.004)
        .onNodeClick(n => window.location = n.url);

      // чуть уменьшить размеры узлов/шрифтов для тёмной темы
      Graph.nodeRelSize(6);
    });
</script>
