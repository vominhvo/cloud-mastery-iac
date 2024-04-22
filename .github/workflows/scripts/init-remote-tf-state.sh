#!/bin/bash

# Create the resource group
if  ( `az group exists --resource-group $RESOURCE_GROUP` == "true" );
then
    echo "Resource group $RESOURCE_GROUP exists..."
else
    echo "Creating $RESOURCE_GROUP resource group..."
    az group create -n $RESOURCE_GROUP -l $REGION
    echo "Resource group $RESOURCE_GROUP created."
fi