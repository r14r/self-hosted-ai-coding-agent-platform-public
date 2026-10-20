---
layout: default
title: Architektur
permalink: /architecture/
---
# Architektur

![Schichten und Komponenten]({{ '/assets/architecture.svg' | relative_url }})

## Control Plane

FastAPI, Nuxt UI (geplant), PostgreSQL, Redis und eine deterministische State Machine koordinieren Runs, Policies und Freigaben.

## Execution Plane

OpenCode oder austauschbare Agent-Adapter; lokale Ollama-Inferenz über kompatible APIs; pro Job eigene isolierte Sandbox. **Noch zu implementieren.**

## Validation Plane

Unabhängige Build-/Test-/SAST-/SCA-/Secret-Prüfungen und Delta-Vergleiche statt bloßer LLM-Selbsteinschätzung. **Noch zu implementieren.**

## Git-Integration

GitHub und Gitea über Provider Adapter. PR-Publisher verwaltet kurzlebige Tokens und darf nur eigene Wartungsbranches schreiben. Keine automatischen Merges geschützter Branches.

Ausführliche Details: [docs/README.md](https://github.com/r14r/self-hosted-ai-coding-agent-platform/blob/main/docs/README.md).
