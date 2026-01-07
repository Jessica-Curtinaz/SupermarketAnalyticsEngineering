/* ================================================================================
	RANKING DE PRODUTOS MAIS VENDIDOS POR LOJA
	CONCEITOS: ROW_NUMBER/DENSE_RANK (Window Function), PARTITION BY, SUBQUERY
================================================================================
	Explicação: Queremos saber quais são os TOP 3 produtos de CADA loja.
	Usamos Partition By para "zerar" o ranking a cada nova loja.
*/

WITH RankingProdutos AS (
    SELECT 
        l.nome AS Loja,
        p.produto AS Produto,
        SUM(v.quantidade) AS Total_Unidades,
        ROW_NUMBER() OVER (
            PARTITION BY l.nome 
            ORDER BY SUM(v.quantidade) DESC
        ) AS Ranking_Loja
    FROM fato_vendas v
    JOIN dim_lojas l ON v.id_loja = l.id_loja
    JOIN dim_produtos p ON v.id_produto = p.sku
    GROUP BY l.nome, p.produto
)
SELECT
    Loja,
    Produto,
    Total_Unidades,
    Ranking_Loja
FROM RankingProdutos
WHERE Ranking_Loja <= 3
ORDER BY Loja, Ranking_Loja;
