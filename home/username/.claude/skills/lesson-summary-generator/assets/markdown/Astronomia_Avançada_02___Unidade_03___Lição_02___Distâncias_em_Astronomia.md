# Unidade 03 – Medidas de distância em Astronomia

## Lição 02 – Distâncias em Astronomia

Na lição precedente, debruçámo-nos sobre a trigonometria elementar aplicada à medição da altura de árvores, utilizando a distância horizontal e o ângulo de elevação. Nesta lição, daremos o derradeiro salto conceptual, transpondo esta mesmíssima geometria terrena para as profundezas incomensuráveis do cosmos, a fim de determinarmos a distância que nos separa das estrelas.

### 1. A Metáfora do Movimento: O Autocarro e o Dedo

Para compreendermos o método astronómico, é imperativo intuirmos um fenómeno óptico e geométrico com o qual lidamos quotidianamente: a **paralaxe**.

O docente introduz este conceito socorrendo-se de uma belíssima metáfora. Imaginemos que nos encontramos a viajar num autocarro a alta velocidade. Se olharmos pela janela, constataremos que um poste de electricidade situado na berma da estrada (muito próximo de nós) "voa" rapidamente para trás, alterando o seu ângulo de visão de forma drástica. No entanto, se fixarmos o olhar num edifício longínquo, ou numa montanha no horizonte, este objecto parecerá mover-se de forma extraordinariamente lânguida e subtil, demorando muito tempo a ficar para trás. Em suma: **quanto mais próximo está um objecto, maior é a sua aparente deslocação angular quando o observador se move**.

Outro exemplo clássico que ilustra a paralaxe pode ser testado por qualquer um de nós: se esticarmos o braço, levantarmos o dedo indicador e o observarmos fechando alternadamente o olho esquerdo e o olho direito, o dedo parecerá "saltar" de um lado para o outro em relação ao fundo da sala. O dedo não se moveu; foi o nosso ponto de observação (a distância entre os nossos dois olhos) que sofreu uma ligeira alteração geométrica. 

Na sua essência, **a paralaxe é a mudança aparente na posição de um corpo por conta da mudança de posição do observador**. A Lua, por exemplo, encontra-se tão distante (à escala humana) que, quando viajamos de autocarro, ela parece "seguir-nos", pois o ângulo praticamente não sofre alteração perceptível durante o nosso trajecto. Mas para as estrelas, precisamos de uma "distância entre os olhos" muito maior.

### 2. A Inversão do Triângulo Rectângulo

Na Astronomia, a determinação de distâncias às estrelas confinadas à nossa galáxia efectua-se de forma incrivelmente análoga ao exercício da árvore, mas com uma inversão das variáveis conhecidas.

No caso da árvore, conhecíamos a distância até ao tronco ($d$) e procurávamos a altura ($h$). Na observação estelar, nós somos o observador que se desloca de uma posição para outra, percorrendo uma distância transversal conhecida à qual chamaremos $h$ (o cateto oposto). A nossa incógnita passa agora a ser a distância rectilínea $d$ (o cateto adjacente) que nos separa da estrela.

Observando o triângulo rectângulo formado por estas variáveis, onde $\alpha$ é o ângulo da paralaxe (o ângulo no vértice da estrela), a função trigonométrica da tangente dita que:

$$ \mathrm{tg}(\alpha) = \frac{h}{d} $$

Se o nosso objectivo analítico é descobrir a distância $d$, recorremos à álgebra elementar para isolar esta variável, permutando-a com a tangente. A expressão assume então a seguinte e elegantíssima forma geométrica:

$$ d = \frac{h}{\mathrm{tg}(\alpha)} $$

O esquema infra ilustra o triângulo de observação onde a estrela se encontra fixa num dos vértices e o observador capta a sua luz a partir de duas posições distintas:

```tikz
\begin{tikzpicture}[scale=1.5]
    % Vértice da Estrela
    \node[star, star points=5, star point ratio=2.25, fill=yellow, draw=orange, inner sep=3pt] (estrela) at (0,0) {};
    
    % Vértice do Observador 1 (Abaixo)
    \coordinate (Obs1) at (4,0);
    \fill[black] (Obs1) circle (0.05);
    \draw[thick] (4.3,0) ellipse (0.2 and 0.1); \fill[black] (4.3,0) circle (0.05); % Olho simbólico
    
    % Vértice do Observador 2 (Acima)
    \coordinate (Obs2) at (4,2.5);
    \fill[black] (Obs2) circle (0.05);
    \draw[thick] (4.3,2.5) ellipse (0.2 and 0.1); \fill[black] (4.3,2.5) circle (0.05); % Olho simbólico

    % Linhas do Triângulo
    \draw[ultra thick, black] (0.2,0) -- (4,0) node[midway, below=5pt, font=\bfseries, scale=1.2] {d};
    \draw[ultra thick, black] (4,0) -- (4,2.5) node[midway, right=5pt, font=\bfseries, scale=1.2] {h};
    \draw[ultra thick, black] (0.15,0.1) -- (4,2.5);
    
    % Ângulo de Paralaxe (alfa)
    \draw[thick] (1,0) arc (0:32:1);
    \node[font=\bfseries, scale=1.4] at (1.4, 0.35) {$\alpha$};
    
    % Ângulo Recto
    \draw[thick] (3.7,0) -- (3.7,0.3) -- (4,0.3);
    \fill[black] (3.85,0.15) circle (0.03);
    
\end{tikzpicture}
```

### 3. A Paralaxe Estelar e o Raio da Órbita Terrestre

Emerge, pois, a questão vital para o astrónomo prático: *Mas que distância $h$ é essa? Que transporte nos permite percorrer um cateto suficientemente vasto para notarmos o desvio angular de uma estrela que se encontra a biliões de quilómetros?*

A resposta assenta na grandiosidade da mecânica celeste. O nosso "autocarro" é o próprio planeta Terra, e o percurso é a nossa órbita em redor do Sol.
Para obtermos a maior separação possível (a nossa maior "distância entre os olhos"), observamos a estrela numa determinada noite — por exemplo, em Janeiro —, aguardamos rigorosamente seis meses, e voltamos a observá-la em Julho. Durante este semestre temporal, a Terra viajou para o extremo diametralmente oposto da sua órbita.

Para efeitos matemáticos no triângulo rectângulo, utilizamos como base ($h$) não o diâmetro total, mas sim o **raio da órbita da Terra**, que equivale exactamente a **$1\,\mathrm{UA}$** (Uma Unidade Astronómica). O vértice do ângulo recto situa-se idealmente no Sol.

A fórmula mestre desta metodologia — universalmente conhecida como **Paralaxe Estelar** — reescreve-se, assim, pela substituição de $h$ pelo valor da Unidade Astronómica:

$$ \mathrm{tg}(\alpha) = \frac{1\,\mathrm{UA}}{d} \quad \Longrightarrow \quad d = \frac{1\,\mathrm{UA}}{\mathrm{tg}(\alpha)} $$

O diagrama que se segue recria, com formidável rigor visual, o alinhamento cósmico descrito nos diapositivos do curso:

```tikz
\begin{tikzpicture}[scale=1.2]
    % Fundo Espacial
    \fill[black!95] (-4.5, -1.5) rectangle (4.5, 4.5);
    
    % Estrelas de Fundo (Representação Aleatória)
    \foreach \x/\y in {-3.5/3, -2/4, 2.5/3.5, 3.8/2, -4/1.5, 1.5/4.2} {
        \node[star, star points=4, star point ratio=3, fill=white, inner sep=1pt] at (\x,\y) {};
    }
    
    % Sol
    \shade[ball color=yellow!80!orange] (0,0) circle (0.3);
    \node[below=0.4cm, text=white, font=\bfseries] at (0,0) {Sol};
    
    % Órbita da Terra
    \draw[dashed, gray!60, thick] (0,0) ellipse (3.5cm and 0.8cm);
    
    % Terra (Julho - Esquerda)
    \shade[ball color=blue!60!white] (-3.5,0) circle (0.15);
    \node[below left, text=white, font=\bfseries] at (-3.5,0) {Terra};
    
    % Terra (Janeiro - Direita)
    \shade[ball color=blue!60!white] (3.5,0) circle (0.15);
    
    % Estrela Alvo
    \node[star, star points=6, star point ratio=2.5, fill=yellow, draw=orange, inner sep=2pt] (estrela) at (0,3.5) {};
    
    % Linhas do Triângulo Rectângulo (Destacadas a Laranja)
    \draw[ultra thick, orange!90!red] (0,0) -- (-3.5,0) node[midway, above=2pt, text=white, font=\bfseries] {$1\,\mathrm{UA}$};
    \draw[ultra thick, orange!90!red] (0,0) -- (0,3.5) node[midway, right=2pt, text=white, font=\bfseries] {d};
    \draw[ultra thick, orange!90!red] (-3.5,0) -- (0,3.5);
    
    % Linhas de Visão da Terra
    \draw[dashed, white, thick] (-3.5,0) -- (0,4.5);
    \draw[dashed, white, thick] (3.5,0) -- (0,4.5);
    \draw[dotted, gray, thick] (0,0) -- (0,4.5);
    
    % Ângulo Alfa (Paralaxe)
    \draw[thick, white] (0,2.5) arc (270:225:1);
    \node[text=white, font=\bfseries, scale=1.4] at (-0.4, 2.2) {$\alpha$};
    
    % Ângulo Recto no Sol
    \draw[thick, orange!90!red] (-0.3,0) -- (-0.3,0.3) -- (0,0.3);
    \fill[orange!90!red] (-0.15,0.15) circle (0.04);
    
    % Caixa da Fórmula
    \node[fill=white, draw=orange!90!red, ultra thick, align=center, inner sep=5pt] at (2.5, 1.8) {$\displaystyle d = \frac{1\,\mathrm{UA}}{\mathrm{tg}(\alpha)}$};

\end{tikzpicture}
```

### 4. O Segundo de Arco e a Génese do *Parsec*

O método da paralaxe revela a sua utilidade suprema quando aplicado na prática astronómica. Contudo, devido à incomensurável distância que nos aparta do tecido interestelar, as alterações angulares medidas são microscopicamente diminutas. 

As estrelas não se movem graus inteiros nos nossos céus; movem-se fracções ínfimas de um grau. Na geometria circular, sabemos que $1^\circ$ (um grau) corresponde a uma simples fatia num círculo de $360^\circ$. Para obtermos a precisão necessária à nossa disciplina, dividimos esse único grau em sessenta minutos de arco ($60'$), e cada minuto em sessenta segundos de arco ($60''$). Por conseguinte, **$1\,\mathrm{segundo\ de\ arco}\ (1'')$ equivale à formidável fracção de $1^\circ / 3600$**.

Suponhamos, a título de exemplo rigoroso, que observamos uma estrela cuja paralaxe medida ($\alpha$) é de exactamente $1''$ (um segundo de arco).

Aplicando a nossa equação basilar:

$$ d = \frac{1\,\mathrm{UA}}{\mathrm{tg}(1/3600^\circ)} $$

A execução deste cálculo trigonométrico oferece-nos o assombroso valor de **$206.265\,\mathrm{UA}$**. Isto significa que a estrela estaria a uma distância duzentas e seis mil vezes superior à distância da Terra ao Sol.

Para mitigar a profusão de zeros e números avassaladores, os astrónomos converteram este valor para anos-luz (a distância que a luz percorre no vácuo ao fim de um ano terrestre). A conversão dita que $206.265\,\mathrm{UA}$ equivalem a aproximadamente **$3,26\,\mathrm{anos-luz}\ (\mathrm{a.l.})$**. 

Foi a partir desta relação umbilical entre a paralaxe e a distância que se forjou a unidade de medida por excelência da astrofísica profissional: o **Parsec** (aglutinação dos termos *Paralaxe* e *Segundo*). 

Define-se categoricamente o parsec como **a distância à qual uma estrela teria de estar posicionada para exibir uma paralaxe de exactamente $1\,\mathrm{segundo\ de\ arco}$**. 

Em suma, deduzimos a seguinte igualdade de ouro, que pautará todos os nossos futuros cálculos estelares:

$$ 1\,\mathrm{pc} = 3,26\,\mathrm{a.l.} \quad \Longrightarrow \quad \mathbf{1\,\mathrm{pc} \simeq 3\,\mathrm{a.l.}} $$

O docente acrescenta, com sublime franqueza pedagógica, que mesmo o nosso vizinho estelar mais imediato — a estrela *Proxima Centauri* — orbita a sensivelmente $4,2\,\mathrm{a.l.}$, o que denota que a sua paralaxe é inclusivamente *inferior* a um segundo de arco. Isto atesta, de forma insofismável, que a vastidão gélida do cosmos exige de nós um assombroso rigor matemático, no qual a oscilação minúscula de uma fracção de grau no telescópio dita a arquitectura de distâncias verdadeiramente divinas.