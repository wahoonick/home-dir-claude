---
name: fw-workflow
description: Firmware team workflow for shipping changes — Jira ticket creation, branch naming, commit scoping, PR conventions, merging, and ticket closure. Use this whenever work in a firmware repo is about to become "real" — creating a branch for a fix or feature, committing, opening a PR, pushing to or merging into main, creating or closing a Jira ticket — even if the user only says "push this", "make a PR", "commit that", or "ship it". Also use it when starting ticketed work, to get branch naming and ticket status right from the beginning.
---

# Firmware Team Workflow

How changes move from idea to `main` on this team. The core principle:
**exploration is free, but nothing real lands without a ticket.** You can
prototype, test, and iterate on a branch with no ceremony — the moment the
work is destined for a PR or `main`, it must be aligned to a Jira ticket.

## The lifecycle

```
idea → Jira ticket → branch off fresh main → scoped commits → PR → CI/validation → merge → validate → close ticket
```

Exploratory work may skip the ticket and enter this pipeline later — but it
must join it (ticket created, branch renamed if needed) before a PR is opened
or anything is pushed to main.

## Jira tickets

**When**: Any work that will land in `main` gets a ticket — bugfixes, features,
CI changes, tooling the team will use. If the user asks to push a PR or merge
and no ticket exists, create one (confirm the summary with the user) rather
than skipping it. Pure experiments that never leave a scratch branch don't
need one.

**Which project**: Infer the Jira project key from the repo — existing branch
names, merged PR titles, or `git log` will contain patterns like `PULSE-75`.
If the repo has no history of ticket references, ask the user which project
key to use rather than guessing.

**Content**: Summary states the change, not the activity ("CI: build all
release presets by default", not "Update workflow file"). Description covers
the problem, the approach, and how it will be validated. Link the PR to the
ticket once it exists.

**Assignee**: Default to Nick Caine unless the user names someone else for
the ticket. Look up the account ID in
`/Users/nickcaine/wahoo/claude/Manager Stuff/memory/people/` first; fall back
to `lookupJiraAccountId` only if the person isn't in there yet.

**Status transitions** (use the Jira MCP; fetch available transitions rather
than assuming IDs — they differ per project):
- Work starts on a branch → ticket to **In Progress**
- PR opened → ticket to **In Review**
- **Done** only after the change is merged *and* validated (CI green is not
  validation — validation means the change was confirmed doing its job:
  firmware ran on hardware, the pipeline produced correct artifacts, etc.).
  Confirm with the user before closing; they may have validation criteria
  you can't see.

## Branches

- Always branch off freshly pulled `main` (`git checkout main && git pull`
  first). Stash or flag uncommitted changes — never carry unrelated edits
  into a new branch silently.
- Naming with a ticket: `<TICKET-ID>-<kebab-summary>`, e.g.
  `PULSE-75-ci-build-all-release-presets`.
- Exploratory work without a ticket yet: plain kebab-case describing the work,
  e.g. `led-display-mgr-unit-tests`. When the work gets its ticket, the branch
  may keep its name if already pushed/shared; new branches get the ticket
  prefix.
- Delete branches (local and remote) after merge — they're fully contained in
  main, so nothing is lost, and stale branches accumulate fast.

## Commits

Scope is everything. A commit is a reviewable, revertable unit tied to one
concern:

- Stage files by **exact path** — never `git add -A` or `git add .`. Firmware
  working trees often carry unrelated in-flight edits (config experiments,
  debug toggles), and bundling one into a ticket-scoped commit ships an
  unreviewed behavior change under the wrong history.
- If unrelated modified/untracked files are sitting in the tree, **flag them
  to the user by name** and leave them alone — don't commit, stash, or discard
  them on your own.
- Separate concerns get separate commits even on the same branch: a bugfix
  found while writing tests is its own commit (or its own branch/PR if it
  should ship independently).
- Message format: `<area>: <what changed>` subject (`fix:`, `tests:`, `ci:`,
  `tools:`, `drivers:`...), then a body explaining **why** — the problem, the
  cause, and anything a future reader can't recover from the diff. Reference
  the ticket ID in the subject or body when one exists.

## Pull requests

- Create with `gh pr create`. Use **draft** PRs for examples, RFCs, or
  anything not ready for review — draft means "look at this", ready means
  "merge this".
- Title mirrors the ticket summary. Body structure: what this is, the pieces
  (per-commit or per-area breakdown), how to try it, and a **Verification**
  section stating what was actually tested and what's known-broken or
  out of scope. Honest verification notes ("9/9 pass locally; pre-existing
  failure in X is unrelated") build reviewer trust and save a review round.
- Push the branch and link the PR to the Jira ticket; move the ticket to
  In Review.

## Merging

- **Never merge unprompted.** Opening a PR, monitoring CI, and reporting
  status is your job; the decision to merge is the user's.
- The team prefers PRs but allows direct-to-main for small, high-confidence
  changes (one-liner matching existing idiom, backed by passing tests) —
  **only when the user explicitly asks for it**, and it still needs a ticket.
- After a merge: delete the branch (local + remote), pull main, and return to
  whatever branch was being worked on.
- After merge + validation: close the ticket (confirm first — see Status
  transitions above).

## When something's already wrong

- Working tree on a stale branch when new work starts: `git checkout main &&
  git pull` first, flag any uncommitted leftovers.
- Asked to push/merge work that has no ticket: pause, propose a ticket
  summary, create it on confirmation, then proceed.
- A branch mixes concerns that should ship separately: offer to split it
  (cherry-pick or reset --soft and re-commit) before the PR goes up, like
  separating a bugfix from an example branch.
