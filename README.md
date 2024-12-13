# Analyzing the Shopping Trend

This project aims to analyze the development of customer purchasing trends for various products over specific periods. This analysis can serve as an evaluation material and a basis for developing new strategies in the future based on existing historical data. The analysis is performed using SQL queries on the shopping_trends dataset.

# Table of Content
1. Customer Behaviour Analysis
2. Identify Product and Category Insights
3. Develop customer segmentation
4. Build predictive models for sales forecasting and customer retention

# 1. Customer Behaviour Analysis
Objective : This part aims to analyze customer purchasing behavior, including the quantity and frequency of purchases over time. Additionally, it examines clothing category trends among various buyer demographics based on age.

- Frequency of Purchases Analysis
  - Groups purchasing data by frequency (e.g., Weekly, Monthly) to calculate total transactions and total purchase amounts.
  - Results ordered by predefined frequency ranking for better clarity.
    
- Demographic Trends
  - Groups data by age group, gender, and product category.
  - Highlights trends across different age groups (e.g., 18-25, 25-35) and genders.

# 2. Identify Product and Category Insights
Objective: Uncover insights into popular product categories, colors, and sizes. 

- Popular Product Categories
  - Identifies the most purchased product categories by calculating the total transactions for each category.

- Popular Color and Size Trends
  - Highlights the most popular colors and sizes purchased by customers.
  - Sizes are ranked for logical ordering (S, M, L, XL).

# 3. Develop Customer Segmentation
Objective: Segment customers based on geographic, demographic, and behavioral data.

- Location-Based Analysis
  - Groups customers by location to identify regional customer distribution.

- Age and Gender Distribution
  -Segments customers by age groups and gender to determine their proportions and purchasing patterns.

- Shopping Behavior Analysis
  - Examines shopping behavior by analyzing the items purchased most frequently by customers.

- Comprehensive Segmentation
  - Combines geographic, demographic, and behavioral data for detailed customer segmentation.
  - Includes insights on average spending and purchased items.

# 4. Predictive Models for Sales Forecasting and Customer Retention
Objective: Build predictive models to anticipate future sales and improve customer retention strategies.

-Sales Forecasting
  - Analyzes total purchase amounts based on seasons, gender, and purchased items to predict sales trends.

- Customer Retention
  - Segments customers into categories (Loyal, Returning, New) based on their purchase history.
  - Includes subscription status, payment methods, and shipping types.
  - Provides discount rates based on customer loyalty to encourage retention.

# Data Source 
- Dataset Name: Customer Shopping Trends
- Provider: Fathy Fathy Sahlool
- Source URL: https://www.kaggle.com/code/fathyfathysahlool/customer-shopping-trends
- Description: This dataset contains customer shopping trends data, including:
  - Customer Information: customer_id, age, gender, and location.
  - Shopping Behavior: Product categories, purchase quantities, purchase frequencies, and payment methods.
  - Demographics: Detailed insights based on age and gender distribution.
  - Geographical Data: Customer locations for regional analysis.
