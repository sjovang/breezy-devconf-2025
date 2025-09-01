targetScope = 'subscription'

@description('The name of the environment')
param environmentName string = 'breezy-devconf-bicep-demo'

@description('The timestamp of the last deployment update. This can only be set as a runtime param and not a var. Users should not modify this value.')
param lastDeploymentUpdate string = utcNow('d')

@description('IP address space for Virtual Network. Simplified from list to string for demo purposes')
param virtualNetworkAddressPrefix string = '10.42.0.0/16'

@description('Get the UPN of the current user and use in tags. Fallback to objectID if deployed by a service principal')
var deployedBy string = deployer().userPrincipalName != '' ? deployer().userPrincipalName : deployer().objectId

@description('Tags applied to resource group and resources')
var tags object = {
  DeployedBy: deployedBy
  Description: 'Small demo to showcase capabilities of Bicep deployment stacks'
  Environment: environmentName
  LastDeploymentUpdate: lastDeploymentUpdate
}

resource resourceGroup 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: 'rg-${environmentName}'
  location: deployment().location
  tags: tags
}

module network 'modules/network.bicep' = {
  scope: resourceGroup
  name: '${deployment().name}-network'
  params: {
    addressPrefix: virtualNetworkAddressPrefix
    environmentName: environmentName
    tags: tags
  }
}
