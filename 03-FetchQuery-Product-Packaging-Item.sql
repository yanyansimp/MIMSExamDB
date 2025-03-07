USE ProductPackagingDb;

-- Query to Retrieve a Product and All Its Packaging Levels
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

-- Query to Find Packaging Containing a Specific Item
SELECT p.PackagingID, p.PackagingType, i.ItemName 
FROM Packaging p
JOIN PackagingItems pi ON p.PackagingID = pi.PackagingID
JOIN Items i ON pi.ItemID = i.ItemID
WHERE i.ItemName = 'Screwdriver';