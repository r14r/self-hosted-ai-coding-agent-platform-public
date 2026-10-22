---
layout: single
title: Projektüberblick
permalink: /
---

## 1. Zielsetzung und Rahmenbedingungen

Die Plattform automatisiert wiederkehrende Wartungsarbeiten an Git-Repositories mit einem lokal betriebenen Coding Agent. Sie erkennt Wartungsbedarf, erzeugt einen Wartungsbranch, lässt Änderungen in einer isolierten Umgebung ausführen, ruft Build-/Test-/Security-Tools auf, bewertet deren Resultate unabhängig und erstellt einen Pull Request für die menschliche Freigabe. Gesucht und benötigt wird nicht nur KI-Expertise, sondern fundierte Softwareentwicklung: Änderungen, Architekturfolgen, Dependencies und Tests müssen fachkundig validiert werden.

**Projektumfang:** 10–12 Wochen mit etwa drei Arbeitstagen pro Woche (30–36 Arbeitstage), remote. **MVP:** Ein Git-Repository wird gelesen, eine definierte Wartungsaufgabe isoliert bearbeitet, unabhängig validiert und mit Prüfbericht als PR zur menschlichen Prüfung angeboten. Der Agent darf geschützte Branches nicht direkt verändern oder mergen.

### Leitprinzipien

1. **Local first / Self-hosted:** Docker Compose; Ollama als lokaler LLM-Dienst; austauschbare OpenAI-kompatible APIs, optional vLLM.
2. **Trennung der Verantwortung:** Ein Agent erzeugt Code; ein unabhängiger Validator prüft; Policies erzwingen Grenzen; ein Mensch genehmigt.
3. **Reproduzierbarkeit:** Startcommit, Baseline, Toolversionen, Tests, Artifacts, Logs und Exit-Codes werden pro Run nachvollziehbar erfasst.
4. **Least Privilege:** Keine Secrets, Docker-Sockets oder Git-Write-Tokens in einer Agent-Sandbox; keine automatischen Merges.
5. **Erweiterbarkeit:** Austauschbare Agent-, Git-, LLM-, Sandbox- und Validator-Adapter.
6. **Ehrlicher Implementierungsstatus:** Zielkomponenten und Mock-/Beispieldaten werden ausdrücklich als solche gekennzeichnet.

## 2. Gesamtarchitektur

![Schichtenarchitektur]({{ '/assets/architecture.svg' | relative_url }})

Die **Control Plane** besteht aus Nuxt/Vue Dashboard, FastAPI, deterministischer Workflowsteuerung, Policies, Jobverwaltung und Approval-Prozess; persistiert in PostgreSQL und nutzt Redis für Queue/Events. Die **Execution Plane** umfasst OpenCode (optional Aider/Codex), ein separates Ollama-Modellgateway und einen isolierten, kurzlebigen Workspace je Job. Die **Validation Plane** führt Build, Tests, Linter, SAST/SCA, Secret-/Container-Scans und Diff-/Scope-Prüfungen **unabhängig vom Agenten** aus. Der vertrauenswürdige **PR-Publisher** erzeugt anschließend einen PR mit Nachweisen.

Die Pfeile im Diagramm sind **logische Abhängigkeiten**, nicht alle direkten Netzwerkverbindungen. Für feindlichen Repository-Code sind dedizierte Linux-VMs beziehungsweise separate isolierte Executors nötig; Docker Compose allein ist keine ausreichende Sandbox.

[**Zur vollständigen Projektdokumentation**]({{ '/documentation/' | relative_url }})

{% include glossary.md %}
