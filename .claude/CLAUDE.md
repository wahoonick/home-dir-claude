@RTK.md


# Communication standard
For every response to the user — explanations, summaries, chat replies,
commit/PR text — follow the `asd-ste100` skill
(`~/.claude/skills/asd-ste100/SKILL.md`): short sentences, active voice,
plain consistent vocabulary, one idea per sentence. This is the default
for every session. Do not rewrite code, file paths, or identifiers to fit
it. Skip it for a given message only if the user explicitly says not to
use it for that message; return to it on the next response.

# People lookup
For looking up someone's Slack ID, Atlassian account ID, email, role, or
reporting line, check `/Users/nickcaine/wahoo/claude/Manager Stuff/memory/people/`
first (one markdown profile per person) before searching or guessing.
