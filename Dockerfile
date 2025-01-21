#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
USER app
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["AshishPieShop.csproj", "."]
RUN dotnet restore "./AshishPieShop.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "./AshishPieShop.csproj" -c $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "./AshishPieShop.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "AshishPieShop.dll"]

#########

# Use the official .NET SDK image to build the app
#FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
#WORKDIR /app.
#
## Copy project files and restore dependencies
#COPY *.csproj ./
#RUN dotnet restore
#
## Copy the rest of the source code and build the app
#COPY . .
#RUN dotnet publish -c Release -o out
#
## Use the official .NET runtime image for running the app
#FROM mcr.microsoft.com/dotnet/aspnet:8.0
#WORKDIR /app
#COPY --from=build /app/out .
#
## Copy the database initialization script
#COPY init.sql /app/init.sql
#
## Install SQL Server tools for running the init.sql script
#RUN apt-get update && \
#    apt-get install -y curl gnupg && \
#    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
#    curl https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2022.list | tee /etc/apt/sources.list.d/mssql-server.list && \
#    apt-get update && \
#    apt-get install -y mssql-tools unixodbc-dev && \
#    rm -rf /var/lib/apt/lists/*
#
## Expose ports for the app
#EXPOSE 8080
#EXPOSE 8081
#
## Startup script to initialize the database and start the web app
#COPY entrypoint.sh /app/entrypoint.sh
#RUN chmod +x /app/entrypoint.sh
#
#ENTRYPOINT ["/app/entrypoint.sh"]
