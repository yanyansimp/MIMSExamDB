USE ProductPackagingDb;

-- Sample Data Insertion
INSERT INTO Products (ProductName) VALUES ('Self Adjusting Table');

-- Packaging Structure
INSERT INTO Packaging (ProductID, ParentPackagingID, PackagingType) VALUES (1, NULL, 'Box');   -- Main Box
INSERT INTO Packaging (ProductID, ParentPackagingID, PackagingType) VALUES (1, 1, 'Box');     -- Nested Box
INSERT INTO Packaging (ProductID, ParentPackagingID, PackagingType) VALUES (1, 1, 'Box');     -- Another Nested Box
INSERT INTO Packaging (ProductID, ParentPackagingID, PackagingType) VALUES (1, 3, 'Packet');  -- Packet inside Box
INSERT INTO Packaging (ProductID, ParentPackagingID, PackagingType) VALUES (1, 3, 'Packet');  -- Another Packet

-- Items
INSERT INTO Items (ItemName) VALUES ('Table top'), ('Table legs'), ('Screwdriver'), ('Screws');

-- Assign Items to Packaging
INSERT INTO PackagingItems (PackagingID, ItemID) VALUES (2, 1); -- Table top inside Box
INSERT INTO PackagingItems (PackagingID, ItemID) VALUES (3, 2); -- Table legs inside Box
INSERT INTO PackagingItems (PackagingID, ItemID) VALUES (4, 3); -- Screwdriver inside Packet
INSERT INTO PackagingItems (PackagingID, ItemID) VALUES (5, 4); -- Screws inside Packet