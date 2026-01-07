/* ================================================================================
	ANÁLISE DE CRESCIMENTO MENSAL (Month-over-Month Growth)
	CONCEITOS: CTE, GROUP BY, LAG (Window Function), ARITHMETIC
================================================================================
*/

WITH VendasMensais AS (
    SELECT 
        d.ano AS Ano,
        d.mes AS Mes,
        d.nome_mes,
        SUM(v.valor_final_total) AS Faturamento_Mensal
    FROM fato_vendas v
    JOIN dim_datas d ON v.id_data = d.id_data
    GROUP BY d.ano, d.mes, d.nome_mes
),
CrescimentoMensal AS (
    SELECT
        ano,
        mes,
        nome_mes,
        Faturamento_Mensal,
        LAG(Faturamento_Mensal) OVER (ORDER BY ano, mes) AS Faturamento_Mes_Anterior
    FROM VendasMensais
)
SELECT
    ano,
    nome_mes,
    Faturamento_Mensal,
    Faturamento_Mes_Anterior,
    
    CASE 
        WHEN Faturamento_Mes_Anterior IS NULL THEN NULL
        WHEN Faturamento_Mes_Anterior = 0 THEN NULL
        ELSE 
            (Faturamento_Mensal - Faturamento_Mes_Anterior) 
            / Faturamento_Mes_Anterior
    END AS Crescimento_Percentual
FROM CrescimentoMensal
ORDER BY ano, mes;
