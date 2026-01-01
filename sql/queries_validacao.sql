-- Conferência de integridade e estrutura do Data Warehouse

-- 1. Verificando se o período de datas carregado está correto
SELECT 
    MIN(data) AS Data_Inicial,
    MAX(data) AS Data_Final,
    COUNT(*) AS Qtd_Dias_Cadastrados
FROM dim_datas;

-- 2. Conferindo a volumetria total da Fato
SELECT COUNT(*) AS Total_Linhas_Vendas FROM fato_vendas;

-- 3. Validando se existem vendas órfãs (Sem cliente ou loja)
-- Se retornar 0, significa que a integridade referencial está perfeita
SELECT count(*) AS Erros_Integridade
FROM fato_vendas v
LEFT JOIN dim_lojas l ON v.id_loja = l.id_loja
WHERE l.id_loja IS NULL;

-- 4. Amostra de dados para visualização rápida
SELECT TOP 100 * FROM fato_vendas ORDER BY id_venda DESC;

