CREATE DATABASE AshishsPieShop;
GO

USE AshishsPieShop;
GO

CREATE TABLE Pie (
    PieId INT PRIMARY KEY IDENTITY(1,1), -- Auto-incrementing primary key
    Name NVARCHAR(100) NOT NULL, -- Assumes max length of 100 characters for Name
    ShortDescription NVARCHAR(255), -- Optional short description with a max length
    LongDescription NVARCHAR(MAX), -- Long description with no predefined length limit
    AllergyInformation NVARCHAR(MAX), -- Allergy information with no length limit
    Price DECIMAL(18, 2) NOT NULL, -- Decimal with 2 decimal places
    ImageUrl NVARCHAR(2083), -- Standard max length for URLs
    ImageThumbnailUrl NVARCHAR(2083), -- Standard max length for URLs
    IsPieOfTheWeek BIT NOT NULL DEFAULT 0, -- Boolean represented as BIT
    InStock BIT NOT NULL DEFAULT 1, -- Boolean with a default of "in stock"
    CategoryId INT NOT NULL, -- Foreign key reference
    Notes NVARCHAR(MAX), -- Optional notes field
    CONSTRAINT FK_Pie_Category FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId)
);
GO

CREATE TABLE Category (
    CategoryId INT PRIMARY KEY IDENTITY(1,1), -- Auto-incrementing primary key
    CategoryName NVARCHAR(100) NOT NULL, -- Assumes max length of 100 characters
    Description NVARCHAR(MAX) -- Optional description with no predefined length limit
);
GO

CREATE TABLE ShoppingCartItem (
    ShoppingCartItemId INT PRIMARY KEY IDENTITY(1,1), -- Auto-incrementing primary key
    PieId INT NOT NULL, -- Foreign key to the Pie table
    Amount INT NOT NULL CHECK (Amount > 0), -- Must be a positive integer
    ShoppingCartId NVARCHAR(50) NOT NULL, -- Assumes a max length of 50 characters
    CONSTRAINT FK_ShoppingCartItem_Pie FOREIGN KEY (PieId) REFERENCES Pie(PieId)
);
GO

CREATE TABLE [Order] (
    OrderId INT PRIMARY KEY IDENTITY(1,1), -- Auto-incrementing primary key
    FirstName NVARCHAR(50) NOT NULL, -- Required field with max length of 50
    LastName NVARCHAR(50) NOT NULL, -- Required field with max length of 50
    AddressLine1 NVARCHAR(100) NOT NULL, -- Required field with max length of 100
    AddressLine2 NVARCHAR(100), -- Optional field with max length of 100
    ZipCode NVARCHAR(10) NOT NULL, -- Required field with max length of 10
    City NVARCHAR(50) NOT NULL, -- Required field with max length of 50
    State NVARCHAR(10), -- Optional field with max length of 10
    Country NVARCHAR(50) NOT NULL, -- Required field with max length of 50
    PhoneNumber NVARCHAR(25) NOT NULL, -- Required field with max length of 25
    Email NVARCHAR(50) NOT NULL, -- Required field with max length of 50
    OrderTotal DECIMAL(18, 2) NOT NULL DEFAULT 0.00, -- Total amount with a default value
    OrderPlaced DATETIME NOT NULL DEFAULT GETDATE() -- Timestamp of when the order was placed
);
GO

CREATE TABLE OrderDetail (
    OrderDetailId INT PRIMARY KEY IDENTITY(1,1), -- Auto-incrementing primary key
    OrderId INT NOT NULL, -- Foreign key referencing Order
    PieId INT NOT NULL, -- Foreign key referencing Pie
    Amount INT NOT NULL CHECK (Amount > 0), -- Must be a positive integer
    Price DECIMAL(18, 2) NOT NULL, -- Price per unit with 2 decimal places
    CONSTRAINT FK_OrderDetail_Order FOREIGN KEY (OrderId) REFERENCES [Order](OrderId) ON DELETE CASCADE,
    CONSTRAINT FK_OrderDetail_Pie FOREIGN KEY (PieId) REFERENCES Pie(PieId) ON DELETE CASCADE
);
GO
