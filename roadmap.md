---
layout: default
title: Roadmap
permalink: /roadmap/
---

## 9. Self-Hosted LLMs und Hardware

Ollama ist der initiale lokale Inferenzdienst. Die Adapterarchitektur erlaubt später andere OpenAI-kompatible Endpunkte und vLLM. Tool-Calling, Modellkontext, Coding-Fähigkeit, Laufzeit und Fehlerquote sind anhand echter Aufgaben zu evaluieren.

| Umgebung | Geeigneter Einsatz |
|---|---|
| Intel Mac, 32 GB RAM, CPU | Compose/API-Entwicklung, kleine LLM-Aufgaben und Pipeline-Tests; langsame Agenten |
| 64 GB RAM, CPU | Größere Modelle, aber weiterhin begrenzter Durchsatz |
| Linux-Server mit 24 GB GPU-VRAM | Kleinere/quantisierte Coding-Modelle und produktivere Experimente |
| 48 GB+ GPU-VRAM | Größere lokale Modelle und längere Agent-Workflows |

Die Werte sind Orientierungsgrößen, keine zugesicherte Leistungsfähigkeit. Lange Coding-Aufgaben sind auf CPU-Hardware häufig unpraktisch.

## 10. Reproduzierbare Evaluation

| Fixture | Definierter Defekt | Erfolgskriterium |
|---|---|---|
| FastAPI/Python | Verwundbare Dependency, fehlender Regressionstest | Dependency sicher aktualisiert, Tests bestehen |
| Go CLI | Veraltete API und defekte Tests | Semantik korrekt, keine Regression |
| Nuxt/Node | Alte Pakete und Buildfehler | Reproduzierbarer Build, keine neuen Findings |

Metriken: Task Success Rate, First-Pass Success, Rework-Rate, Time-to-PR, fehlende Security-Entdeckungen (False Negatives), Tokenverbrauch, Ausführungsdauer, Anzahl Tool Calls und nachträgliche menschliche Korrekturen.

![Beispielhafte Agentenevaluation — illustrative, **nicht gemessene** Werte]({{ '/assets/evaluation.svg' | relative_url }})

Die Balken zeigen ausschließlich Demo-Werte: Agent A 75 %, Agent B 60 %, Agent C 88 %. Sie sind **keine echten Agentenbenchmarks**.

## 11. Umsetzung in 10–12 Wochen

Bei drei Arbeitstagen pro Woche stehen ungefähr **30–36 Projekttage** zur Verfügung. Priorität hat eine reproduzierbare End-to-End-MVP-Demo.

| Phase | Zeit | Umsetzung | Nachweis / Abnahme |
|---|---|---|---|
| 1 · Foundation | Wochen 1–2 | Docker Compose, FastAPI, Nuxt-Grundgerüst, PostgreSQL, Redis, Ollama | Healthchecks und startbarer Stack |
| 2 · Git Integration | Wochen 3–4 | GitHub/Gitea Adapter, Discovery, Task Backlog, Baseline und Branch | Demo-Repo mit klassifiziertem Wartungsbedarf |
| 3 · Coding Agent | Wochen 5–6 | OpenCode, LLM-Adapter, Policies, isolierter Executor | Kontrollierter Patch in Sandbox mit Tool-Traces |
| 4 · Validation | Wochen 7–8 | Build, Tests, Ruff/ESLint/Go, SAST/SCA, Gitleaks, Quality Gates | Baseline-/Candidate-Report und blockierte Risiken |
| 5 · PR & Review | Wochen 9–10 | Diff-Ansicht, Publisher, PR-Erstellung, Human Approval | PR mit nachvollziehbaren Nachweisen |
| 6 · Hardening | Wochen 11–12 | Threat Modeling, Evaluation Harness, Observability, Dokumentation | Reproduzierbare sichere End-to-End-Demo |

**Definition of Done:** Der Agent darf Änderungen vorschlagen und in seiner Sandbox ausführen, aber weder Sicherheitsregeln verändern noch unabhängig Prüfungen freigeben oder geschützte Branches direkt mergen.

## 12. Anforderungsabdeckung

| Anforderung | Zielkomponente |
|---|---|
| Agentische Softwarewartung | Orchestrator + Coding Agent |
| Self-hosted On-Premise LLM | Ollama / LiteLLM / optional vLLM |
| Mehrere Coding Agents | Agent Adapter |
| Git/Branch/PR-Automation | Git Provider Adapter + Publisher |
| Dev-/Security-Tools aufrufen | Validator Plugins |
| Code, Builds, Tests bewerten | Independent Validation Plane |
| Fehlentscheidungen/Endlosschleifen | Limits, Policy Engine, Evaluation |
| Human-in-the-loop | Review- und Approval Workflow |
| Isolierte Ausführung | SandboxProvider in separater VM |
| Prompt Injection | Trust Boundaries und erzwungene Tool Policies |
| Supply Chain | SAST, SCA, Secrets, Container Scan |
| Geschützte Branches | Server-seitige Git-Berechtigungen |
| Logging und Monitoring | OpenTelemetry, Loki, Prometheus, Grafana |
| Reproduzierbare Szenarien | Fixture-Repositories und Evaluation Harness |

Es sind zwei Betriebsmodi geplant: **lokaler Demo-Modus** mit Gitea, Ollama und Fixtures sowie **Integrationsmodus** für GitHub/GitLab und Unternehmens-LLMs.

[**Zur vollständigen Projektdokumentation**]({{ '/documentation/' | relative_url }})

{% include glossary.md %}
