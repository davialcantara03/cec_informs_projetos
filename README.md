# Análise de Performance e Engajamento da Página @cec_informs_ no X/Twitter durante a Temporada de Futebol

Com o objetivo de aprimorar os dados da cec_informs_ e entender melhor o que os números dizem, esta análise foi realizada através de um conjunto de dois datasets. Através do X Premium, fiz a extração das métricas disponíveis no intervalo dos últimos doze meses e cruzei com uma tabela de jogos do Cruzeiro no período de agosto de 2025 a agosto de 2026.

Para a realização do projeto, optei por fazer cinco perguntas base para obter as respostas mais claras e inteligentes, utilizando **Python(Pandas)** para limpeza, padronização de datas e cruzamentos das bases de dados no script `tratamento_dados.py`, **PostgreSQL via DBeaver** para consultar e responder as cinco perguntas de negócio com CTEs, Window Function e agregações. 
A etapa de modelagem visual, criação de dashboards interativos e relatórios em PDF do **CEC Informs** foi centralizada em um módulo dedicado, utilizando a ferramenta Power BI.
👉 **[Acesse aqui a documentação e os arquivos do Power BI](./powerbi_dashboard)**
## Perguntas de Negócio

**Pergunta 1: Impacto do dia de jogo** — qual o efeito de um dia de jogo para a CEC Informs?
O objetivo da pergunta é analisar o quão importante é o dia de jogo, já que é o principal "mercado" para a página, onde os torcedores estão naturalmente mais agitados, ansiosos e, de forma primitiva, se imagina que também engajam mais nestes momentos.

**Pergunta 2: Resultado da partida** — como cada resultado (vitória, empate, derrota) afeta as principais métricas?
Como um pequeno "prosseguimento" da pergunta 1, a questão atual vislumbra apontar como o público da página reage a cada resultado conquistado pelo Cruzeiro, utilizando o JOIN entre as duas tabelas para visualizar a média de engajamento, impressões e curtidas e entender um pouco mais sobre como funciona o ecossistema da rede e dos seguidores.

**Pergunta 3: Efeito ressaca** — como a página performa no dia seguinte ao jogo?
Utilizando Window Function no SQL através de funções como LAG e LEAD, a pergunta 3 visa responder uma questão interessante: o dia seguinte engaja mais que o próprio Matchday?

**Pergunta 4: Janela de transferências vs temporada regular** — comparação de performance entre os dois períodos
Fugindo um pouco de dias de jogos, a pergunta em questão tem como objetivo comparar os dois momentos principais nas jornadas dos clubes de futebol: a temporada regular, com jogos, e a janela de transferências, que neste intervalo analisado aconteceu entre dezembro de 2025 a janeiro de 2026, e por último, de junho a julho deste ano, influenciada principalmente pela disputa da Copa do Mundo FIFA, onde os jogos do mundo inteiro foram paralisados, deixando o foco única e exclusivamente para movimentações de mercado e contratações.

**Pergunta 5: Volume de posts vs performance por post** — o aumento em dia de jogo vem de mais posts, de melhor performance por post, ou dos dois?
Para encerrar, a pergunta 5 engloba um pouco de tudo das anteriores, com o objetivo final de avaliar se a quantidade de posts criados tem interferência direta nos números da CEC Informs, ou se meses com menos posts, mas com mais qualidade estatística, ainda pesam mais para o conteúdo ficar melhor e mais enxuto.

## Principais Insights

### Pergunta 1 — Impacto do dia de jogo

Pude notar que dias sem jogos engajam mais do que dias com partidas, e de maneira considerável:

- A média de engajamentos em dias sem jogos é **40% maior** do que em dias com jogos.
- A tônica se repete em curtidas (**+42%**) e impressões (**+77%**).

Isso demonstra, em números, que o público-alvo da página se envolve mais em dias que não houve jogos do Cruzeiro.

### Pergunta 3 — Efeito ressaca

O resultado é, de certa forma, surpreendente. Analisando os 57 jogos com dados registrados, o engajamento no dia seguinte ao jogo é, em média, **176,20% maior** do que no próprio dia do jogo, confirmando um forte "efeito ressaca" positivo na audiência:

- **Efeito Vitória:** maior salto proporcional — o engajamento no dia seguinte é mais que o quádruplo do dia do jogo (**+305,68%**).
- **Efeito Derrota:** o engajamento inicial no próprio dia do jogo é maior (9.689), porém o crescimento no dia seguinte é o menor da amostra (**+23,49%**).
- **Empates:** crescimento intermediário expressivo, mais que dobrando o engajamento no dia seguinte (**+158,13%**).

O resultado sugere que podemos aumentar a quantidade de posts durante os dias de jogos, alternando entre notícias, novos quadros e mais opiniões, já que o pós-jogo com repercussão, bastidores e comentários tem números consideravelmente superiores.

### Pergunta 4 — Janela de transferências vs temporada regular

As épocas de mercado trazem **44,90% de impressões a mais** em comparação com a temporada de jogos — uma vantagem clara, não um empate técnico. Uma interpretação plausível para esse dado tem contexto: no início da temporada, o Cruzeiro contratou Gerson, que naquele momento viria a ser a maior contratação da história do futebol brasileiro em termos de valores. No mesmo período, rejeitou ofertas do Flamengo pelo badalado centroavante Kaio Jorge, algo que causou grande comoção na rede. Ambos os fatos aconteceram na primeira quinzena de janeiro.

Por outro lado, durante o período de jogos, o engajamento aumenta 7% e as curtidas 14% em relação ao mercado de transferências.

### Pergunta 5 — Volume de posts vs performance por post

A pergunta derradeira confirma que, quanto mais posts a página faz, mais engajamento traz:

- **Pico do período (01/2026):** maior média de engajamento por post (20.488), **527,89% superior** ao menor mês do ano (Junho/2026, com 3.263).
- **Alcance máximo (01/2026):** média de impressões por post de 776.013, **430,40% maior** do que em Junho/2026 (146.306).
- **Janela de transferências / fim de ano (Dez/25–Jan/26):** média combinada de engajamento por post (17.226) é **137,67% maior** do que a média dos outros 11 meses (7.248).
- **Volume vs. performance:** o aumento no volume de postagens não diluiu o engajamento médio — os meses com maior quantidade de posts (Dezembro e Janeiro) coincidiram exatamente com o ápice de interesse do público.

Os meses de dezembro e janeiro, com mais posts, foram os que mais atraíram métricas positivas. Junho de 2026, mês marcado por não ter jogos devido à pausa para a Copa, foi o período com menos posts — e menos impacto.

## Limitações

A análise do efeito ressaca (Pergunta 3) considerou apenas o lag de 1 dia após o jogo, sem testar janelas maiores nem isolar a possível influência de notícias simultâneas ao jogo (como anúncios de contratação). Esse controle mais fino fica como próximo passo para aprofundar a análise.