# Breezy DevConf 2025

Demo material for my session at https://breezydevconf.fi

## Architecture

```mermaid
flowchart LR
    VirtualNetwork --> ResourceGroup
    NatGateway --> ResourceGroup 
    NetworkSecurityGroup --> ResourceGroup
    Subnet-Frontend --> VirtualNetwork
    Subnet-Backend --> VirtualNetwork
    Subnet-Frontend --> NetworkSecurityGroup
    Subnet-Backend --> NetworkSecurityGroup
    Subnet-Frontend --> NatGateway
    Subnet-Backend --> NatGateway
```