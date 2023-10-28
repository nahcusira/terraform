CREATE TABLE [dbo].[Products](
	[ProductID] [int] NULL,
	[ProductName] [varchar](1000) NULL,
	[Quantity] [int] NULL,
	[ProductImage] [varchar](1000) NULL
) ON [PRIMARY]

INSERT INTO Products(ProductID,ProductName,Quantity,ProductImage) VALUES (1,'Mobile',100,'https://${storage_account_name}.blob.core.windows.net/${app_container_name}/Mobile.jpg')

INSERT INTO Products(ProductID,ProductName,Quantity,ProductImage) VALUES (2,'Laptop',200,'https://${storage_account_name}.blob.core.windows.net/${app_container_name}/Laptop.jpg')

INSERT INTO Products(ProductID,ProductName,Quantity,ProductImage) VALUES (3,'Tabs',300,'https://${storage_account_name}.blob.core.windows.net/${app_container_name}/Tab.jpg')

     	