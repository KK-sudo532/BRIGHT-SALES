# BRIGHT-SALES

# Sales Analysis Case Study

## Project Overview

This project involves developing metrics and deriving insights from a simulated daily sales dataset ("Sales Case Study.csv") for a single product at a large retail store.The objective is to analyze the product's sales performance, pricing, and profitability by calculating specific metrics and identifying key trends.

---

## Data Source

The analysis is based on the `Sales Case Study (2).csv`, which contains daily aggregated trading information.

Each record includes:
* **Date**: The day on which the sales occurred [cite: 8]
* **Sales**: Total Rand value of the sales that occurred [cite: 9]
* **Cost of Sales**: Total Rand value of the cost of sales that occurred [cite: 10]
* **Quantity Sold**: Total number of units that have been sold [cite: 11]

---

## Files in this Project

* `README.md`: This summary file.
* `Case Study - Sales Analysis.pdf`: The original case study brief and instructions.
* `Sales Case Study (2).csv`: The raw dataset used for the analysis.

---

## Analysis & Metrics

The following metrics were developed as per the case study instructions.

### 1. Daily Sales Price per Unit
This metric shows the average selling price for one unit on any given day.
* **Formula**: `Sales / Quantity Sold`
* **Example (30/12/2013)**: R223,937.97 / 6,827 = **R32.80 per unit**

### 2. Average Unit Sales Price
This is the average selling price of the product across the entire dataset.
* **Formula**: `Total Sales / Total Quantity Sold`
* **Result**: R87,998,211.83 / 2,631,189 = **R33.44 per unit**

### 3. Daily % Gross Profit
This metric shows the daily profit margin relative to sales.
* **Formula**: `(Sales - Cost of Sales) / Sales`
* **Example (8/1/2014)**: (R101,836.40 - R99,381.97) / R101,836.40 = **2.41%**

### 4. Daily % Gross Profit per Unit
This metric is mathematically identical to the "Daily % Gross Profit"[cite: 18]. The profit margin as a percentage is the same whether calculated on the total daily figures or on a per-unit basis.
* **Formula**: `(Sales Price per Unit - Cost Price per Unit) / Sales Price per Unit`

### 5. Price Elasticity of Demand (PED)
This metric was used to measure demand sensitivity to price changes during promotional periods.
* **Formula (Midpoint Method)**:
    $$PED = \frac{\%\ \text{Change in Quantity}}{\%\ \text{Change in Price}} = \frac{((Q_2 - Q_1) / ((Q_2 + Q_1) / 2))}{((P_2 - P_1) / ((P_2 + P_1) / 2))}$$
* **Findings**:
    * **Period 1 (Late Feb 2014)**: PED $\approx$ **-23.9**
    * **Period 2 (Late July 2014)**: PED $\approx$ **-21.6**
    * **Period 3 (Late Aug 2014)**: PED $\approx$ **-16.4**
* **Conclusion**: The product is **extremely elastic**. A small drop in price (7-8%) led to massive increases in quantity sold (130-170%).

---

## Key Insights & Conclusion

### Insight 1: Promotional Performance
In my opinion, the product performs **significantly worse** when sold at a promotional price.

* **Reason**: While the promotions effectively drive volume (as shown by the high elasticity), they are financially detrimental. In all identified promotional periods, the **sales price was set below the cost price**.
* **Result**: The store lost money on every unit sold, resulting in a **negative gross profit** for those days. For example, the promotion on 28/02/2014 generated a loss of over R24,000.

### Insight 2: Overall Unprofitability
The most critical insight from the dataset is that this product is **unprofitable** over the entire observed period.

* **Total Sales**: R87,998,211.83
* **Total Cost of Sales**: R91,128,111.41
* **Total Gross (Loss)**: **(R3,129,899.58)**

The business is failing because its average cost per unit (R34.63) is higher than its average selling price (R33.44).

### Insight 3: A Profitable (but ignored) Strategy
The data shows that the product was only profitable during periods where the price was **increased**, not decreased.

* **Example**: In November 2014, the price was raised to **R42.33**. While sales volume dropped, the gross profit margin spiked to **13.30%**.
* **Conclusion**: The business is focused on a high-volume, low-price strategy that is accelerating its losses. The optimal (most profitable) price point is significantly higher than the average, and the promotions are actively damaging the product's profitability.
