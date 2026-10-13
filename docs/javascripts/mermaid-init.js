document.addEventListener("DOMContentLoaded", () => {
  if (typeof mermaid === "undefined") return;
  mermaid.initialize({ startOnLoad: false, securityLevel: "strict", theme: "default" });
  const render = () => mermaid.run({ querySelector: ".mermaid" });
  render();
  if (typeof document$ !== "undefined") document$.subscribe(render);
});
