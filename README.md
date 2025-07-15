# 2025-Antibodies-and-AI
Updates and new projects in the Antibody Engineering Hackahons

## Compute Resources
<div align="center"><strong>General Architecture</strong></div>

Due to the nature of docker images/container and directories, each person running AI tests will have their own docker directory in their home directory. This way they can organize their files and scripts independently of others. 

```mermaid
flowchart TD

A["<b>Jetstream2</b><br />GPU Instance<br />32 core / 117GB RAM 300GB disk"]:::gpu
  --> B[User 1]:::user --> C[Home dir]:::home --> D["RFAntibody<br/>(Docker)"]:::docker --> E[/data and code/]:::data
A --> B2[User 2]:::user --> C2[Home dir]:::home --> D2["RFAntibody<br/>(Docker)"]:::docker --> E2[/data and code/]:::data
A --> B3[User 3]:::user --> C3[Home dir]:::home --> D3["RFAntibody<br/>(Docker)"]:::docker --> E3[/data and code/]:::data

%% Style definitions
classDef gpu fill:#ffefcc,stroke:#e8b800,stroke-width:2px;
classDef user fill:#cce5ff,stroke:#3399ff,stroke-width:1.5px;
classDef home fill:#d5f5e3,stroke:#27ae60,stroke-width:1.5px;
classDef docker fill:#f9d6e2,stroke:#c0392b,stroke-width:1.5px;
classDef data fill:#fceabb,stroke:#f39c12,stroke-width:1.5px;
```





