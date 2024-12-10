-- Customer Behavior Analysis --
-- Analyze consumer purchasing patterns over time --
SELECT 
    frequency_of_purchases,
    item_purchased,
    category,
    COUNT(*) as total_transactions,
    SUM(purchased_amount) as total_purchased
FROM shopping_trends
GROUP BY frequency_of_purchases
ORDER BY 
	 CASE 
        WHEN frequency_of_purchases = 'Weekly' THEN 1
        WHEN frequency_of_purchases = 'Bi-Weekly' THEN 2
        WHEN frequency_of_purchases = 'Monthly' THEN 3
        WHEN frequency_of_purchases = 'Quarterly' THEN 4
        WHEN frequency_of_purchases = 'Annually' THEN 5
        ELSE 6
    END;

-- Identify trends across different age groups and genders --
SELECT
	CASE
	WHEN age <= 25 THEN '18-25'
    WHEN age <= 35 THEN '25-35'
    WHEN age <= 45 THEN '35-45'
    WHEN age > 45 THEN '> 45'
END AS age_group,
	gender,
	category,
    count(*) total_customer
FROM shopping_trends
GROUP BY age_group,gender, category
ORDER BY age_group,gender, total_customer desc;
    

-- 2. Identify Product and Category Insights --
-- Popular Product Categories --
SELECT 
	category,
	count(purchased_amount) as total_purchased
FROM shopping_trends
GROUP BY category
ORDER BY total_purchased desc;

-- Examine popular color and size trends -
SELECT
    color as popular_color,
    count(*) total_purchased
FROM shopping_trends
GROUP BY color
ORDER BY total_purchased DESC;

SELECT
    size as popular_size,
    count(*) total_purchased
FROM shopping_trends
GROUP BY size
ORDER BY 
CASE
	WHEN size = 'S' THEN '1'
	WHEN size = 'M' THEN '2'
	WHEN size = 'L' THEN '3'
	WHEN size = 'XL' THEN '4'
    ELSE '5'
END,
	size, total_purchased DESC;
    

-- 3. Develop customer segmentation --
-- location based analysis
SELECT
	location
	customerid,
    count(customerid) as total_customer
FROM shopping_trends
GROUP BY location
ORDER BY location;

-- age distribution
SELECT
	CASE
        WHEN age <= 25 THEN '18-25'
        WHEN age <= 35 THEN '25-35'
        WHEN age <= 45 THEN '35-45'
        WHEN age > 45 THEN '> 45'
    END AS age_group,
    count(customerid) total_customer
FROM shopping_trends
GROUP BY age_group
ORDER BY age_group;

-- gender proporsition
SELECT
	gender,
    count(customerid) total_customer
FROM shopping_trends
GROUP BY gender
ORDER BY gender;

-- shopping behaviour
SELECT 
	item_purchased,
    count(customerid) as total_customer
FROM shopping_trends
GROUP BY item_purchased
ORDER BY total_customer DESC;

-- Customer Segmentation berdasarkan geographics, demographics dan consumer behaviour
SELECT 
	location,
    CASE
        WHEN age <= 25 THEN '18-25'
        WHEN age <= 35 THEN '25-35'
        WHEN age <= 45 THEN '35-45'
        WHEN age > 45 THEN '> 45'
    END AS age_group,
    gender,
    category,
    count(*) as item_purchased,
    ROUND(avg(purchased_amount),2) AS avg_purchased
FROM shopping_trends
GROUP BY age_group,gender,location,category
ORDER BY location,age_group,gender, item_purchased desc
LIMIT 3000;

-- 4. Build predictive models for sales forecasting and customer retention --

-- Predictive for sales forecasting
SELECT
	season,
    gender,
    item_purchased,
    round(sum(purchased_amount)) as `total_purchased (USD)` 
FROM shopping_trends
GROUP BY season, gender, item_purchased
ORDER BY season, gender, `total_purchased (USD)` desc;

-- customer retention
SELECT
	customerid,
    CASE
		WHEN previous_purchases >= 25 THEN 'Loyal Customer'
		WHEN previous_purchases between 10 and 24 THEN 'Returning Customer'
		ELSE 'New Customer'
    END AS Customer_Category,
	subscription_status,
	previous_purchases as total_purchased,
    round(sum(purchased_amount)) as 'total_spending (USD)' ,
	payment_methode,
	shipping_type,
    frequency_of_purchases,
 CASE
		WHEN previous_purchases >= 25 THEN '25%'
        WHEN  previous_purchases between 10 and 24 THEN '15%'
        ELSE '5%'
	END AS discount
FROM shopping_trends
WHERE subscription_status = 'yes'
GROUP BY customerid, customer_category,payment_methode, subscription_status,  total_purchased, 'total_spending (USD)', payment_methode, shipping_type, frequency_of_purchases
ORDER BY customer_category, total_purchased, 'total_spending (USD)' asc
LIMIT 2000;




-- cte --

with agegroup as (
SELECT 
	CASE 
    WHEN age <= 25 THEN '18-25'
    WHEN age <= 35 THEN '25-35'
    WHEN age <= 45 THEN '35-45'
    WHEN age > 45 THEN '> 45'
END AS age_group,
	count(*) as total_customer,
	purchased_amount,
	item_purchased,
	category
FROM shopping_trends 
GROUP BY age_group, category, item_purchased, purchased_amount 
),

total_item as (
SELECT
	age_group,
    item_purchased,
    count(*) as total_item
from agegroup
group by age_group, item_purchased ),

popular_item as (
SELECT
	age_group,
	item_purchased,
    total_item,
    row_number() over (partition by age_group order by total_item asc) as rn
from total_item )

SELECT 
	agegroup.age_group,
    count(*) as total_customer,
    agegroup.category,
    popular_item.item_purchased as popular_item,
    round(avg(purchased_amount),2) as purchased_amount
FROM age_group 
LEFT JOIN popular_item ON agegroup.age_group = popular_item.age_group and popular_item.rn=1
GROUP BY agegroup.age_group, agegroup.category, popular_item.Item_Purchased
ORDER BY agegroup.age_group;