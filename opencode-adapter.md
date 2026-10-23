---
layout: single
title: OpenCode-Adapter v0.6.0
permalink: /opencode-adapter/
---

# OpenCode-Adapter v0.6.0 – Planung ohne Ausführung

Der neue Adapter erzeugt für **freigegebene** Maintenance Tasks einen strukturierten Plan mit Ollama-Modell, Auftragsbeschreibung, Akzeptanzkriterien und dokumentierten Sicherheitsgrenzen. **Es findet keine Codeausführung statt.** Dies ist ein abgeschlossener erster Teil von v0.6.0; der isolierte Sandbox-Executor folgt gesondert.

## Admin-API

- `GET /api/v1/agents/capabilities`: zeigt den Adapter `opencode`, Provider `ollama` und `execution_enabled: false`.
- `POST /api/v1/agents/plan`: benötigt `X-Admin-Key` und JSON `{"task_id":1,"model":"ollama/qwen3-coder:latest"}`. Der Task muss bereits `approved` sein.

Das Modell muss ausdrücklich mit `ollama/` beginnen und ein begrenztes, validiertes Zeichenformat verwenden. Die Rückgabe enthält eine **command_preview**, keinen gestarteten Prozess. Sie erlaubt keinen Docker-Socket und keinen Git-Push. In v0.6.0 werden diese Felder nur deklariert, **nicht technisch in einer Sandbox durchgesetzt**, weil diese noch nicht existiert.

## Verifikation

Unit-Tests prüfen zulässige Modelle, die gesperrte Ausführung und die Länge der Tasks. `just test` ist lokal zu prüfen. Noch nicht implementiert: Workspace-Provisionierung, tatsächlicher OpenCode-Prozess, Ollama-Modelltest, Netzwerkgrenzen, Ressourcenlimits, unabhängige Validation, PR-Publisher.
