---
layout: default
title: Start
permalink: /
---
# Sichere, lokale KI-Agenten für Softwarewartung

Eine modular aufgebaute Self-Hosted-Plattform für Git-Repositories: Wartungsbedarf analysieren, isolierte Coding Agents steuern, Code unabhängig validieren und geprüfte Pull Requests für menschliche Reviews erzeugen.

**Projektstatus:** Aktuell ist die lokale Compose-Infrastruktur als Foundation verfügbar. Autonome Codeänderungen und abgesicherte Sandboxes sind noch nicht implementiert.

![Architektur]({{ '/assets/architecture.svg' | relative_url }})

## Grundprinzipien

- **Local first:** Docker Compose und Ollama, ohne erforderliche Cloud-LLM-API.
- **Sicheres Ausführen:** Agent und unbekannter Code laufen nur in vorgesehenen isolierten Umgebungen.
- **Unabhängige Qualitätssicherung:** Tests und Security Gates außerhalb des Agents.
- **Human in the loop:** Ein Mensch prüft den Pull Request vor dem Merge.

[Architektur]({{ '/architecture/' | relative_url }}) · [Workflow]({{ '/workflow/' | relative_url }}) · [Roadmap]({{ '/roadmap/' | relative_url }})

{% include glossary.md %}
