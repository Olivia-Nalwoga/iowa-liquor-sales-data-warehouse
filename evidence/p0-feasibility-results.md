# P0 Feasibility Results

## Source

`bigquery-public-data.iowa_liquor_sales.sales`

## Verified results

- Rows: 34,016,839
- Columns: 24
- Earliest date: 2012-01-03
- Latest date: 2026-04-30
- Missing `invoice_and_item_number`: 0
- Distinct `invoice_and_item_number`: 34,016,839
- Missing `store_number`: 0
- Missing `item_number`: 0
- Missing `vendor_number`: 9
- Missing `sale_dollars`: 10

## Interpretation

The `invoice_and_item_number` field had no missing values and its number of distinct values matched the total row count, so I did not find duplicates in this field.

The `store_number` and `item_number` fields also had no missing values. I found a very small number of missing values in `vendor_number` and `sale_dollars`.

The source covers transactions from January 3, 2012 through April 30, 2026.
