## Network Architecture Diagram

```mermaid
graph TD
    subgraph RG[Resource Group: tdupoiron-actions-demovnet]
        subgraph VNET[Virtual Network: tdupoiron-actions-vnet]
            NSG[Network Security Group<br/>tdupoiron-actions-nsg]
            S1[Subnet: tdupoiron-actions-subnet<br/>10.0.2.0/24]
            S2[Subnet: tdupoiron-mysql-subnet<br/>10.0.1.0/24]
            NIC[Network Interface<br/>GHA-bb1b-be55-9c]
        end
        DNS[Private DNS Zone<br/>tdupoiron-mysql.private.mysql.database.azure.com]
        VNETLINK[Virtual Network Link]
    end

    NSG --> S1 & S2
    NIC --> S1
    VNET --> VNETLINK
    DNS --> VNETLINK

    classDef vnet fill:#f9f,stroke:#333,stroke-width:2px;
    classDef subnet fill:#bbf,stroke:#333,stroke-width:1px;
    classDef nsg fill:#fbb,stroke:#333,stroke-width:1px;
    classDef dns fill:#bfb,stroke:#333,stroke-width:1px;
    
    class VNET vnet;
    class S1,S2 subnet;
    class NSG nsg;
    class DNS dns;
```

### Architecture Details

1. **Virtual Network Configuration**:
   - Name: `tdupoiron-actions-vnet`
   - Location: France Central
   - Address Space: `10.0.0.0/16`

2. **Subnets**:
   - `tdupoiron-actions-subnet`: `10.0.2.0/24`
   - `tdupoiron-mysql-subnet`: `10.0.1.0/24`
   Both subnets have private endpoints disabled.

3. **Network Security**:
   - Network Security Group: `tdupoiron-actions-nsg`
   - Protects both subnets

4. **Networking Components**:
   - Network Interface: `GHA-bb1b-be55-9c`
   - Connected to the actions subnet

5. **DNS Configuration**:
   - Private DNS Zone: `tdupoiron-mysql.private.mysql.database.azure.com`
   - Connected to the VNet through a Virtual Network Link

This architecture appears to be set up for a GitHub Actions environment with potential MySQL database connectivity, though no active MySQL database connections were found at the time of analysis.
