---
layout: single
title: Gitea Actions und KI bei Commits
permalink: /commit-actions/
---

# Gitea Actions – KI-Prüfung bei Commits

Die Plattform verwendet die **native Gitea-Weboberfläche** für Repositories, Branches, Pull Requests, Issues und Actions. Ein separater Dashboard-Dienst zeigt den Status der Plattform sowie Tasks und Runs. Eine in GitHub-Syntax geschriebene `.gitea/workflows/ai-commit.yaml` wird auf Push nach `main` gestartet und kann manuell via `workflow_dispatch` angestoßen werden.

## Voraussetzung: Runner

Ein Actions-Workflow läuft erst, wenn ein Gitea-Runner registriert und online ist. Das Beispiel unter `runners/compose.yaml` ist für eine **dedizierte, vertrauenswürdige Runner-VM**, nicht für den Control-Plane-Host. Der Docker-Socket verleiht Jobs weitreichende Rechte auf der Runner-VM; untrusted/fremde Repositories dürfen diesen Runner nicht nutzen.

1. In Gitea unter Site Administration oder Repository Settings → Actions → Runners einen Registrierungstoken erzeugen.
2. `runners/.env.example` nach `runners/.env` kopieren und die Gitea-URL aus Sicht des Runners sowie den Token konfigurieren.
3. **Nur auf der isolierten Runner-VM:** `docker compose --env-file runners/.env -f runners/compose.yaml up -d`.
4. Prüfen, ob die Labels `ci` und `ai` online sind und eine Python-3.12-Containerumgebung starten.

## Ollama konfigurieren

Im Gitea-Repository unter Settings → Actions → Variables:
- `AI_OLLAMA_URL`: vom Jobcontainer erreichbare interne Ollama-URL, zum Beispiel ein privater DNS-Name oder eine private IP mit Port 11434; `localhost` des Jobcontainers ist **nicht** der Ollama-Dienst.
- `AI_OLLAMA_MODEL`: bereits heruntergeladenes Ollama-Modell.

Die KI-Aktion ruft die Ollama-API `/api/generate` synchron auf und schreibt das Ergebnis in den Gitea-Actions-Log. Bei fehlendem Runner, Modell oder Netzwerkverbindung schlägt der Job erkennbar fehl.

**Abgrenzung:** Es wird nur Repository-Name und Commit-SHA an das Modell übermittelt, **kein Git-Diff**, kein Repository-Code ausgeführt, kein PR erstellt oder Commit gepusht. Die Antwort ist daher eine heuristische Checkliste und kein inhaltliches Code-Review. Andere Repositories benötigen ihre eigene Workflowdatei (oder ein freigegebenes Workflow-Template).

## Starten und prüfen

```bash
git pull
just bootstrap
just test
just run
just smoke
```

Weboberflächen (Standardports): Dashboard 45000, Gitea 45002, Git-Forge-Portal 45004. Die Gitea-Actions-Ansicht und Runner-Status müssen separat im Browser geprüft werden; erfolgreicher CI-Job setzt einen online registrierten Runner voraus.
