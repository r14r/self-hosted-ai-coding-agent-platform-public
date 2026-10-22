---
layout: single
title: Testumgebung
permalink: /testing/
---

## Testkorrektur v0.5.1

`just test` startet die Unit-Tests im **Backend-Docker-Image (Python 3.12)** und verwendet exakt dessen `requirements.txt`-Abhängigkeiten, einschließlich `asyncpg` und `redis`. Es installiert keine Pakete in das lokale Homebrew-Python (auch nicht Python 3.15). Die Tests werden als Read-only-Bind-Mount in den Container eingebunden, ohne PostgreSQL/Gitea/Ollama starten zu müssen.

Der fehlerhafte `.github/workflows`-Test-Mock wurde korrigiert: Er antwortete auf das übergeordnete Verzeichnis, bevor das spezifische Workflow-Verzeichnis geprüft wurde. Ein zusätzlicher Test deckt `.gitea/workflows` ab. Die produktive Erkennung dieser beiden Pfade war bereits vorhanden.

```bash
git pull
just test
just build
```

Benötigt werden Docker Engine/Compose, `just` und eine gültige `.env`. Der erstmalige Backend-Image-Build kann Pakete herunterladen. `just test` schlägt bei fehlgeschlagenen Tests unverändert mit einem Fehlercode fehl.


{% include glossary.md %}
