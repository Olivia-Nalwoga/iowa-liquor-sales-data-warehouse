# P0 - Need, Audience, Dataset & Feasibility

**Olivia Nalwoga | SEIS 732 - Data Warehousing**

## 1. Working title

Retail Sales Data Warehouse in BigQuery

## 2. Audience and need

The intended audience is retail sales and category analysts who need to understand how liquor sales perform across products, vendors, stores, and locations in Iowa. These analysts need to identify which products and categories are performing well, which vendors and stores contribute the most sales, and how sales patterns change over time.

The source contains millions of transaction records, which can be difficult to work with directly for repeated reporting. A BigQuery data warehouse could organize the data into a structure that makes it easier to compare sales by product, vendor, store, location, and time. If the product is useful, analysts could identify strong or declining sales areas, compare vendor and product performance, and focus attention on areas where sales patterns are changing.

## 3. Proposed analytical product and questions

I plan to build a BigQuery retail sales data warehouse with analytical tables or views that can later support a dashboard for exploring sales performance by time, product, vendor, store, and location.

- Which product categories and vendors generate the highest sales dollars over time?
- Which stores and counties have the strongest sales performance?
- How do sales dollars and bottles sold change by month and year?
- Which product categories show the largest increases or decreases in sales over time?

## 4. Source identification and access

| Item | Value |
|---|---|
| Dataset name | Iowa Liquor Sales |
| Provider | State of Iowa public liquor sales data |
| Source documentation | [Iowa Liquor Sales, January 2012 - Current — Iowa Data Hub](https://data.iowa.gov/catalog/dataset/1051) |
| BigQuery project | `bigquery-public-data` |
| BigQuery dataset | `iowa_liquor_sales` |
| Candidate table | `sales` |
| Full table name | `bigquery-public-data.iowa_liquor_sales.sales` |
| Location / region | US |
| Access | Publicly accessible from the course Google Cloud environment |

The Iowa Data Hub describes the source as liquor purchase information from January 2012 through the most current month and lists the source as publicly available. The data is available in BigQuery through the `bigquery-public-data.iowa_liquor_sales.sales` table, which is the table I used for my profiling and feasibility checks.

Because the source is already available in BigQuery and accessible from the course environment, I did not need to create a separate ingestion process for P0.

## 5. Quick source profile

**Grain:** One row appears to represent one invoice-item line for a liquor product purchased by an Iowa retail store on a given date.

**Current row count:** The `sales` table contains 34,016,839 rows and 24 columns. The data covers from January 3, 2012 to April 30, 2026.

**Main possible key:** `invoice_and_item_number`. This field had 0 missing values and 34,016,839 distinct values. Since the number of distinct values is the same as the total number of rows, I did not find duplicates in this field. This makes it a strong candidate key for the current source table.

I also checked some important fields for the analysis. The `store_number` field had 0 missing values and `item_number` also had 0 missing values. I found 9 missing `vendor_number` values and 10 missing `sale_dollars` values.

The table contains fields that can support my proposed questions, including `date`, `store_number`, `store_name`, `city`, `county`, `category_name`, `vendor_number`, `vendor_name`, `item_number`, `item_description`, `bottles_sold`, `sale_dollars`, and volume fields.

The schema includes data types such as `STRING`, `DATE`, `INT64`, `FLOAT64`, and `GEOGRAPHY`. I did not see nested or repeated fields in the table.

One interpretation concern is that the dataset represents liquor purchased by Iowa retail stores, not purchases made by individual customers. I will therefore treat the data as retailer purchase activity when analyzing the source.

Another concern is the refresh timing. The Iowa Data Hub lists the source as being updated monthly. However, the latest transaction date I found in the BigQuery table is April 30, 2026, even though the BigQuery table was modified later. For this project, I will use the transaction dates in BigQuery as the actual analytical time coverage.

## 6. Need-to-source fit

| Proposed question | Needed fields or concepts | Candidate source object | Why the source appears sufficient | Gap or assumption to test in P1 |
|---|---|---|---|---|
| Which product categories and vendors generate the highest sales dollars over time? | `date`, `category_name`, `vendor_name`, `sale_dollars` | `sales` | The table contains dates, product categories, vendor names, and sales-dollar measures. | Check whether category or vendor names change over time and whether missing vendor values affect analysis. |
| Which stores and counties have the strongest sales performance? | `store_number`, `store_name`, `county`, `sale_dollars`, `bottles_sold` | `sales` | The table contains store identifiers, store names, county, sales dollars, and bottles sold. | Check whether store names and county values are consistent across time. |
| How do sales dollars and bottles sold change by month and year? | `date`, `sale_dollars`, `bottles_sold` | `sales` | The table has a transaction date and numeric sales measures, so monthly and yearly trends can be calculated. | Decide the reporting time range and how to handle the few missing `sale_dollars` values. |
| Which product categories show the largest increases or decreases in sales over time? | `date`, `category_name`, `sale_dollars` | `sales` | The source contains historical dates, category names, and sales-dollar values across many years. | Check whether category labels remain stable enough for year-over-year comparison. |

## 7. Feasibility risks and response

One risk is the size of the source table. The `sales` table has more than 34 million rows, so some queries can scan a large amount of data. I know that using `LIMIT` does not necessarily reduce query cost because BigQuery may still scan the selected columns. To reduce the amount of data processed, I plan to select only the columns I need instead of using `SELECT *`. I will also consider using a smaller analysis period, such as a few recent years, instead of using the full history if that is enough to answer my questions.

Another option I can use later is partitioning by date so queries can scan only the dates needed for the analysis. I may also use clustering on fields such as county, store, or category if those fields are commonly used for filtering and grouping. I will decide this after I finalize the warehouse design in P1.

Another risk is that some descriptive values may change over time. Store names, vendor names, category names, or county values may not always be entered the same way across all years. I will check these fields before I use them as dimensions in the warehouse.

I also found a small number of missing values. There were 9 missing `vendor_number` values and 10 missing `sale_dollars` values. These counts are very small compared with the size of the table, but I still need to decide how to handle them in the warehouse and reporting layer.

**Fallback:** If using the full date range makes the project too large or expensive to query, I will narrow the analysis to a smaller number of recent years while still using the same source and business questions.

## 8. First P1 decision

My first important decision in P1 will be the exact grain of the central fact table. From my profiling, `invoice_and_item_number` is unique and has no missing values, so it appears to identify one invoice-item sales line in the source. In P1, I will decide whether this invoice-item line should be the grain of the fact table and how the store, product, vendor, category, and date fields should connect to that fact table.

## 9. AI/Tool Accountability

I used ChatGPT to help me understand the P0 requirements and compare possible project ideas. I used the suggestions as guidance, not as evidence.

I verified the dataset myself in BigQuery by reviewing the table schema, checking the table details, and running my own queries to confirm the date range, candidate key, and missing values. The information in this proposal is based on the results I personally observed in my course Google Cloud environment.
