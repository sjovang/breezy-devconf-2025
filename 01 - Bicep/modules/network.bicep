@description('IP address space for Virtual Network. Simplified from list to string for demo purposes')
param addressPrefix string

@description('The name of the environment')
param environmentName string

@description('Tags applied to resources')
param tags object = {}

@description('Use the cidrSubnet function to generate address prefixes for each subnet. This ensures that each subnet is a valid CIDR block within the virtual network.')
var subnets array = [for i in range(0,2): cidrSubnet(addressPrefix, 24, i)]

@description('The resource ID of the virtual network')
output virtualNetworkId string = virtualNetwork.outputs.resourceId

@description('The resource ID for the Frontend subnet')
output frontendSubnetId string = virtualNetwork.outputs.subnetResourceIds[0]

@description('The resource ID for the Backend subnet')
output backendSubnetId string = virtualNetwork.outputs.subnetResourceIds[1]

@description('Use NAT Gateway to provide outbound internet access in subnets')
module natGateway 'br/public:avm/res/network/nat-gateway:1.4.0' = {
  params: {
    availabilityZone: -1
    name: 'natgw-${environmentName}'
    publicIpResourceIds: [
      natGatewayPublicIp.outputs.resourceId
    ]
    tags: tags
  }
}

@description('We can either assign a single public IP or a prefix to the NAT Gateway')
module natGatewayPublicIp 'br/public:avm/res/network/public-ip-address:0.9.0' = {
  params: {
    name: 'pip-${environmentName}-nat-gateway'
    tags: tags
  }
}

@description('Azure policy in Landing Zones architecture typically require subnets to be associated with a network security group')
module networkSecurityGroup 'br/public:avm/res/network/network-security-group:0.5.1' = {
  params: {
    name: 'nsg-${environmentName}'
    tags: tags
  }
}

@description('Virtual Network with two subnets')
module virtualNetwork 'br/public:avm/res/network/virtual-network:0.7.0' = {
  params: {
    addressPrefixes: [addressPrefix]
    name: 'vnet-${environmentName}'
    subnets: [
      {
        addressPrefix: subnets[0]
        name: 'sn-${environmentName}-frontend'
        natGatewayResourceId: natGateway.outputs.resourceId
        networkSecurityGroupResourceId: networkSecurityGroup.outputs.resourceId
      }
      {
        addressPrefix: subnets[1]
        name: 'sn-${environmentName}-backend'
        natGatewayResourceId: natGateway.outputs.resourceId
        networkSecurityGroupResourceId: networkSecurityGroup.outputs.resourceId
      }
    ]
    tags: tags
  }
}
