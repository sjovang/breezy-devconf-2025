# Breezy DevConf 2025

Demo material for my session at https://breezydevconf.fi

## Architecture

```mermaid
classDiagram
    ResourceGroup
    VirtualNetwork <-- ResourceGroup
    NatGateway <|-- VirtualNetwork
    NatGateway <|-- ResourceGroup
    Subnet-Frontend <|-- VirtualNetwork
    Subnet-Backend <|-- VirtualNetwork
    Subnet-Frontend <|-- NetworkSecurityGroup
    Subnet-Backend <|-- NetworkSecurityGroup
```