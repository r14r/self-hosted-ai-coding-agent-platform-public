(() => {
  function init() {
    const toc = document.querySelector('.sidebar__right .toc');
    const content = document.querySelector('.page__content');
    if (!toc || !content) return;
    const links = Array.from(toc.querySelectorAll('a[href*="#"]'));
    const items = links.map(link => {
      const target = new URL(link.href, location.href);
      if (target.pathname !== location.pathname) return null;
      const heading = document.getElementById(decodeURIComponent(target.hash.slice(1)));
      return heading && content.contains(heading) ? { link, heading } : null;
    }).filter(Boolean);
    if (!items.length) return;
    const scrollbox = toc.querySelector('.toc__menu') || toc;
    let current = null, queued = false;
    function update() {
      queued = false;
      const masthead = document.querySelector('.masthead');
      const threshold = Math.max(100, (masthead?.getBoundingClientRect().height || 0) + 48);
      let selected = items[0];
      for (const item of items) {
        if (item.heading.getBoundingClientRect().top <= threshold) selected = item;
        else break;
      }
      if (selected === current) return;
      current = selected;
      for (const item of items) {
        const active = item === selected;
        item.link.classList.toggle('is-active', active);
        if (active) item.link.setAttribute('aria-current', 'location');
        else item.link.removeAttribute('aria-current');
      }
      const a = selected.link.getBoundingClientRect(), b = scrollbox.getBoundingClientRect();
      if (a.top < b.top || a.bottom > b.bottom)
        scrollbox.scrollTo({ top: scrollbox.scrollTop + a.top - b.top - b.height / 2 + a.height / 2, behavior: 'smooth' });
    }
    function schedule() { if (!queued) { queued = true; requestAnimationFrame(update); } }
    addEventListener('scroll', schedule, { passive: true });
    addEventListener('resize', schedule, { passive: true });
    addEventListener('hashchange', schedule);
    update();
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', init);
  else init();
})();
