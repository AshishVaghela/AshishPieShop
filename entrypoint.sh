#!/bin/bash

echo "Waiting for SQL Server to start..."
sleep 20

echo "Checking if database exists..."
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "MySQLServer1!" -Q "SELECT name FROM sys.databases WHERE name = 'AshishsPieShop'" | grep AshishsPieShop > /dev/null
if [ $? -ne 0 ]; then
  echo "Database does not exist. Running init.sql..."
  /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "MySQLServer1!" -i /app/init.sql
else
  echo "Database already exists."
fi

echo "Starting the web app..."
dotnet AshishPieShop.dll
