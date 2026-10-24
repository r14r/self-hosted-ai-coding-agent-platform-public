---
layout: single
title: Lokale CI und Branch-Prüfung
permalink: /local-ci/
---

# Lokale CI und Branch-Prüfung

Die Recipes erlauben lokale Tests mit Docker Compose und einem expliziten Git-Branch.

```bash
just ci                 # Aktuellen Checkout ohne Branch-Wechsel prüfen
just ci-branch          # Aktuellen Branch bei origin abrufen, fast-forward, dann CI
just ci-branch main     # main auschecken, fast-forward, dann CI
just ci-branch feature/example
```

**Ablauf von `just ci`:** Python-Syntaxprüfung (`fmt-check`), Unit-Tests im Python-3.12-Backend-Testcontainer, Prüfung der `.env` und Compose-Konfiguration sowie Image-Build. Es startet keinen Git-Runner, keine Tests gegen eine produktive Datenbank und keine laufende Ollama-Agentenausführung. Ein richtiger Ruff-Linter ist noch nicht eingerichtet; `lint` prüft derzeit Python-Syntax.

**Ablauf von `just ci-branch`:** Der Befehl bricht bei lokalen Änderungen oder nicht ignorierten unversionierten Dateien ab. Er erwartet einen Branch in `origin`, führt `git fetch --prune origin` aus, verwendet `git switch` und danach `git merge --ff-only origin/<branch>`. Konflikte und divergierende Historien werden nicht automatisch aufgelöst. Anschließend wird `just ci` aus dem frisch ausgecheckten Projektverzeichnis ausgeführt. Es gibt **kein** automatisches `reset --hard`, `clean` oder Rebase.

**Hinweis:** Ein abweichender lokaler Branch, der keine gleichnamige Remote-Branch unter `origin` besitzt, kann mit `just ci` geprüft werden, aber nicht mittels `just ci-branch` aktualisiert werden.

Voraussetzungen: Git, just, Python 3, Docker Engine/Compose sowie eine gültige projektspezifische `.env`. Der Docker-Daemon und die realen Runner werden durch den Quellcode-Commit nicht automatisch verifiziert.
