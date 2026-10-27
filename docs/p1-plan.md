# P1 - Grain, Model, History & Pipeline Plan

## 1. Establish the question and check the source

### Audience and need

The intended audience is retail sales and category analysts who want to understand how liquor purchasing activity differs across product categories, vendors, stores, locations, and time in Iowa. The warehouse will make it easier for analysts to compare purchasing patterns without repeatedly working directly with the full source table.

### Primary analytical question

**How do retailer liquor purchase dollars vary across product categories and vendors over time in Iowa?**

This question focuses on identifying which product categories and vendors account for the largest retailer purchase dollars and whether those patterns change over time.

### Supporting question

**Which stores and counties account for the largest retailer purchasing activity within the highest-purchasing product categories and vendors?**

This supporting question adds a geographic and store-level view while still using the same warehouse model.

### Change from P0

The main change from P0 is that I narrowed the project from several possible sales questions to one primary analytical question. I also changed the wording from “sales dollars” to **retailer purchase dollars** because the source represents liquor purchased by Iowa retail stores rather than purchases made by individual consumers.

### Source

The source object is:

`bigquery-public-data.iowa_liquor_sales.sales`

One source row appears to represent one invoice-item line for a liquor product purchased by an Iowa retail store on a specific transaction date.

From my P0 profiling, the table contained **34,016,839 rows** and **24 columns**. The transaction dates I verified in BigQuery ranged from **January 3, 2012 through April 30, 2026**.

The main candidate identifier is `invoice_and_item_number`. In my P0 check, this field had **0 missing values** and **34,016,839 distinct values**, which matched the total row count. I did not find duplicate values in this field, so it appears to be a strong candidate for identifying one invoice-item fact row.

Important fields for the project include `date`, `store_number`, `store_name`, `city`, `county`, `category_name`, `vendor_number`, `vendor_name`, `item_number`, `item_description`, `bottles_sold`, and `sale_dollars`.

One important data issue is that descriptive labels such as store names, vendor names, and category names may change over time. I will need to check how these changes affect historical comparisons before using them as dimension attributes.

Another limitation is that the source represents retailer purchasing activity, not direct consumer alcohol consumption. Therefore, I will not interpret higher retailer purchase dollars as proof that people in an area consumed more alcohol.

### Grain check

I tested whether `invoice_and_item_number` can identify one fact row in the source.

The grain check returned:

| Result | Observed value |
| --- | ---: |
| Source rows | 34,016,839 |
| Rows with missing `invoice_and_item_number` | 0 |
| Repeated `invoice_and_item_number` groups | 0 |

The result supports the proposed grain because every source row has an `invoice_and_item_number`, and I did not find any repeated identifier groups. Based on this check, I plan to use an invoice-item transaction line as the grain of the central fact table.

The reproducible SQL for this check is saved in:

`sql/01_source_profile.sql`

## 2. Define the model and predict a history consequence

## 3. Plan the build and its checks

## 4. Diagnose and revise the plan
