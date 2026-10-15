-- Record the authorized objects and inspect their definitions.
SELECT
  column_name,
  data_type,
  is_nullable
FROM `bigquery-public-data.iowa_liquor_sales.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'sales'
ORDER BY ordinal_position;

-- Establish basic scale without exporting row-level data.
SELECT
  COUNT(*) AS row_count
FROM `bigquery-public-data.iowa_liquor_sales.sales`;

-- Test the time coverage and candidate identifier relevant to the idea.
SELECT
  MIN(date) AS earliest_date,
  MAX(date) AS latest_date,
  COUNTIF(invoice_and_item_number IS NULL) AS null_candidate_ids,
  COUNT(DISTINCT invoice_and_item_number) AS distinct_candidate_ids
FROM `bigquery-public-data.iowa_liquor_sales.sales`;

-- Check missing values in important analytical fields.
SELECT
  COUNTIF(store_number IS NULL) AS null_store_numbers,
  COUNTIF(item_number IS NULL) AS null_item_numbers,
  COUNTIF(vendor_number IS NULL) AS null_vendor_numbers,
  COUNTIF(sale_dollars IS NULL) AS null_sale_dollars
FROM `bigquery-public-data.iowa_liquor_sales.sales`;
