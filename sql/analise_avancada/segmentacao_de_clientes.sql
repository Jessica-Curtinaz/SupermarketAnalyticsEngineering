/* ================================================================================
	SEGMENTAÇÃO DE CLIENTES (RFM Simplificado)
	CONCEITOS: CTE, CASE WHEN, DATEDIFF, MAX
================================================================================
	Explicação: Classifica clientes baseado na última vez que compraram (Recência).
*/

WITH UltimaCompra AS (
    SELECT 
        c.id_cliente,
        c.nome,
        MAX(v.data_venda) AS Data_Ultima_Compra,
        COUNT(v.id_venda) AS Frequencia,
        SUM(v.valor_final_total) AS Total_Gasto
    FROM fato_vendas v
    JOIN dim_clientes c ON v.id_cliente = c.id_cliente
    WHERE v.id_cliente IS NOT NULL
    GROUP BY c.id_cliente, c.nome
),
ClassificacaoClientes AS (
    SELECT
        nome,
        Data_Ultima_Compra,
        Frequencia,
        Total_Gasto,
        DATEDIFF(day, Data_Ultima_Compra, CAST(GETDATE() AS DATE)) AS Dias_Sem_Comprar
    FROM UltimaCompra
)
SELECT TOP 100
    nome,
    Data_Ultima_Compra,
    Frequencia,
    Total_Gasto,
    Dias_Sem_Comprar,
    
    CASE 
        WHEN Dias_Sem_Comprar > 180 THEN 'Churn'
        WHEN Total_Gasto >= 5000 AND Frequencia >= 10 THEN 'Cliente VIP'
        WHEN Frequencia >= 5 THEN 'Cliente Frequente'
        ELSE 'Cliente Ocasional'
    END AS Status_Cliente
FROM ClassificacaoClientes
ORDER BY Total_Gasto DESC;
