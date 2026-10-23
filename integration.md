---
layout: single
title: Integration und Startbereitschaft
permalink: /integration/
---

# Integration und Betrieb – v0.5.4

Der neue Meilenstein stabilisiert den Infrastrukturstart. Der FastAPI-Backend-Dienst hat einen HTTP-Healthcheck, Redis einen PING-Healthcheck. Der Orchestrator startet erst, wenn das Backend seine Migrationen abgeschlossen hat und als gesund gilt. Dadurch wird ein möglicher Startkonflikt zwischen Datenbankmigration und Worker vermindert.

## Befehle

```bash
git pull
just test          # Unit-Tests in einem temporären Python-3.12-Container
just build         # Backend-Image bauen
just run           # Alle Kern-, KI- und Git-Dienste starten
just smoke         # Lesende lokale API-Checks (Backend, Gitea)
just integration   # Kern- und Git-Dienste starten/prüfen; anschließend Smoke-Test
```

`just integration` benötigt eine gültige `.env`, Docker Compose und Netzwerkzugang zu lokalen Images. Der Smoke-Test sendet **keine** schreibenden HTTP-Anfragen, prüft aber die lokale Erreichbarkeit der FastAPI- und Gitea-Endpunkte. Er ist kein umfassender Integrationstest für PostgreSQL, Redis, Gitea Actions oder mehrere Runner. Der Testcontainer bindet `tests/`, `scripts/` und `compose.yaml` schreibgeschützt ein.

## Sicherheits- und Testgrenzen

Es wird weder ein Git-Repository ausgeführt noch ein Runner registriert. Bestehende Container/Volumes werden durch `just integration` nicht gelöscht. Die neuen Healthchecks stellen nur Startbereitschaft fest und garantieren keine funktionale End-to-End-Verarbeitung. Die lokalen Docker-Tests sind nach dem Merge auf dem Zielhost auszuführen.

## Nächster Schritt

v0.6.0: abgesicherte Sandbox-Architektur und OpenCode-Adapter; vorher echte Persistenz-/Queue-Integrationstests und Runner-Validierung vervollständigen.
