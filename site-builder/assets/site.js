/* assets/site.js */
(() => {
  document.documentElement.classList.add("js");

  // Page entrance
  window.addEventListener("DOMContentLoaded", () => {
    requestAnimationFrame(() => document.body.classList.add("page-ready"));
  });

  // Reading progress bar
  const bar = document.querySelector(".reading-progress__bar");
  const update = () => {
    if (!bar) return;
    const doc = document.documentElement;
    const max = doc.scrollHeight - window.innerHeight;
    const pct = max > 0 ? (window.scrollY / max) * 100 : 0;
    bar.style.width = `${Math.min(100, Math.max(0, pct)).toFixed(2)}%`;
  };
  window.addEventListener("scroll", update, { passive: true });
  window.addEventListener("resize", update);
  update();

  // Copy buttons for code blocks (quiet UI)
  document.querySelectorAll("pre").forEach(pre => {
    const code = pre.querySelector("code");
    if (!code) return;

    const btn = document.createElement("button");
    btn.type = "button";
    btn.textContent = "Copy";
    btn.className = "copy-btn";
    btn.setAttribute("aria-label", "Copy code to clipboard");

    btn.addEventListener("click", async () => {
      try {
        await navigator.clipboard.writeText(code.innerText);
        btn.textContent = "Copied";
        setTimeout(() => (btn.textContent = "Copy"), 900);
      } catch {
        btn.textContent = "No access";
        setTimeout(() => (btn.textContent = "Copy"), 900);
      }
    });

    pre.appendChild(btn);
  });
})();

