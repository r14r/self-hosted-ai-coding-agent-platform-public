---
layout: default
title: Installation
permalink: /setup/
---
# Lokale Installation

```bash
git clone https://github.com/r14r/self-hosted-ai-coding-agent-platform.git
cd self-hosted-ai-coding-agent-platform
just bootstrap
# Passwort in .env ändern
just setup
just run
```

Lokale Endpunkte: [Dashboard](http://localhost:3000) und [FastAPI Docs](http://localhost:8000/docs). Optional: `just ai-up` und `just git-up`.

## Jekyll lokal starten

```bash
bundle install
bundle exec jekyll serve
```

Projektwebseite: http://127.0.0.1:4000/self-hosted-ai-coding-agent-platform-public/

Für die Online-Veröffentlichung in den Repository-Einstellungen unter **Pages → Build and deployment → Source → GitHub Actions** wählen. Die Action `Deploy Jekyll site` baut und publiziert den Repository-Stammverzeichnis.

**Hinweis:** GitHub Pages ist eine öffentlich zugängliche Website, auch bei einem privaten Quellrepository.

{% include glossary.md %}
