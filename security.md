---
layout: default
title: Security
permalink: /security/
---
# Sicherheitsmodell

![Trust Boundaries]({{ '/assets/trust-boundaries.svg' | relative_url }})

## Angriffsflächen

Repository-Code, README, Issues, Dependencies, Shell-Ausgaben und Agentenantworten sind potenziell nicht vertrauenswürdig.

## Sicherheitsprinzipien

- Keine Host-Docker-Sockets im Agent-Container.
- Dedizierter isolierter Executor-Host/VM für untrusted Code.
- Keine produktiven Secrets und keine direkten Push-Rechte für Agents.
- Netzwerkausgang kontrollieren, RAM/CPU/Prozesse/Laufzeit begrenzen.
- Unabhängige Policy Engine und manipulationsresistente Quality Gates.
- Traces und Logs mit Secret Redaction.

**Hinweis:** Diese Kontrollen sind Teil der geplanten Zielarchitektur und noch nicht vollständig implementiert.
