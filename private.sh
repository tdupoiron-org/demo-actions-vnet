#!/bin/bash

# This script creates the following resources in the specified subscription:
# - Subnet in an existing virtual network
# - MySQL Flexible Server in the created subnet
#
# It assumes the resource group and virtual network already exist.
# The script also configures the subnet with Microsoft.SQL service endpoints.

# stop on failure
set -e

#set environment
export AZURE_LOCATION=francecentral
export SUBSCRIPTION_ID=e4bf7af2-8190-4628-90e4-1bc20135d14c
export RESOURCE_GROUP_NAME=tdupoiron-actions-demovnet-2
export VNET_NAME=tdupoiron-actions-vnet-2
export SUBNET_NAME=tdupoiron-mysql-subnet-2
export MYSQL_RESOURCE_NAME=tdupoiron-mysql-2

# These are the default values. You can adjust your address and subnet prefixes.
export ADDRESS_PREFIX=10.0.0.0/16
export SUBNET_PREFIX=10.0.1.0/24

echo
echo login to Azure
. az login --output none

echo
echo set account context $SUBSCRIPTION_ID
. az account set --subscription $SUBSCRIPTION_ID

echo
echo Create subnet $SUBNET_NAME
. az network vnet subnet create \
    --name $SUBNET_NAME \
    --resource-group $RESOURCE_GROUP_NAME \
    --vnet-name $VNET_NAME \
    --address-prefix $SUBNET_PREFIX \
    --service-endpoints Microsoft.SQL

echo
echo Create MySQL database
. az mysql flexible-server create --name $MYSQL_RESOURCE_NAME \
    --resource-group $RESOURCE_GROUP_NAME \
    --location $AZURE_LOCATION \
    --admin-user mysqladmin \
    --admin-password "MySecurePassword123" \
    --sku-name Standard_B1ms \
    --tier Burstable \
    --storage-size 32 \
    --version 8.0.21 \
    --vnet $VNET_NAME \
    --subnet $SUBNET_NAME \

