-- ============================================================
-- PROJETO: Análise de Performance @cec_informs (2025/2026)
-- AUTOR: Davi Aguiar Alcântara
-- ============================================================

-- ------------------------------------------------------------
-- PERGUNTA 1: Impacto do Dia de Jogo
-- Comparação de métricas médias entre dias com e sem partida
-- ------------------------------------------------------------
SELECT 
    CASE 
        WHEN j.data IS NOT NULL THEN 'Dia de Jogo'
        ELSE 'Dia Sem Jogo'
    END AS tipo_dia,
    COUNT(d.data) AS total_dias,
    ROUND(AVG(d.engajamentos), 2) AS media_engajamento,
    ROUND(AVG(d.impressoes), 2) AS media_impressoes,
    ROUND(AVG(d.curtidas), 2) AS media_curtidas
FROM dataset_cecinforms d
LEFT JOIN jogos_cruzeiro j ON d.data = j.data
GROUP BY tipo_dia;


-- ------------------------------------------------------------
-- PERGUNTA 2: Resultado da Partida
-- Impacto do resultado (Vitória, Empate, Derrota) nas métricas
-- ------------------------------------------------------------
SELECT
	ROUND(AVG(d.engajamentos)) as media_engajamentos,
	ROUND(AVG(d.impressoes)) as media_impressoes,
	ROUND(AVG(d.curtidas)) as media_curtidas,
	j.resultado
FROM dataset_cecinforms d join jogos_cruzeiro j
ON d."data" = j."data" 
GROUP BY j.resultado;


-- ------------------------------------------------------------
-- PERGUNTA 3: Efeito Ressaca (Pós-Jogo)
-- Análise do dia seguinte utilizando Window Functions (LEAD)
-- ------------------------------------------------------------
WITH engajamento_diario AS (
    SELECT 
        "data",
        SUM(engajamentos) AS engajamento_total,
        ROUND(AVG(engajamentos)) AS media_engajamento
    FROM dataset_cecinforms
    GROUP BY "data"
)
SELECT 
    j."data" AS data_jogo,
    j.resultado,
    j.adversario,
    COALESCE(e_jogo.engajamento_total, 0) AS engajamento_dia_jogo,
    COALESCE(e_pos.engajamento_total, 0) AS engajamento_dia_seguinte
FROM jogos_cruzeiro j
LEFT JOIN engajamento_diario e_jogo 
    ON j."data" = e_jogo."data"
LEFT JOIN engajamento_diario e_pos 
    ON e_pos."data" = j."data" + INTERVAL '1 day'
ORDER BY j."data";


-- ------------------------------------------------------------
-- PERGUNTA 4: Janela de Transferências vs. Temporada Regular
-- Comparação de performance por períodos sazonais do futebol
-- ------------------------------------------------------------
SELECT 
    CASE 
        WHEN d.data BETWEEN '2025-12-16' AND '2026-01-10' THEN 'Janela Fim de Ano'
        WHEN d.data BETWEEN '2026-06-01' AND '2026-07-22' THEN 'Janela Meio de Ano (Copa)'
        ELSE 'Temporada Regular'
    END AS periodo,
    COUNT(d.data) AS total_dias,
    ROUND(AVG(d.impressoes), 2) AS media_impressoes,
    ROUND(AVG(d.engajamentos), 2) AS media_engajamento,
    ROUND(AVG(d.curtidas), 2) AS media_curtidas
FROM dataset_cecinforms d
GROUP BY periodo
ORDER BY media_impressoes DESC;


-- ------------------------------------------------------------
-- PERGUNTA 5: Volume de Posts vs. Performance por Post
-- Agregação mensal corrigindo a granularidade com SUM(posts_criados)
-- ------------------------------------------------------------
SELECT
    TO_CHAR("data", 'YYYY-MM') AS mes_ano,
    SUM(posts_criados) AS total_posts,
    SUM(engajamentos) AS engajamento_total,
    ROUND(SUM(engajamentos) / NULLIF(SUM(qtd_posts), 0)) AS media_engajamento_por_post
FROM dataset_cecinforms
GROUP BY TO_CHAR("data", 'YYYY-MM')
ORDER BY mes_ano ASC;