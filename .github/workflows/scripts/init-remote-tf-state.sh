#!/bin/bash

set -e

# Create the resource group
if  ( `az group exists --resource-group $COMMON_RESOURCE_GROUP` == "true" );
then
    echo "Resource group $COMMON_RESOURCE_GROUP exists..."
else
    echo "Creating $COMMON_RESOURCE_GROUP resource group..."
    az group create -n $COMMON_RESOURCE_GROUP -l $REGION
    echo "Resource group $COMMON_RESOURCE_GROUP created."
fi