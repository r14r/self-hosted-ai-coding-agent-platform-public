---
layout: default
title: Update CLI und Installation
permalink: /update-cli-install/
---

## Update CLI / just install (v0.5.2)

Das Repository unterstützt `just install` ausdrücklich. Die Recipe erstellt das Backend-Container-Image nach den vorgeschalteten Tests und validiert die Compose-Konfiguration; sie startet keine Dienste und löscht keine Datenvolumes. `update-cli.yaml` enthält jetzt auch die Workflows und Tasks `install`. Die GitHub-Actions-CI überprüft das Vorhandensein aller erforderlichen Recipes.

**Achtung bei Update-CLI-Installationen:** Die lokale `current/justfile` kann vom GitHub-Branch `main` abweichen. Prüfe `just --list` und `git rev-parse HEAD` in der tatsächlichen `current`-Installation. Ein `git pull` im Quell-Checkout aktualisiert nicht zwingend automatisch den von Update CLI verwalteten `current`-Ordner.

```bash
just --list
just install
update-cli doctor
update-cli setup --list
```

Die Regeln zum Manifest bleiben getrennt: `update-cli.yaml` verwendet `schemaVersion: 2`, die lokale Runtime-Konfiguration unter `.update-cli/config.json` hat ein unabhängiges Schema 10.



{% include glossary.md %}
