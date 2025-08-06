-- ================================================================
-- Project     : Nike Sales Data Cleaning & Preparation
-- Author      : Ali Bin Asim
-- Date        : 2025-08-06
-- Description : Cleansing, standardizing, and transforming raw sales data
--               to prepare for analytics and reporting
-- ================================================================

-- ============================
-- Step 1: Inspect Raw Dataset
-- ============================
SELECT * 
FROM Nike_Sales_Uncleaned;

-- ===========================================
-- Step 2: Rename Columns for Naming Consistency
-- ===========================================
EXEC sp_rename 'Nike_Sales_Uncleaned.product_name', 'Product_Name', 'COLUMN';

-- ===================================================
-- Step 3: Trim Whitespaces in Key Text-Based Columns
-- ===================================================
UPDATE Nike_Sales_Uncleaned
SET Product_Name    = TRIM(Product_Name),
    Product_Line    = TRIM(Product_Line),
    Gender_Category = TRIM(Gender_Category);

-- ========================================================
-- Step 4: Remove Rows with NULLs in Critical Data Columns
-- ========================================================
DELETE FROM Nike_Sales_Uncleaned
WHERE Units_Sold IS NULL 
   OR MRP IS NULL 
   OR Discount_Applied IS NULL 
   OR Order_Date IS NULL
   OR Size IS NULL;

-- Note: 118 rows removed due to missing values.

-- ==================================================
-- Step 5: Remove Duplicate Records Based on Key Fields
-- ==================================================
WITH Duplicates_CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY Order_Date, Order_ID, Product_Name, Product_Line, Size,
                            Units_Sold, MRP, Discount_Applied, Revenue, Sales_Channel, Region, Profit
               ORDER BY (SELECT NULL)
           ) AS rn
    FROM Nike_Sales_Uncleaned
)
DELETE FROM Duplicates_CTE
WHERE rn > 1;

-- Note: No duplicate records were found and removed.

-- ============================================
-- Step 6: Standardize Regional Names (Cleaning)
-- ============================================
-- Preview unique region values
SELECT DISTINCT Region
FROM Nike_Sales_Uncleaned;

-- Fix inconsistent region names
UPDATE Nike_Sales_Uncleaned
SET Region = 'Hyderabad'
WHERE Region IN ('Hyd', 'hyderbad');

UPDATE Nike_Sales_Uncleaned
SET Region = 'Bengaluru'
WHERE Region IN ('bengaluru', 'Bangalore');

-- =================================
-- Step 7: Preview Cleaned Data Set
-- =================================
SELECT * 
FROM Nike_Sales_Uncleaned;

-- ===================================================
-- Step 8: Convert Data Types of Numeric Columns (INT)
-- ===================================================
ALTER TABLE Nike_Sales_Uncleaned ALTER COLUMN MRP INT;
ALTER TABLE Nike_Sales_Uncleaned ALTER COLUMN Revenue INT;
ALTER TABLE Nike_Sales_Uncleaned ALTER COLUMN Profit INT;

-- =====================================================
-- Step 9: Convert Discount Rate to Percentage Format
-- =====================================================
UPDATE Nike_Sales_Uncleaned
SET Discount_Applied = ROUND(Discount_Applied * 100, 1);

-- =======================================
-- Step 10: Clean and Validate Size Column
-- =======================================
-- Set invalid numeric sizes to NULL
UPDATE Nike_Sales_Uncleaned
SET Size = NULL
WHERE TRY_CAST(Size AS INT) IS NOT NULL;

-- Remove remaining NULLs from Size column
DELETE FROM Nike_Sales_Uncleaned
WHERE Size IS NULL;

-- ================================
-- Final Step: Verify Cleaned Data
-- ================================
SELECT * 
FROM Nike_Sales_Uncleaned;