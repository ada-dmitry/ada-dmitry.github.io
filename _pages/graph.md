---
title: "Граф заметок"
permalink: /graph/
layout: single
---

<div id="mynetwork" style="width:100%;height:70vh"></div>
<script src="https://unpkg.com/vis-network/standalone/umd/vis-network.min.js"></script>
<script>
  fetch("{{ '/graph.json' | relative_url }}").then(r=>r.json()).then(data=>{
    const nodes = data.nodes.map(n=>({id:n.id,label:n.title,url:n.url}));
    const edges = data.edges.map(e=>({from:e.source,to:e.target}));
    const net = new vis.Network(document.getElementById('mynetwork'),{nodes,edges},{});
    net.on("click", p => { if(p.nodes.length){ const n = nodes.find(x=>x.id===p.nodes[0]); if(n?.url) location.href=n.url; }});
  });
</script>
