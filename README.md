# 2025-Antibodies-and-AI
## Overview
### Goals
1. Select antibodies for modeling
2. Install and run RFAntibody
3. Evaluate designs
   
### Outcomes
1. Learn about antibody/antigen recognition (paratopes & epitopes)
2. Working with docker images and commands
3. Preparing data for RFAntibody
4. Analyzing protein structure designs
5. Learning about RFAntibody parameters specifically and AI issue in general

## Team Members
## Compute Resources
### General Architecture

Due to the nature of docker images/container and directories, each person running AI tests will have their own docker directory in their home directory. This way they can organize their files and scripts independently of others. Resources will be accessed through SSH and Jupyter Notebooks. Details regarding credentials and IP addressed will be posted to slack. 

```mermaid
flowchart TB

%% Access methods to VM
subgraph Access ["<b>Access Methods</b>"]
  direction TB
  SSH1[&emsp;&emsp;&emsp;SSH&emsp;&emsp;&emsp;]:::access
  Jup1["Jupyter Notebook"]:::access
end

%% Connect Access to next block
SSH1 ==> ACC[Credentials]:::spacer
Jup1 ==> ACC
ACC ==> VM

%% VM and user structure
subgraph VM [<b>Virtual Machine</b>]
  direction TB
  A["Jetstream2<br/>GPU Instance<br/>32 core / 117GB RAM<br/>300GB disk"]:::gpu
  A --> B[User 1]:::user --> C[Home dir]:::home --> D1["RFAntibody<br/>(Docker)"]:::docker --> E[/data and code/]:::data
  A --> B2[User 2]:::user --> C2[Home dir]:::home --> D2["RFAntibody<br/>(Docker)"]:::docker --> E2[/data and code/]:::data
  A --> B3[User 3]:::user --> C3[Home dir]:::home --> D3["RFAntibody<br/>(Docker)"]:::docker --> E3[/data and code/]:::data
end

%% Style definitions
classDef gpu fill:#ffefcc,stroke:#e8b800,stroke-width:2px;
classDef user fill:#cce5ff,stroke:#3399ff,stroke-width:1.5px;
classDef home fill:#d5f5e3,stroke:#27ae60,stroke-width:1.5px;
classDef docker fill:#f9d6e2,stroke:#c0392b,stroke-width:1.5px;
classDef data fill:#fceabb,stroke:#f39c12,stroke-width:1.5px;
classDef access fill:#e0e0ff,stroke:#8888ff,stroke-width:1px,height:50px;
classDef clear fill:#FFFFFF00,stroke:#FFFFFF00;
classDef box fill:#FFFFFF00,stroke:#333;
classDef spacer fill:transparent,stroke:transparent;
  class Access clear
  class VM box
%% links
click D1 "https://github.com/AntibodyEngineers/2025-Antibodies-and-AI/blob/main/RFAntibody-notes.md" "RFAntibody notes"
click D2 "https://github.com/AntibodyEngineers/2025-Antibodies-and-AI/blob/main/RFAntibody-notes.md" "RFAntibody notes"
click D3 "https://github.com/AntibodyEngineers/2025-Antibodies-and-AI/blob/main/RFAntibody-notes.md" "RFAntibody notes"
```


### Installation
1. Follow the steps listed at [RFAntibody GitHub page](https://github.com/RosettaCommons/RFantibody)
2. Make additions/changes specified on [RFAntibody-notes](RFAntibody-notes.md#rfantibody-issues)
3. See [Docker](RFAntibody-notes.md#docker) for example commands.







