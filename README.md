# Iowa Liquor Sales Data Warehouse

SEIS 732 data warehousing project using the State of Iowa Liquor Sales public dataset in BigQuery.

The project is designed to support analysis of retailer liquor purchasing activity by product category, vendor, store, location, and time.

## Primary analytical question

**How do retailer liquor purchase dollars vary across product categories and vendors over time in Iowa?**

A supporting question examines which stores and counties account for the largest retailer purchasing activity within the highest-purchasing product categories and vendors.

## Source

BigQuery public dataset:

`bigquery-public-data.iowa_liquor_sales.sales`

The source represents liquor purchased by Iowa retail stores rather than purchases made directly by individual consumers.

The latest transaction date verified during profiling was **April 30, 2026**.

## Fact grain

The planned transaction fact table uses the following grain:

**One row represents one invoice-item transaction line for one liquor product purchased by one Iowa retail store on one transaction date.**

The source field `invoice_and_item_number` was tested as a candidate transaction identifier and had no missing values or repeated groups in the profiling check.

## Dimensional model

The planned warehouse includes:

- `FactLiquorPurchase`
- `DimDate`
- `DimStore`
- `DimProduct`
- `DimVendor`
- `DimCategory`

The main measures include:

- `sale_dollars`
- `bottles_sold`
- `volume_sold_liters`

[View dimensional model](docs/Model.png)

## Planned pipeline

The warehouse will follow a three-layer structure:

**Raw → Curated → Serving**

The Serving layer will summarize retailer purchase dollars by category, vendor, and time to support the primary analytical question.

## Project documents

### P0 - Need, Audience, Dataset & Feasibility

- [P0 feasibility document](docs/p0-feasibility.md)
- [P0 feasibility SQL](sql/00_feasibility.sql)
- [P0 feasibility results](evidence/p0-feasibility-results.md)

### P1 - Grain, Model, History & Pipeline Plan

- [P1 planning document](docs/p1-plan.md)
- [P1 source profiling SQL](sql/01_source_profile.sql)
- [Dimensional model](docs/Model.png)

## Project status

- P0: Completed
- P1: Grain, dimensional model, history strategy, and pipeline plan in progress
- P2: Warehouse build planned next
