---
layout: default
title: Orchestrator
permalink: /orchestrator/
---

# Workflow-Orchestrator v0.5.0

## Funktionsumfang

Der eigenständige Compose-Service `orchestrator` verarbeitet **ausschließlich sichere Preflight-Runs** von zuvor freigegebenen Maintenance Tasks. Er führt weder Git-Befehle noch Coding Agents oder Repository-Code aus. Die Architektur trennt API, persistente Run-Historie und Worker.

- PostgreSQL ist das führende System für Run-Zustände und Audit-Ereignisse.
- Redis dient ausschließlich als schneller Wake-up-Hinweis (`agent-runs:wakeup`). Auch bei Redis-Ausfall sucht der Worker in der Datenbank nach wartenden Jobs.
- Maximal ein aktiver Run je Task durch einen partiellen Unique Index.
- `SELECT … FOR UPDATE SKIP LOCKED` verhindert gleichzeitige Übernahme desselben Runs durch mehrere Worker.
- Zustände: `queued → running → completed/failed/timed_out`; kein automatischer Git-Push.
- Der sichere Preflight ist ein Platzhalter; echte Agentenaufgaben folgen erst nach Implementierung isolierter Ausführung und unabhängiger Validation.

## API

Alle Endpunkte benötigen `X-Admin-Key` aus `.env`.

| Methode | Route | Funktion |
|---|---|---|
| GET | `/api/v1/runs` | Letzte 100 Runs |
| POST | `/api/v1/runs/task/{task_id}` | Freigegebenen Task zur Preflight-Prüfung einreihen |
| GET | `/api/v1/runs/{run_id}/events` | Nachvollziehbare Schrittereignisse |

Beispiel:

```bash
curl -X POST -H "X-Admin-Key: DEIN_ADMIN_API_KEY" \
  http://127.0.0.1:45001/api/v1/runs/task/1
curl -H "X-Admin-Key: DEIN_ADMIN_API_KEY" \
  http://127.0.0.1:45001/api/v1/runs
```

## Lokaler Start

```bash
git pull
just test
just build
just run
just ps
docker compose -f compose.yaml logs -f orchestrator
```

`orchestrator` hat keinen öffentlich zugänglichen Port, keine Docker-Socket-Mounts und keinen direkten Git-Schreibzugriff. Die Migration `004` legt `agent_runs` und `agent_run_events` an.

## Einschränkungen und nächste Phase

Die maximale Anzahl von Versuchen ist derzeit als Datenfeld erfasst, aber automatische Retries sind **noch nicht implementiert**. Bei Neustart werden vorher laufende Jobs zur Sicherheit als fehlgeschlagen markiert. Kein Task wird automatisch erneut ausgeführt. Der Worker ist zunächst für eine einzelne Instanz vorgesehen. Vor dem Einsatz mehrerer Worker müssen Lease-/Heartbeat-Regeln und eine differenzierte Recovery ergänzt werden.

Das bisherige Frontend ist weiterhin statisches HTML; eine vollständige Nuxt-4-Anwendung ist noch nicht implementiert. Auch echte Jobdauer/Timeout-Tests gegen PostgreSQL und Redis sowie Docker-End-to-End-Prüfungen sind noch ausstehend.


{% include glossary.md %}
