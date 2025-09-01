#!/bin/zsh
az stack sub create \
    --name 'breezy-devconf-demo' \
    --location 'swedencentral' \
    --template-file 'main.bicep' \
    --action-on-unmanage 'deleteAll' \
    --deny-settings-mode 'none'