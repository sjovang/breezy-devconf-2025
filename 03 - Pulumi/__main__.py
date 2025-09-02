"""An Azure RM Python Pulumi program"""

""" import pulumi """
from pulumi_azure_native import network, resources

environment_name = "breezy-devconf-pulumi-demo"
subnets = [
    "frontend",
    "backend"
]

resource_group = resources.ResourceGroup(
    environment_name,
    resource_group_name=f"rg-{environment_name}",
    tags={
        "Description": "Use Pulumi to deploy the demo architecture",
        "Environment": environment_name
    }
)

nat_gateway_public_ip = network.PublicIPAddress(
    f"ip-{environment_name}",
    resource_group_name=resource_group.name,
    public_ip_allocation_method=network.IPAllocationMethod.STATIC,
    sku={
        "name": "Standard"
    }
)

nat_gateway = network.NatGateway(
    f"natgw-{environment_name}",
    resource_group_name=resource_group.name,
    public_ip_addresses=[
        {
            "id": nat_gateway_public_ip.id
        }
    ],
    sku={
        "name": network.NatGatewaySkuName.STANDARD
    }
)

network_security_group = network.NetworkSecurityGroup(
    f"nsg-{environment_name}",
    resource_group_name=resource_group.name,
)

virtual_network = network.VirtualNetwork(
    f"vnet-{environment_name}",
    resource_group_name=resource_group.name,
    address_space=network.AddressSpaceArgs(
        address_prefixes=["10.44.0.0/16"],
    ),
    subnets=[
        {
            "name": f"sn-{sn}",
            "address_prefix": f"10.44.{i}.0/24",
            "nat_gateway": {
                "id": nat_gateway.id
            },
            "network_security_group": {
                "id": network_security_group.id
            },
        } for sn, i in zip(subnets, range(0, len(subnets)))
    ]
)
