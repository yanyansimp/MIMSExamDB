# **Product Packaging Database - README**

## **1. Overview**

This database is designed to store product information with a hierarchical packaging structure. Each **product** can have **multiple packaging types**, and packaging can contain **other packaging** or **items**.

## **2. Database Schema (Entities & Relationships)**

```plaintext
+--------------+      +-----------------------+      +--------------+      +---------------------+
|   Products   |      |  Packaging            |      |    Items     |      |    PackagingItems   |
+--------------+      +-----------------------+      +--------------+      +---------------------+
| ProductID PK |<-----| PackagingID PK        |      | ItemID PK    |      | PackagingItemID  PK |
| ProductName  |  1:M | ProductID FK          |      | ItemName     |      | PackagingID      FK |
+--------------+      | ParentPackagingID FK  |      +--------------+      | ItemID           FK |
                      | PackagingType         |                            +---------------------+
                      +-----------------------+
```

## **3. Relationship Breakdown**

1. **Product → Packaging (One-to-Many)**

   - A **Product** can have **multiple Packaging** (1:M).
   - Each **Packaging** belongs to **one Product**.

2. **Packaging → Packaging (Self-Referencing, One-to-Many)**

   - A **Packaging** can contain **another Packaging** (nested structure).
   - This is achieved using **ParentPackagingID**, allowing hierarchical nesting.

3. **Packaging → Items (Many-to-Many via PackagingItems)**
   - A **Packaging** can contain **multiple Items** (M:M).
   - An **Item** can be placed inside **multiple Packaging**.
   - This relationship is resolved using the **PackagingItems** junction table.

## **4. Sample Queries**

### **Retrieve a Product and All Its Packaging Levels**

```sql
WITH PackagingHierarchy AS (
    SELECT p.PackagingID, p.ProductID, p.ParentPackagingID, p.PackagingType, 0 AS Level
    FROM Packaging p
    WHERE p.ParentPackagingID IS NULL
    UNION ALL
    SELECT p.PackagingID, p.ProductID, p.ParentPackagingID, p.PackagingType, ph.Level + 1
    FROM Packaging p
    INNER JOIN PackagingHierarchy ph ON p.ParentPackagingID = ph.PackagingID
)
SELECT * FROM PackagingHierarchy ORDER BY Level;
```

### **Find Packaging That Contains a Specific Item**

```sql
SELECT p.PackagingID, p.PackagingType, i.ItemName
FROM Packaging p
JOIN PackagingItems pi ON p.PackagingID = pi.PackagingID
JOIN Items i ON pi.ItemID = i.ItemID
WHERE i.ItemName = 'Screwdriver';
```

**5. Indexing Strategy for Performance Optimization**

- **Primary Keys:** Ensure efficient lookups for `ProductID`, `PackagingID`, and `ItemID`.
- **Foreign Keys:** Index `ProductID` in **Packaging** and `PackagingID` in **PackagingItems** for quick joins.
- **Recursive Queries:** Optimize hierarchical packaging queries using indexed `ParentPackagingID`.
