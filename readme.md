# 🚀 Automated VPC Infrastructure Setup using Terraform

This project automates the creation of a complete network architecture in AWS using Terraform. It includes VPC creation, subnet provisioning, route tables, NAT gateway setup, and peering configurations — all implemented as Infrastructure as Code (IaC).

---

## 📦 What This Automation Covers

### 1. VPC & Network Resources
- Created a custom **VPC** with defined CIDR block.
- Attached an **Internet Gateway** to allow public internet access.
- Allocated an **Elastic IP** for NAT gateway.

### 2. Subnet Provisioning
- Created **three subnets**:
  - **Public Subnet** (for internet-facing resources)
  - **Private Subnet** (for internal applications)
  - **Database Subnet** (isolated for RDS/databases)
- Defined specific **CIDR ranges** for each subnet.

### 3. NAT Gateway
- Created a **NAT Gateway** for outbound internet access from private and database subnets.
- Attached NAT gateway to the **Elastic IP** and the VPC.

### 4. Routing Configuration
- Created **three route tables**:
  - Public Route Table
  - Private Route Table
  - Database Route Table
- Defined routes:
  - Public subnet routes through **Internet Gateway**.
  - Private and database subnets route through **NAT Gateway** for outbound access.

### 5. Subnet-Route Table Association
- **Associated** the respective route tables to:
  - Public subnet → Public route table
  - Private subnet → Private route table
  - Database subnet → Database route table

### 6. VPC Peering
- Established a **VPC Peering Connection** with the **default VPC**.
- Created routes in all route tables (public, private, database) to route traffic to the peer VPC.

---

## 📁 Technologies Used
- Terraform (Infrastructure as Code)
- AWS VPC, Subnets, NAT Gateway, IGW, EIP, Route Tables, VPC Peering

---

## 🛡 Benefits
- Fully automated and reproducible infrastructure
- Isolated network tiers for improved security
- Scalable design for cloud-native applications

---

## 🔧 How to Use
1. Clone this repository
2. Modify `variables.tf` for CIDR blocks and region
3. Run the following:
   terraform init
   terraform plan
   terraform apply
