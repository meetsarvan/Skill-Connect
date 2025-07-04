# Skill Connect
<em>A DBMS project to streamline hiring by matching skilled individuals with companies — fast, fair, and smart.</em>


![RelationalSchema](https://github.com/Harmit485/Skill-Connect/blob/main/Design/Relational-model/Relational_Schema.jpeg)

---

## 📚 Project Overview

**Skill Connect** is a relational database project developed to address a simple problem with a powerful solution — connecting job seekers with companies in an efficient and structured manner.

It acts as a **centralized platform** for:
- 🧑‍💻 Users to **showcase their skills**, education, and project work.
- 🏢 Companies to **post job/internship offers**, view applicants, and directly search for ideal candidates.
- 🔁 Two-way interaction enabling direct applications and company-initiated outreach.

> “Our goal was to facilitate meaningful connections and reduce the friction in the hiring process by leveraging structured data.”

---

## 🛠️ Features

- 🧱 Fully normalized schema (up to **BCNF**)
- 📊 ER and relational diagrams
- 📄 Modular DDL, insertions, and query scripts
- 🔍 18+ SQL queries involving joins, group-by, and filters
- 🧪 Tested on **MySQL/PostgreSQL**

---

## 🧾 Folder Structure

```

Skill-Connect/
├── Data
│   └── insert_data.sql
├── DDL
│   └── create_tables.sql
├── Design
│   ├── ER-model
│   │   ├── SC-ERD.jpg
│   │   └── SC-ERD.pdf
│   └── Relational-model
│       ├── Relational_Schema.dia
│       └── Relational_Schema.jpeg
├── Normalization
│   └── proofs.pdf
├── Queries
│   └── sample_queries.sql
├── Report
│   └── final_report.pdf
└── README.md

````

---

## 🚀 Getting Started

### 1️⃣ Clone the Repo

```bash
git clone https://github.com/Harmit485/Skill-Connect.git
cd Skill-Connect
````

### 2️⃣ Create Schema & Populate Data

```sql
-- From MySQL or PostgreSQL client:
SOURCE DDL/create_tables.sql;
SOURCE data/insert_data.sql;
```

### 3️⃣ Explore the Queries

```sql
SOURCE queries/sample_queries.sql;
```

---

## 🔍 Highlight Queries

Some of our most meaningful queries include:

* ✅ **Dual-experience users**: Find users with both job *and* internship experience
* 📬 **Application status**: Show status for any user-company pair
* 🧠 **Smart skill match**: List companies requiring skills the user possesses with contract filters
* 🏙️ **State-wise stats**: Aggregate users and companies by location
* 📈 **Top skills & high-vacancy offers**

---

## 🧠 Learning & Challenges

> “Designing the ER diagram and ensuring proper normalization was a challenge, but it taught us to collaborate, iterate, and understand database theory deeply.”

Throughout the project, we:

* Improved our SQL fluency and schema design thinking
* Understood normalization (1NF → BCNF) through real implementation
* Learned to debug tricky queries and enforce referential integrity
* Gained teamwork and version control experience

---

## 👨‍🎓 Team T306

| Name            | ID        |
| --------------- | --------- |
| Harmit Khimani  | 202201231 |
| Nishank Kansara | 202201227 |
| Parth Parekh    | 202201200 |
| Meet Sarvan     | 202201218 |
| Parth Prajapati | 202201250 |

* **Course**: DBMS (Database Management Systems)
* **Institute**: DA-IICT
* **Guide**: Prof. P. M. Jat
* **TA**: Prachi Singh

---

## 📜 License

This project is submitted for academic purposes and is intended for learning, demonstration, and review only.

---
<i>“Built with collaboration, logic, and lots of coffee.” ☕</i>
