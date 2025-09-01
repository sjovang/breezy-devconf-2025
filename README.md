# Breezy DevConf 2025

Demo material for my session at https://breezydevconf.fi

## Architecture

```mermaid
flowchart LR
    ResourceGroup --> VirtualNetwork
    ResourceGroup --> NatGateway
    ResourceGroup --> NetworkSecurityGroup
    VirtualNetwork --> Subnet-Frontend
    VirtualNetwork --> Subnet-Backend
    Subnet-Frontend --> NetworkSecurityGroup
    Subnet-Backend --> NetworkSecurityGroup 
```