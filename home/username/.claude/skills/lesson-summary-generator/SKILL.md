---
name: lesson-summary-generator
description: Generate exhaustively detailed astronomy, astrophysics, cosmology, and physics lesson summaries in formal pre-AO-1990 European Portuguese by combining a transcription file (the spoken content of a lecture) with one or more numbered slide images (the visual content). Trigger this skill whenever the user supplies a lecture or lesson transcription together with one or more slide screenshots and asks for a summary, sumário, resumo, lição, aula, or compiled lesson notes — even if they do not explicitly name the skill. Also trigger when the user mentions a Brazilian Space Agency course, an astronomy course, or a unit/lesson pair like «Unidade 04 – Lição 05» with accompanying media. The skill produces a single triple-percent-delimited Markdown block in pre-AO-1990 European Portuguese with French quotation marks, LaTeX equations, and inline diagrams in Mermaid, TikZ, PlantUML, or Graphviz.
---

# Lesson summary generator

This skill produces an exhaustively detailed lesson summary by fusing two complementary inputs: the verbatim spoken content of a lecture (a transcription file) and the visual content of the lecture slides (one or more numbered screenshot images). The output is a single self-contained block of Markdown in formal pre-AO-1990 European Portuguese, delimited by triple-percent (`%%%`) fences in place of the customary triple-backtick fences, so that the user may later replace the percentages with backticks without losing structural fidelity.

The skill is intended primarily for an advanced astronomy course affiliated with a Brazilian Space Agency institution, but applies equally to any astrophysics, cosmology, or physics lecture material delivered in the same Portuguese-language pedagogical register.

## Inputs

The user supplies, in any order:

- **Exactly one transcription file.** Accepted extensions: `.txt` (typically from Groq's OpenAI Whisper or similar ASR), `.vtt` (typically from `yt-dlp` against YouTube auto-captions), `.srt`, or no recognised extension. When both `.txt` and `.vtt` are supplied for the same lesson, prefer the `.txt` (it is the cleaner ASR output); use the `.vtt` only to disambiguate inaudible passages.
- **One or more slide images**, typically a single composite PNG containing several numbered slide thumbnails arranged in a grid, but possibly individual images. Slides are labelled `slide 01`, `slide 02`, and so on, in reading order.
- **Optionally**, one or more existing Markdown lesson summaries placed in `assets/markdown/` (relative to the skill directory). When present, these are the stylistic ground truth — they outrank any structural guidance in this SKILL.md. Read them first.

## Filename parsing

The transcription filename encodes the lesson metadata. Multiple shapes are recognised, all using en-dashes (« – ») as field separators after underscore-substitution by upload pipelines is reversed (uploads typically replace « – » with `___`; restore them before parsing). Strip any subtitle extension (`.txt`, `.vtt`, `.srt`) and any trailing `_pt`, `_transcricao`, `_transcription`, or language code before parsing.

Three canonical shapes are accepted; others should be flagged for explicit confirmation:

1. `<course-name> <course-number> – Unidade <unit-number> – Lição <lesson-number> – <lesson-title>`
   Example: `Astronomia Avançada 02 – Unidade 03 – Lição 05 – Astronomia em 1920`
2. `<unit-number> – <unit-title> – Parte <part-number> – Lição <lesson-number> – <lesson-title>`
   Example: `04 – Cosmologia – Parte 01 – Lição 05 – Supernovas`
3. `<unit-number> – <unit-title> – Lição <lesson-number> – <lesson-title>`

If parsing produces an ambiguous or empty unit title (as in shape 1, where the filename gives a unit number but no unit title), **do not invent one** — halt and ask the user for the unit title explicitly. The exemplars demonstrate that the H1 always names the unit by its thematic title, never by `Parte XX` or by a bare number.

## Output heading scaffold

ALWAYS open the output with exactly this two-line scaffold, populated from the parsed metadata and any user-supplied clarifications:

```
# Unidade <unit-number> – <unit-title>[ – Parte <part-number>]

## Lição <lesson-number> – <lesson-title>[ – Parte <part-number>]
```

The bracketed `Parte XX` segments are conditional. The governing rule is categorical and deterministic: **if the filename carries a `Parte XX` token at unit level, retain it verbatim in the H1; if the filename carries a `Parte XX` token at lesson level, retain it verbatim in the H2; if the filename does not carry such a token, omit it from the corresponding heading.** Do not strip, do not synthesise, do not consult the user. The filename is the sole authority on whether the part is present in the heading.

This rule reflects the user's curatorial convention: parts appear in filenames precisely when they are needed to disambiguate between two units (or two lessons) that would otherwise share a title. The filename is therefore the trustworthy signal, and the heading mirrors it faithfully.

**Examples of correct heading construction:**

| Filename (after un-escaping) | H1 | H2 |
| --- | --- | --- |
| `04 – Cosmologia – Parte 01 – Lição 05 – Supernovas` | `# Unidade 04 – Cosmologia – Parte 01` | `## Lição 05 – Supernovas` |
| `04 – Cosmologia – Lição 05 – Supernovas` | `# Unidade 04 – Cosmologia` | `## Lição 05 – Supernovas` |
| `Astronomia Avançada 02 – Unidade 03 – Lição 02 – Distâncias em Astronomia` | `# Unidade 03 – <ask user for unit title>` | `## Lição 02 – Distâncias em Astronomia` |

## Body structure

Follow the rhetorical pattern of the exemplars in `assets/markdown/`:

1. **Opening prose.** One or two dense paragraphs of contextual prose immediately after the H2 heading, with no subheading of their own. These paragraphs situate the lesson within the arc of the unit, evoke the preceding lesson if known, and announce what the present lesson will develop.
2. **Numbered H3 subsections.** Each major conceptual section uses an H3 heading of the form `### N. <Sentence-case title>`, where N is a sequential integer (1, 2, 3, ...). The numbering is mandatory and continuous. Subsection titles are in sentence case (e.g., `### 1. O princípio geométrico da observação`), without trailing colons and without internal capitalisation of common nouns.
3. **Subsection body.** Each subsection contains prose that integrates the spoken content from the transcription with the visual content from the slides. Reproduce every formula, every table, and every figure from the slides at the point where the lecturer addresses them. Paraphrase the transcription rather than quoting it verbatim.
4. **Closing synthesis** (optional but encouraged for longer lessons). A final paragraph or short numbered subsection that recapitulates the conceptual arc.

The exemplars do not use a `### Introdução` heading; they let the opening paragraphs stand without a subheading. Follow this convention.

## Linguistic register

Write the entire summary in formal European Portuguese using the pre-AO-1990 orthographic conventions. Concrete consequences:

- Preserve consonants suppressed by the 1990 Acordo Ortográfico: `acção`, `acto`, `adopção`, `arquitectónico`, `característica`, `directo`, `eléctrico`, `espectro`, `excepção`, `facto`, `objecto`, `óptimo`, `respectivamente`, `selecção`, `sumptuoso`, `tecto`. When in doubt consult `references/pre-ao-1990-orthography.md`.
- Use formal vocabulary throughout. Avoid colloquialisms, Brazilian-Portuguese lexicon, and contractions where formal European Portuguese would prefer the expanded form. Forms such as «destrinçou», «socorrer-se», «socorrendo-se», «debruçar-se», «recorrer a», «vislumbrar», «descortinar», and «logram trespassar» are characteristic of the exemplars and should be reached for in preference to plainer alternatives.
- Use French quotation marks « and » exclusively for quoted matter. Never use the straight typewriter quotes `"` `'`, and never use the curly English quotes `“` `”` `‘` `’`.
- Use the right single quotation mark `’` only for genuine apostrophes (proper nouns, foreign loanwords).
- Use sentence case for all subsection headings. Capitalise only the first word and proper nouns. Do not place trailing colons on subheadings.
- Use the second-person plural «nós» voice for didactic exposition («observamos», «notamos», «devemos compreender»), consistent with the exemplars.
- Treat the unnamed lecturer of the transcription as «o docente», «o professor», or «o autor». Refer to historical figures by their full names on first mention, then by surname.

## Delimiter convention

Submit the entire summary as a single block of Markdown delimited by four consecutive tildes carrying the language tag `markdown`:

```
~~~~markdown
# Unidade 04 – Cosmologia

## Lição 05 – Supernovas

...full content...
~~~~
```

Within that outer block, every nested code fence — whether for Mermaid, TikZ, PlantUML, Graphviz, SVG, or any other language — MUST be opened and closed with three consecutive percent signs (`%%%`) in place of three backticks. The user will perform a global replacement of `%%%` with triple backticks after generation; if any nested block uses real backticks, the outer Markdown block will fracture and the post-processing step will fail.

LaTeX equations use `$...$` for inline and `$$...$$` for displayed mathematics, directly in the Markdown stream. LaTeX is NOT wrapped in `%%%` fences — only diagram and code blocks are.

## Mathematical content

Render every equation, expression, or formula purely in LaTeX. Do not load any LaTeX packages. Inside formulae, if you need text labels, use `\mathrm{...}` rather than `\text{...}`, because `\text` requires `amsmath`, which is unavailable in the rendering pipeline.

Transcribe every numerical value, measurement, and unit exactly as it appears in the slides. Preserve SI prefixes and unit symbols verbatim. Format Portuguese decimal numbers with the comma as the decimal separator (`5{,}670 \times 10^{-8}`), not the full stop.

## Diagrams, charts, and figures

When the slides contain a figure, chart, graph, or schematic, reproduce it as a diagram in one of the following languages, choosing whichever fits the figure best. Wrap each diagram in `%%%language ... %%%` fences.

- **TikZ** — the workhorse for the exemplars. Used for geometric figures, orbital diagrams, light-wave illustrations, Doppler diagrams, Hubble diagrams, and figurative recreations of slide imagery. Prefer TikZ when the figure is bespoke and the exemplars demonstrate a similar treatment.
- **Mermaid** — for flowcharts and for `xychart-beta` charts plotting tabulated quantitative data. The exemplars use Mermaid sparingly and only for genuinely quantitative content.
- **PlantUML** — for sequence, class, activity, and component diagrams.
- **Graphviz** — for general directed and undirected graphs.
- **SVG** — for bespoke illustrations where none of the above suffices.

### Mermaid xychart-beta rules

- `x-axis` must never be empty.
- `line` and `bar` declarations must always include a data array.
- For a categorical `x-axis`, supply exactly one y-value per label.
- Write Portuguese diacritics directly as UTF-8 characters inside double-quoted titles, axis labels, and node text (`"Distância"`, `"Absorção"`, and so forth). Do NOT escape them with LaTeX accent macros; quoted Mermaid text accepts accented letters natively.

### Standalone TikZ rules

- Substitute `\text{...}` with `\mathrm{...}` everywhere, because `amsmath` cannot be loaded in the rendering pipeline.
- Substitute `bg=white` with `fill=white`. The `bg` key is not a valid TikZ option.
- `\usetikzlibrary{...}` is permitted; `\usepackage{...}` is not.
- The exemplars demonstrate sophisticated TikZ — ball shading, star shapes, dashed gridlines, fill gradients. Match this level of ambition; do not produce austere line-only sketches when the slide depicts a richly coloured figure.
- Write Portuguese diacritics directly as UTF-8 characters inside TikZ nodes and comments (`á`, `ã`, `ç`, `ô`, and so forth). Do NOT escape them with LaTeX accent macros such as `\'a`, `\~a`, `\c{c}`, or `\^o`; the rendering pipeline accepts accented letters natively, and the macros produce visual artefacts or compilation errors.
- NEVER add `yscale=-1` (nor `scale=-1`, nor any negative scale factor) to a `tikzpicture` environment or to any node. A negative vertical scale flips the entire figure — geometry and text alike — upside down. If a figure appears inverted, the cause is some other coordinate error to be corrected directly, never a negative scale applied as a remedy.
- Space objects and text generously. Leave ample clearance between adjacent shapes, between labels and the elements they annotate, and between sibling text nodes. Overlapping, abutting, or tightly crowded elements are a defect. When in doubt, enlarge the canvas and increase the inter-element distances rather than compressing the layout.
- In PGFMath expressions, ALWAYS wrap a macro-valued operand in curly braces. Write `{\r}` and `{\r*0.65}`, never bare `\r` or `\r*0.65`. Unbraced macro operands in arithmetic contexts (radii, coordinates, `\foreach` bodies) are a parsing error.

## Tables

When the slides contain a table, transcribe every row and column exactly. Use standard GitHub-flavoured Markdown table syntax with column alignment markers (`:---:` for centred). Do not invent rows, do not omit rows, and do not collapse cells. Preserve units, footnote markers, and any provenance attributions.

## Links and external references

If the transcription or the slides mention any external link (a website, a paper, a video, a database), incorporate that link into the summary at the point where it is mentioned, and explicitly recommend that the reader visit it. Phrase the recommendation in the same formal register as the surrounding text. The exemplars use parenthetical italic recommendations such as «*(Sugere-se vivamente ao estudante a consulta...)*» and «*(Recomendação de Estudo: Sugiro veementemente...)*» — match this register.

## Workflow

Execute the following steps in order, every time.

1. **Identify the inputs.** Locate the transcription file and the slide image(s) in `/mnt/user-data/uploads/` or wherever the user has placed them. If exactly one transcription is not present, halt and ask. If `.txt` and `.vtt` are both present for the same lesson, prefer the `.txt`.
2. **Parse the filename** to extract the unit number, the unit title (if present in the filename), the lesson number, and the lesson title. If the filename matches shape 1 (course-name + unit-number, no unit title), halt and ask for the unit title. If parsing fails entirely, halt and ask for full metadata.
3. **Read the transcription file in full.** VTT files contain WEBVTT headers, cue numbers, and timestamps; ignore these and consume only the textual content. ASR transcriptions often contain disfluencies, false starts, and repeated phrases — these are artefacts of the speaker's natural speech and must be smoothed out in the summary, not reproduced.
4. **View each slide image in numbered order.** When a single composite image contains multiple thumbnails, treat each thumbnail as a separate slide in its labelled order. For each slide, internalise:
   - Every textual element (titles, bullet points, captions, attributions).
   - Every mathematical formula, to be reproduced in LaTeX.
   - Every table, to be reproduced in Markdown.
   - Every figure, to be reproduced in TikZ or another diagram language.
   - Every numerical value, with its unit.
   - Every URL or bibliographic reference.
5. **Read the exemplars in `assets/markdown/`** in full. The exemplars are the structural ground truth: organisational depth, density of equations versus prose, level of TikZ sophistication, and rhetorical voice are all calibrated against them. If the exemplars and this SKILL.md disagree, the exemplars win.
6. **Synthesise the summary.** Weave the spoken content from the transcription with the visual content from the slides. The summary must be longer and more detailed than either input alone — this is the point of fusing them. Reproduce every formula, every table, and every figure from the slides. Quote at most a sentence at a time from the transcription; paraphrase the rest in the formal register.
7. **Wrap the output** in the four-tilde Markdown block with the `markdown` language tag, and ensure every nested code fence uses `%%%` rather than triple backticks.
8. **Deliver the output** as a single message containing the wrapped block, with at most a brief one-sentence preamble.

## Failure modes to avoid

- Never produce a brief or skeletal summary. Brevity defeats the purpose.
- Never substitute the triple-backtick fence for the triple-percent fence inside the outer block.
- Never include `Parte XX` in any heading when the filename does not carry that token; never strip `Parte XX` from any heading when the filename does carry it. The filename's part token is the deterministic authority.
- Never use English curly quotes or straight typewriter quotes anywhere in the Portuguese prose.
- Never silently skip a slide. If a slide is illegible, say so explicitly within the summary at the point where its content would have appeared.
- Never use the post-AO-1990 orthography. If unsure whether a word retained or lost a silent consonant, consult `references/pre-ao-1990-orthography.md`.
- Never invent content not present in either the transcription or the slides. The summary is exhaustive with respect to its inputs, not speculative.
- Never use a heading like `### Introdução` for the opening prose. Let the opening paragraphs stand without a subheading.

## References

- `references/pre-ao-1990-orthography.md` — a curated list of common words whose orthography differs between the pre-1990 and post-1990 conventions, for consultation when unsure.
- `references/output-template.md` — a worked skeleton of the expected output structure, useful only when no exemplar is present in `assets/markdown/`.
- `assets/markdown/` — the user's own exemplar lesson summaries, consulted at invocation time for organisational and stylistic ground truth. These outrank every other source.
