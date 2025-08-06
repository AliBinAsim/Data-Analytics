# 🧼 Nike Sales Data Cleaning & Wrangling

### 📌 Project Overview
This project involves cleaning, standardizing, and transforming raw Nike sales data to prepare it for meaningful analysis and reporting. The raw data was sourced from a SQL Server database, cleaned using T-SQL, and optionally exported to CSV via Python and `pandas`.

---

## 🗃️ Dataset Description

The raw dataset (`Nike_Sales_Uncleaned`) contains transactional sales records with the following key fields:

- `Order_ID`
- `Order_Date`
- `Product_Name`
- `Product_Line`
- `Gender_Category`
- `Units_Sold`
- `MRP` (Maximum Retail Price)
- `Discount_Applied`
- `Revenue`
- `Profit`
- `Sales_Channel`
- `Region`
- `Size`

---

## ⚙️ Data Cleaning Steps

| Step | Description |
|------|-------------|
| 1️⃣ | View raw data |
| 2️⃣ | Renamed `product_name` to `Product_Name` for consistency |
| 3️⃣ | Trimmed whitespace in `Product_Name`, `Product_Line`, and `Gender_Category` |
| 4️⃣ | Deleted rows with `NULL` values in critical columns |
| 5️⃣ | Removed duplicate rows using `ROW_NUMBER()` and `CTE` |
| 6️⃣ | Standardized inconsistent values in `Region` column (e.g., "Hyd" → "Hyderabad") |
| 7️⃣ | Cast numeric columns (`MRP`, `Revenue`, `Profit`) to `INT` |
| 8️⃣ | Converted `Discount_Applied` from decimal to percentage (rounded to 1 decimal) |
| 9️⃣ | Cleaned `Size` column by removing numeric-only values |
| 🔟 | Final inspection of cleaned dataset |

---

## 🛠️ Tools Used

- **SQL Server** (T-SQL for data transformation)
- **Python** (Optional: for exporting cleaned data using `pandas`)
- **Libraries**:
  - `pyodbc`
  - `pandas`

---

## 📊 Result

- ✅ Data cleaned and standardized
- ✅ Nulls and duplicates handled
- ✅ Region and discount values corrected
- ✅ Dataset ready for analysis, visualization, or modeling

---

## ✍️ Author

**Ali Bin Asim**  
📅 *Date*: August 6, 2025

---

## 📎 License

This project is for educational and analytical purposes. No commercial use of Nike brand data is intended.
