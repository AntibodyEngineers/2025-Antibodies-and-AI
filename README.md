# 2025-Antibodies-and-AI
July, 2025

## Overview
### Goals
1. Learn aobut AI and different ways to use it
2. Select antibodies for modeling
3. Install and run RFAntibody and possible alternatives
4. Evaluate designs

See the [to do list](RFAntibody-ToDo.md) for specific items needed for evaluation.  
   
### Outcomes
1. Learn about antibody/antigen recognition (paratopes & epitopes)
2. Gain experience working with docker images and commands
3. Work with pdb files to prepare data for RFAntibody
4. Evaluate designs by analyzing generated protein sequences and structures
5. Develop an understanding of RFAntibody parameters specifically, data science used in evaluation, and AI issues in general

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
1. Read the [RFAntibody GitHub page](https://github.com/RosettaCommons/RFantibody) page. The steps and modications, closely follow this. 
2. Walk through the steps, including modifications, in [RFAntibody-notes](RFAntibody-notes.md#rfantibody-installation)
3. See [Docker](RFAntibody-notes.md#docker) for example docker commands.







