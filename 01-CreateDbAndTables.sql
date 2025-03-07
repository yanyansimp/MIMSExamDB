-- Create Database
CREATE DATABASE ProductPackagingDb;
GO
USE ProductPackagingDb;
GO

-- Create Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(255) NOT NULL
);

-- Create Packaging Table (Self-Referencing for Nested Structure)
CREATE TABLE Packaging (
    PackagingID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT NOT NULL,
    ParentPackagingID INT NULL, -- Self-referencing for nesting
    PackagingType NVARCHAR(50) NOT NULL, -- e.g., Box, Packet
    CONSTRAINT FK_Packaging_Product FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    CONSTRAINT FK_Packaging_Parent FOREIGN KEY (ParentPackagingID) REFERENCES Packaging(PackagingID)
);

-- Create Items Table
CREATE TABLE Items (
    ItemID INT PRIMARY KEY IDENTITY(1,1),
    ItemName NVARCHAR(255) NOT NULL
);

-- Create PackagingItems Junction Table (Many-to-Many Relationship)
CREATE TABLE PackagingItems (
    PackagingItemID INT PRIMARY KEY IDENTITY(1,1),
    PackagingID INT NOT NULL,
    ItemID INT NOT NULL,
    CONSTRAINT FK_PackagingItems_Packaging FOREIGN KEY (PackagingID) REFERENCES Packaging(PackagingID),
    CONSTRAINT FK_PackagingItems_Item FOREIGN KEY (ItemID) REFERENCES Items(ItemID)
);




