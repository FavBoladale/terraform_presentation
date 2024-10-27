# Configure the Azure provider
provider "azurerm" {
  features {}
}

# Use the existing resource group
data "azurerm_resource_group" "sqlproject" {
  name = "sqlproject"
}

# Declare the Azure SQL Server resource (azurerm_mssql_server)
resource "azurerm_mssql_server" "sql_server" {
  name                         = "trf-mssql-server"                # server name
  resource_group_name          = data.azurerm_resource_group.sqlproject.name
  location                     = "South Africa North"              
  version                      = "12.0"                           # Version for Azure SQL
  administrator_login          = "  "                       
  administrator_login_password = "  "                   

  tags = {
    environment = "dev"
  }
}

# Declare the Azure SQL Database resource (azurerm_mssql_database)
resource "azurerm_mssql_database" "sql_database" {
  name        = "trf-mssql-database"                               # Database name
  server_id   = azurerm_mssql_server.sql_server.id                
  sku_name    = "Basic"                                          
  
  tags = {
    environment = "dev"
  }
}
