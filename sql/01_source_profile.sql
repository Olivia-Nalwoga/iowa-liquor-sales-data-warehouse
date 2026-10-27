WITH grain_groups AS (
  SELECT
    invoice_and_item_number,
    COUNT(*) AS rows_per_id
  FROM `bigquery-public-data.iowa_liquor_sales.sales`
  GROUP BY invoice_and_item_number
)
SELECT
  COALESCE(SUM(rows_per_id), 0) AS source_rows,
  COALESCE(SUM(IF(invoice_and_item_number IS NULL, rows_per_id, 0)), 0) AS rows_with_null_id,
  COUNTIF(invoice_and_item_number IS NOT NULL AND rows_per_id > 1) AS repeated_id_groups
FROM grain_groups;
