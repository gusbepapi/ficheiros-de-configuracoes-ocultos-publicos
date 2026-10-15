# Output template

A worked skeleton of the expected output structure, to be consulted only when no exemplar lesson summary is present in `assets/markdown/`. The structure below is illustrative, not prescriptive: real lessons require more or fewer sections, depending on the content of the transcription and the slides.

The example uses the canonical lesson «04 – Cosmologia – Parte 01 – Lição 05 – Supernovas» as its scaffold. Replace every italicised placeholder with content drawn from the actual inputs.

## The skeleton

~~~~markdown
# Unidade 04 – Cosmologia – Parte 01

## Lição 05 – Supernovas

### Introdução

*Um ou dois parágrafos densos contextualizando o tema da lição. Articular a posição da matéria no arco da unidade, identificar os objectivos pedagógicos enunciados pelo docente na transcrição, e antecipar os conceitos centrais que serão desenvolvidos nas secções subsequentes.*

### *Primeiro conceito estrutural*

*Desenvolvimento exaustivo do conceito. Incorporar literalmente as fórmulas projectadas nos diapositivos, bem como qualquer valor numérico ou unidade que neles figure. Caso o docente cite uma fonte bibliográfica ou um sítio electrónico, recomendar explicitamente a sua consulta.*

A relação fundamental que governa a luminosidade de um corpo negro é a lei de Stefan-Boltzmann:

$$
L = 4 \pi R^{2} \sigma T^{4}
$$

em que $L$ representa a luminosidade total, $R$ o raio da estrela, $\sigma$ a constante de Stefan-Boltzmann ($\sigma \approx 5{,}670 \times 10^{-8} \; \mathrm{W \cdot m^{-2} \cdot K^{-4}}$), e $T$ a temperatura efectiva da fotosfera.

### *Segundo conceito estrutural*

*Continuação do desenvolvimento. Sempre que um diapositivo apresentar uma tabela, reproduzi-la na íntegra:*

| Tipo de supernova | Mecanismo | Curva de luz característica |
| --- | --- | --- |
| Tipo Ia | Detonação termonuclear de anã branca | Pico estreito, declínio exponencial |
| Tipo Ib/c | Colapso de núcleo de estrela despida | Pico largo, declínio variável |
| Tipo II | Colapso de núcleo de supergigante vermelha | Patamar prolongado |

*Sempre que um diapositivo apresentar uma figura, reproduzi-la em Mermaid, TikZ, PlantUML, Graphviz, ou SVG, conforme a sua natureza:*

%%%mermaid
flowchart LR
  A[Estrela massiva<br/>M > 8 M_sol] --> B[Esgotamento do hidrogénio]
  B --> C[Fusão de elementos mais pesados]
  C --> D[Núcleo de ferro]
  D --> E[Colapso gravitacional]
  E --> F[Supernova de tipo II]
%%%

### *Terceiro conceito estrutural*

*Continuação do desenvolvimento, integrando, sempre que pertinente, as observações verbais do docente que não figurem nos diapositivos. O sumário deve ser mais rico do que qualquer uma das fontes consideradas isoladamente.*

### Síntese

*Um parágrafo final que recapitula os conceitos principais e os situa no contexto mais amplo da unidade. Reiterar, se aplicável, as recomendações de consulta de fontes externas mencionadas ao longo da lição.*
~~~~

## Notes on the skeleton

- The outer `~~~~markdown ... ~~~~` fence is the delivery envelope, mandatory in every output.
- Internal code fences (Mermaid, TikZ, PlantUML, Graphviz) use `%%% ... %%%` rather than triple backticks, so that the outer envelope remains structurally intact.
- LaTeX equations are inline (`$...$`) or display (`$$...$$`) and are NOT wrapped in `%%%` fences — they are part of the Markdown stream proper.
- Heading depth: H1 for the unit, H2 for the lesson, H3 for each conceptual section. Avoid H4 unless the structure of the lecture genuinely demands it.
- The italic placeholders in the skeleton are guidance for the present skill invocation only and must not appear in the final output. Replace every italicised phrase with substantive content drawn from the inputs.
- Section headings beneath H2 use sentence case (`### O ciclo de vida estelar`, not `### O Ciclo De Vida Estelar`) and never end with a trailing colon.
