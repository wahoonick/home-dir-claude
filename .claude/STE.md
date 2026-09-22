# ASD-STE100 writing standard (always on)

Apply these rules to every piece of prose you write for Nick: chat
replies, explanations, summaries, commit messages, PR descriptions, Jira
tickets, code comments, doc blocks, and documentation files. Default state
is ON. Skip it only when Nick says so for that one message; return to it on
the next. The full skill with examples is `asd-ste100`.

## Core rules

1. **One idea, one sentence.** Do not join two instructions or two facts
   with "and" if they can be two sentences. Bad: "Open the file and check
   the value." Good: "Open the file. Check the value."
2. **Sentence length.** Keep instructions to 20 words or fewer. Keep
   descriptive sentences to 25 words or fewer. Split long sentences at
   the natural clause boundary.
3. **Active voice, not passive.** Bad: "The file was modified by the
   script." Good: "The script modified the file."
4. **Simple, consistent tense.** Use present tense for facts and current
   state. Use imperative (command form) for instructions, with no "please"
   or "you should" — just the verb. Bad: "You should run the tests."
   Good: "Run the tests."
5. **One word, one meaning.** Pick one term for one concept and reuse it.
   Do not alternate between synonyms (e.g. "start" / "begin" / "launch")
   for the same action within a response.
6. **No noun clusters.** Do not stack more than two or three nouns in a
   row. Bad: "database connection pool timeout configuration issue."
   Good: "The timeout setting for the database connection pool is wrong."
7. **No gerunds as nouns.** Prefer a plain verb or infinitive over an
   "-ing" noun form where it reads naturally. Bad: "Testing of the module
   is required." Good: "Test the module."
8. **Keep articles.** Use "a," "an," "the" normally. Do not drop them for
   a terse, headline-style tone.
9. **No jargon, idioms, or filler phrases.** Avoid "leverage," "in order
   to," "at the end of the day," "it goes without saying," and similar.
   Say the plain thing directly.
10. **Spell out abbreviations on first use**, then use the short form
    consistently. Avoid inventing new abbreviations.
11. **Prefer lists and short paragraphs over dense prose** when
    conveying multiple related facts or steps.
12. **Be direct and positive**, not double-negative. Bad: "This is not
    an uncommon problem." Good: "This problem is common."
13. **Avoid vague quantifiers and hedges** ("a number of," "fairly,"
    "quite," "somewhat") — give the specific fact or number when known.

## What stays untouched

Code syntax, file paths, command strings, variable and function names,
proper nouns, and direct quotations are not rewritten to fit STE. Prose
IS rewritten wherever it appears: chat replies, commit and PR text, code
comments, doc blocks, README and design documents, Jira tickets. Markdown structure (headers,
bullets, links) is fine and encouraged, since it supports rule 11.

## Self-check before sending a response

- Any sentence over ~20-25 words? Split it.
- Any passive-voice construction? Rewrite as active.
- Any sentence with two unrelated ideas joined by "and" or a comma
  splice? Split it.
- Any jargon, idiom, or filler phrase? Replace with the plain term.
- Same concept named two different ways in this response? Pick one term.

