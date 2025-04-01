SELECT COUNT(*) AS row_count
FROM adv_works.customers;


SELECT * FROM adv_works.customers LIMIT 10;

--Сегментация по доходу:

SELECT 
    "Occupation",
    COUNT(*) AS number_of_customers,
    AVG("YearlyIncome") AS avg_income
FROM 
    adv_works.customers
GROUP BY 
    "Occupation"
ORDER BY 
    avg_income DESC;

--Семейный профиль: 

SELECT 
    CASE 
        WHEN "NumberChildrenAtHome" > 0 THEN 1
        ELSE 0 
    END AS has_children,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM adv_works.customers), 2) AS pct_of_customer_base
FROM 
    adv_works.customers
GROUP BY 
    has_children;

--
--SELECT column_name
--FROM information_schema.columns
--WHERE table_schema = 'adv_works'
--AND table_name = 'customers';

--SELECT 
--    c."CustomerKey" AS customer_key,
--    c."Name" AS customer_name,
--    SUM(s.SalesAmount) AS total_purchase
--FROM 
--    adv_works.customers c
--JOIN 
--    adv_works.sales s
--ON 
--    c."CustomerKey" = s.CustomerID
--GROUP BY 
--    c."CustomerKey", c.Name
--ORDER BY 
--    total_purchase DESC
--LIMIT 10;

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'adv_works';

SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_name = 'sales';


SELECT 
    c."CustomerKey" AS customer_key,
    c."Name" AS customer_name,
    SUM(s."quantity") AS total_purchase
FROM 
    adv_works.customers c
JOIN 
    store.sales s
ON 
    c."CustomerKey" = s."customer_id"
GROUP BY 
    c."CustomerKey", c."Name"
ORDER BY 
    total_purchase DESC
LIMIT 10;

SELECT column_name
FROM information_schema.columns
WHERE table_schema = 'store'
AND table_name = 'sales';


SELECT COUNT(*) AS row_count
FROM store.sales;

SELECT *
FROM store.sales
LIMIT 10;


SELECT DISTINCT s.customer_id
FROM store.sales s
LEFT JOIN adv_works.customers c
ON s.customer_id = c."CustomerKey"
WHERE c."CustomerKey" IS NULL;

