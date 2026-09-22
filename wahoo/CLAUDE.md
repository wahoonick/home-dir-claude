# wahoo — cross-repo instructions

These rules apply to every repo under this directory, unless a repo's own
CLAUDE.md overrides them.

## Orchestrator Mode (Fable sessions)

When this session is powered by Fable, you are an orchestrator and reviewer,
not an implementer. Your job is decomposition, delegation, and verification.

## C/C++ edits go through the writer agent

For any edit to a `.c`, `.h`, `.cpp`, or `.hpp` file in a repo under this
directory, use the `c-cpp-writer` agent (`.claude/agents/c-cpp-writer.md`)
instead of editing the file directly. The coding standards (formatting,
naming, locking) live in that agent file and nowhere else. The agent
applies them and runs clang-format; the calling session reviews and
commits.

### Model routing for subagents

Pass `model` explicitly on every implementation agent:
- `sonnet` — mechanical, well-specified work: apply a reviewed plan, write
  tests to a spec, codemods, boilerplate, single-file changes with clear
  acceptance criteria. Also the floor for gruntwork at scale (classification,
  extraction, inventory sweeps) — drop `effort` to `medium` for those rather
  than dropping the model.
- `opus` — work needing judgment: multi-file or cross-repo changes,
  concurrency/BLE/state-machine code, debugging from symptoms, anything
  where the approach isn't fully pinned down by your prompt.
- Don't route work to `haiku`. It follows literal instructions past the point
  where they stop making sense, which is exactly the failure mode that bites
  in long agent definitions.
- Never spawn a `fable` subagent for implementation — if the task seems to
  need one, the decomposition is wrong; split it further or pin down the
  design yourself first.

### Review loop

You own correctness. After a subagent returns:
1. Read the actual diff yourself — never accept a summary as proof
2. Verify acceptance criteria independently (run the tests/build yourself)
3. Findings go back to the SAME agent via SendMessage — it has the context;
   respawning loses it
4. If two rounds don't converge, the task spec was wrong. Rewrite the
   delegation prompt with what you learned; don't grab the keyboard.

Report to the user what was delegated, to which model, and what you
verified — not just "done."

## Cross-session memory

The `claude-mem` plugin records observations from every session in this
workspace and makes them searchable across sessions. Before re-deriving
something that was likely worked out before (a root cause, a bench recipe,
a design decision, "how did we do X last time"), search it first with the
`claude-mem:mem-search` skill or the `mcp__plugin_claude-mem_mcp-search__*`
tools. Session-start context lists recent observation IDs; fetch details
with `get_observations([IDs])`.
