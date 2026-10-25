---
layout: single
title: Docker-Befehle und Browserstart
permalink: /docker-commands/
---

# Docker-Rezeptnamen und Browser-Start

Ab Version 0.7.2 besitzen **Docker-spezifische** Just-Recipes den Präfix `docker-`.

| Alt | Neu |
| --- | --- |
| `just build` | `just docker-build` |
| `just up` | `just docker-up` |
| `just down` | `just docker-down` |
| `just ps` | `just docker-ps` |
| `just logs` | `just docker-logs` |
| `just status` | `just docker-status` |
| `just ai-up` | `just docker-ai-up` |
| `just git-up` | `just docker-git-up` |
| `just forge-up` | `just docker-forge-up` |
| `just run-core` | `just docker-run-core` |
| `just model-pull MODEL` | `just docker-model-pull MODEL` |
| `just integration` | `just docker-integration` |

Die generischen Einstiegspunkte `just bootstrap`, `just setup`, `just test`, `just ci`, `just ci-branch`, `just install`, `just run` und `just doctor` bleiben für Update CLI erhalten. `just run` delegiert an `just docker-up`; der Update-CLI-Build verwendet `just docker-build`.

## Browser

```bash
just docker-up
just open
```

`just open` liest `HOST_BIND_ADDRESS` und `FRONTEND_PORT` aus der vorhandenen `.env`, validiert die lokale Loopback-Konfiguration und öffnet das Dashboard im Standardbrowser (macOS, Linux mit Desktop oder Windows mit Python). Bei Headless-Systemen zeigt es die URL und meldet einen Fehler, wenn sich kein Browser starten lässt. Es startet **keine** Container.

## Lokale Prüfung

```bash
just --list
just ci
just docker-ps
just open
```

Die Umbenennung verändert keine Container, Volumes oder Netzwerke. Die lokalen Docker-Prüfungen sind auf einem Rechner mit Docker/just zu bestätigen.
