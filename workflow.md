---
layout: default
title: Workflow
permalink: /workflow/
---

## 4. Workflow — vom Repository bis zum Pull Request

![Neunstufige Wartungspipeline]({{ '/assets/workflow.svg' | relative_url }})

| Schritt | Aufgabe | Erwartete Artefakte |
|---|---|---|
| 1 · Repository Discovery | Sprachen/Frameworks; Go, pip/uv, npm/pnpm, Maven/Gradle; Tests, Dockerfiles, Actions, Versionen, Branch-Schutz | `RepositoryProfile` |
| 2 · Maintenance Detection | Veraltete Pakete, CVEs, deprecated APIs, CI-Probleme, Refactoring, fehlende Tests und veraltete Dokumentation | `MaintenanceTask` |
| 3 · Planning | Scope, Risiko, Priorität, Akzeptanzkriterien, Tool- und Laufzeitbudget, Policy-Prüfung | `ExecutionPlan` |
| 4 · Branch & Sandbox | Dedizierter Branch, temporärer Worktree, sichere Sandbox, **Baseline-Tests** auf Ausgangscommit | `BaselineReport` |
| 5 · Coding Agent | Agent ändert erlaubte Dateien, ruft freigegebene Tools auf, protokolliert alle Aktionen | Patch, Tool-Traces |
| 6 · Independent Validation | Unabhängiger Build, Test, Lint, SAST, SCA, Secret-Scan, Delta-Vergleich | `ValidationReport` |
| 7 · Review Gate | Diffs, Nebenwirkungen, Änderungen an Tests/CI, Reproduzierbarkeit, Rework-Limit | `ReviewDecision` |
| 8 · Pull Request | Vertrauenswürdiger Publisher pusht nur erlaubten Branch, erstellt PR mit Tests, Findings und Nachweisen | PR-URL |
| 9 · Human Approval | Entwickler prüft Änderung, Build/Tests, Architektur, Security und Wartbarkeit | Genehmigung/Ablehnung |

**Rework:** Bei reparierbaren Fehlern darf der Agent höchstens eine festgelegte Anzahl Iterationen durchführen; nach jeder Änderung läuft die unabhängige Validierung erneut. Sicherheitskritische Befunde blockieren. Ein LLM-Reviewer kann erklären, darf aber keine fehlgeschlagenen Pflichtprüfungen überstimmen.

### 4.1 Wartungsbedarf

| Kategorie | Erkennung / Beispiel |
|---|---|
| Dependencies | Python/npm-Pakete aktualisieren, Lockfiles konsistent halten |
| Security | Bekannte CVEs und kritische Advisory-Updates |
| Code Quality | Deprecated APIs entfernen |
| CI/CD | Fehlerhafte Actions und Build-Skripte korrigieren |
| Docker | Verwundbare Base Images ersetzen |
| Tests | Regressionstests ergänzen, ohne bestehende zu schwächen |
| Refactoring | Veraltete Codepfade modernisieren |
| Dokumentation | Veraltete API-Beispiele berichtigen |

### 4.2 Strukturierter Taskvertrag (Beispiel, noch kein ausgeführter Task)

```yaml
task:
  id: MAINT-0042
  type: dependency_update
  repository: demo-python-api
  objective: Update vulnerable dependencies while preserving behavior
  constraints:
    protected_branches: [main, "release/*"]
    max_changed_files: 20
    max_iterations: 5
    timeout_seconds: 900
  permissions:
    filesystem: workspace_only
    shell: restricted
    network: restricted
    git_push: false
    pull_request: false
  acceptance:
    baseline_required: true
    tests_must_pass: true
    security_regressions: 0
    review_required: true
```

**Sicherheitsgrenze:** `git_push: false` in einem Prompt ist *keine* durchgesetzte Einschränkung. Sie muss vom Executor, Git-Server und Credential-Management erzwungen werden.

## 5. Unabhängige Validation und Quality Gates

| Gate | Prüfkriterium | Fehlerbehandlung |
|---|---|---|
| Scope | Nur erlaubte Dateien und Änderungen | Blockieren |
| Format | Formatierung korrekt | Rework |
| Lint | Keine neuen schwerwiegenden Fehler | Rework |
| Build | Build erfolgreich | Rework |
| Unit Tests | Keine neuen fehlschlagenden Tests | Rework |
| Integration | Keine funktionalen Regressionen | Blockieren |
| SAST | Keine neuen kritischen Findings | Blockieren |
| SCA | Keine neuen kritischen CVEs | Blockieren |
| Secrets | Keine neu eingeführten Secrets | Blockieren |
| Container Scan | Image-Richtlinien eingehalten | Blockieren bei kritischen Findings |
| Test/CI Integrity | Keine ausgeschalteten/gelöschten Prüfungen | Blockieren oder explizite Freigabe |
| Diff Review | Keine unerwarteten Nebenwirkungen | Menschliche Prüfung |

Jeder `ValidationReport` enthält Commit-SHA, Ausgangscommit, Tool-Versionen, Kommandos, Exit-Codes, vollständige oder referenzierte Logs, Findings, Testresultate und Delta gegenüber Baseline. Erlaubte Legacy-Fehler werden von neuen Fehlern getrennt. Der Agent darf Prüfkonfigurationen und Baseline-Artefakte nicht überschreiben.

[**Zur vollständigen Projektdokumentation**]({{ '/documentation/' | relative_url }})

{% include glossary.md %}
