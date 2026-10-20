---
layout: default
title: Architektur
permalink: /architecture/
---

## 2. Gesamtarchitektur

![Schichtenarchitektur]({{ '/assets/architecture.svg' | relative_url }})

Die **Control Plane** besteht aus Nuxt/Vue Dashboard, FastAPI, deterministischer Workflowsteuerung, Policies, Jobverwaltung und Approval-Prozess; persistiert in PostgreSQL und nutzt Redis für Queue/Events. Die **Execution Plane** umfasst OpenCode (optional Aider/Codex), ein separates Ollama-Modellgateway und einen isolierten, kurzlebigen Workspace je Job. Die **Validation Plane** führt Build, Tests, Linter, SAST/SCA, Secret-/Container-Scans und Diff-/Scope-Prüfungen **unabhängig vom Agenten** aus. Der vertrauenswürdige **PR-Publisher** erzeugt anschließend einen PR mit Nachweisen.

Die Pfeile im Diagramm sind **logische Abhängigkeiten**, nicht alle direkten Netzwerkverbindungen. Für feindlichen Repository-Code sind dedizierte Linux-VMs beziehungsweise separate isolierte Executors nötig; Docker Compose allein ist keine ausreichende Sandbox.

## 3. Vollständiger Technologiestack

| Komponente | Technologie | Aufgabe | Status in v0.1.3 |
|---|---|---|---|
| Frontend | Nuxt 4 / Nuxt UI | Dashboard, Jobs, Diffs, Freigaben, Logs | Geplant; statische HTML-Startseite |
| Backend | Python / FastAPI | REST API, OpenAPI, Orchestrierung | Minimale Health-API vorhanden |
| Workflow Engine | Python State Machine | Deterministische Agent-Workflows, Retry-Grenzen | Geplant |
| Job Queue | Redis + arq | Asynchrone Jobs und Events | Redis-Container vorhanden; arq geplant |
| Datenbank | PostgreSQL | Projekte, Runs, Findings, Policies, Audit | Container vorhanden; Datenmodell geplant |
| Coding Agent | OpenCode (Aider/Codex optional) | Repositoryänderungen und Tool Calls | Geplant |
| LLM Runtime | Ollama, optional vLLM | Self-hosted Inferenz | Optionaler Ollama-Container |
| LLM Gateway | LiteLLM Proxy | Einheitliches OpenAI-kompatibles Routing | Geplant |
| Git Server | Gitea; GitHub/GitLab Adapter | Repositories, Branches und PRs | Optionaler Gitea-Container |
| Build/CI | Gitea Actions, GitHub Actions | Unabhängige CI-Prüfungen | Grundlegende GitHub CI vorhanden |
| SAST | Semgrep | Statische Schwachstellenanalyse | Geplant |
| Dependency Scanning | Trivy, pip-audit, OSV-Scanner | CVEs in Abhängigkeiten | Geplant |
| Secret Scanning | Gitleaks | Geheimnisse im Diff erkennen | Geplant |
| Code Quality | Ruff, golangci-lint, ESLint | Sprachspezifisches Linting | Geplant |
| Monitoring | Prometheus, Grafana, Loki, OpenTelemetry | Metriken, Logs und Tracing | Geplant |
| Container Runtime | Docker Compose + SandboxProvider | Dienste, Jobisolation und Ressourcenbegrenzung | Compose vorhanden; Sandbox geplant |

OpenCode kann beispielsweise nichtinteraktiv per `opencode run` genutzt werden. Ollama stellt teilweise OpenAI-kompatible API-Funktionen bereit; Tool-Calling-Kompatibilität, Kontextfenster und Modellqualität müssen in Tests nachgewiesen werden.

### Compose-Services und Startprofile

| Compose-Service | Aufgabe | Profil | Umsetzung |
|---|---|---|---|
| `frontend` | Nuxt UI | core | Aktuell nginx mit statischem HTML |
| `backend` | FastAPI | core | Grundgerüst |
| `orchestrator` | Workflow Engine | core | Geplant |
| `worker` | Asynchroner Jobdispatch | core | Geplant |
| `postgres` | Persistenz | core | Vorhanden |
| `redis` | Queue/Event-Broker | core | Vorhanden |
| `ollama` | Modellinferenz | ai | Vorhanden, optional |
| `litellm` | LLM-Gateway | ai | Geplant |
| `gitea` | Git-Server | git | Vorhanden, optional |
| `git-runner` | CI Runner | git | Geplant |
| `sandbox-executor` | Job-VMs/-Container erzeugen | execution | Geplant; separate VM empfohlen |
| `prometheus` | Metriken | monitoring | Geplant |
| `grafana` | Dashboard/Observability | monitoring | Geplant |
| `loki` | Logs | monitoring | Geplant |

Job-Sandboxes werden pro Run erstellt und zerstört, nicht dauerhaft als allgemeiner Compose-Service betrieben.

[**Zur vollständigen Projektdokumentation**]({{ '/documentation/' | relative_url }})

{% include glossary.md %}
