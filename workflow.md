---
layout: default
title: Workflow
permalink: /workflow/
---
# Wartungsworkflow

![Workflow]({{ '/assets/workflow.svg' | relative_url }})

1. Repository read-only analysieren.
2. Maintenance Task und Akzeptanzkriterien definieren.
3. Wartungsbranch und Baseline erstellen.
4. Agent in isolierter Ausführungsumgebung arbeiten lassen.
5. Build, Tests, Lint und Security-Scans unabhängig ausführen.
6. Diff, Scope, Regressionen und Testmanipulation bewerten.
7. Pull Request mit Nachweisen erzeugen.
8. Human Review und Freigabe.

Ein fehlgeschlagener Pflicht-Test kann nicht durch eine positive LLM-Bewertung überstimmt werden.
