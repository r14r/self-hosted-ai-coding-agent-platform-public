---
layout: default
title: Installation
permalink: /setup/
---

## 7. Docker Compose — Istzustand und lokaler Start

Im privaten Anwendungsrepository liegt die ausführbare Grundlage unter `compose.yaml`: `backend`, `frontend` (statisch), `postgres`, `redis`; optionale Profile für `ollama` und `gitea`. Die ursprünglich diskutierte vollständige Serviceaufteilung ist **eine Zielkonfiguration, keine bereits lauffähige Compose-Datei**.

```bash
git clone https://github.com/r14r/self-hosted-ai-coding-agent-platform.git
cd self-hosted-ai-coding-agent-platform
just bootstrap
# POSTGRES_PASSWORD in .env vor dem Start ändern
just setup
just test
just build
just run
just open
```

Weitere Workflows: `just doctor`, `just logs`, `just down`, `just ai-up`, `just git-up`, `just model-pull MODEL`, `just precommit` und `just ci`. Für `update-cli` sind `bootstrap`, `setup`, `test`, `build`, `install`, `run`, `open` und `update` vorgesehen. Die Schema-10-Kompatibilität von `update-cli.yaml` ist mit der lokal installierten CLI zu prüfen.

Für produktive Szenarien: Versionen/Digests pinnen, Secrets von `.env` trennen, Backups und Healthchecks ergänzen und isolierte Runner/VMs bereitstellen.

### Geplantes Monorepo

```text
VERSION · README.md · AGENTS.md · SOURCE.md · update-cli.yaml · justfile
compose.yaml · compose.ai.yaml · compose.git.yaml · compose.monitoring.yaml
services/{frontend,backend,orchestrator,worker,sandbox-executor}
packages/{agent-core,agent-adapters,git-providers,validators,policy-engine,sandbox-providers}
config/{litellm.yaml,agents,policies,workflows,repository-profiles}
sandboxes/{python,go,node,generic}
tests/{unit,integration,e2e,evaluations,security}
fixtures/{vulnerable-python-app,broken-go-service,outdated-node-app}
docs/assets/
```

Diese Struktur ist die **Zielstruktur**; fehlende Verzeichnisse dürfen nicht als implementiert ausgegeben werden.

## 13. Jekyll / GitHub Pages

Die öffentlich lesbare Dokumentations-Website liegt separat unter [self-hosted-ai-coding-agent-platform-public](https://github.com/r14r/self-hosted-ai-coding-agent-platform-public). Dort baut der GitHub-Actions-Workflow Jekyll und publiziert nach Freigabe der Repository-Einstellung **Settings → Pages → Source: GitHub Actions**.

Website (nach erfolgreichem Deployment): https://r14r.github.io/self-hosted-ai-coding-agent-platform-public/

Nur öffentlich freigegebene Projektbeschreibungen, Diagramme und Demonstrationsdaten gehören in das Pages-Repository; keine Zugangsdaten oder proprietären Codeinhalte.

[**Zur vollständigen Projektdokumentation**]({{ '/documentation/' | relative_url }})

{% include glossary.md %}
