# 🚀 Polyglot Engineer Roadmap (2026)

> **Status:** Base Camp Completed. Infrastructure Live. 🛠️

This repository is my professional engineering workspace. It is built around a "Project Factory" philosophy—using a modular, Docker-first architecture to rapidly scaffold, build, and deploy full-stack applications.


---

## 🏗️ Architectural Philosophy: The "Lego" Approach
Instead of building monolithic apps, I use a decoupled system where the "Engine" (Backend) and the "Shell" (Frontend) are interchangeable parts.

### 🧩 The Core Components:
* **The Engine (Backend):** : A shared Django 5.x REST Framework template with PostgreSQL, JWT Auth, and Swagger/OpenAPI documentation.
* **The Shells (Frontends):**
    * **Base:** Standard clean-slate implementation for generic features.
    * **Minimalist:** Focused on raw logic, speed, and clean typography.
    * **Dashboard:** Tailored for data-rich administrative systems and analytics.
    * **Terminal:** A retro-CLI aesthetic for system-level and security challenges.
* **The Bridge:** A centralized Axios `apiClient` with intelligent interceptors for dual-token management (User & Admin).

---

## 🛠️ Tech Stack & Standards
| Layer | Technology   | Engineering Standard                                                          |
| :--- |:-------------|:------------------------------------------------------------------------------|
| **Frontend** | Vue 3 + Vite | Pinia state management, individual key token persistence.                     |
| **Backend** | Django 5.x   | Custom User models, DRF Serializers, SimpleJWT.                               |
| **Database** | PostgreSQL   | Relational integrity and Dockerized persistence.                              |
| **Management** | Port Mapper  | Automated unique host-port allocation via `port_registry.txt`.                |
| **DevOps** | Docker       | Multi-container orchestration automated scaffolding with `init-challenge.sh`. |

---

## 🚀 Execution Guide

### 1. Initialize a Challenge
Use the automation script to spawn a new environment:
```bash
# Usage: ./init-challenge.sh [Season] [Week] [Name]
./init-challenge.sh S1 Week-01 my-task-app
```

### 2. Boot the Infrastructure
Navigate to the created folder and start the stack:
```bash
  cd ../S1/Week-01/my-task-app
  docker compose up --build -d
```
### 3. Access Points
Your specific ports are stored in Base Camp/port_registry.txt. Standard initial offsets:
* **Frontend UI**: `http://localhost:5001`
* **API Root**: `http://localhost:8001/api/`
* **Intractive Docs**: `http://localhost:8001/api/docs/`

### 🧹 Project Management (The Janitor)
To save system RAM and manage container lifecycles, use the Janitor script located in the `Base Camp` directory.
```bash
  ./janitor.sh
```
**Available Actions**:
* 1 **START:** Wake up a specific project by its port.
* 2 **STOP:** Hibernate a project to release CPU/RAM.
* 3 **RESTART:** Refresh a project stack.
* 4 **STOP ALL:** Emergency cleanup of all running containers.

## 📅 2026 Roadmap Tracker
| Period         | Season       | Focus                                           | Standard    |
|:---------------|:-------------|:------------------------------------------------|:------------|
| **Jan**   |  **Base Camp** | Infrastructure, Boilerplates, & Janitor Scripts | ✅ COMPLETED |
| **Feb - Apr**    | **S1: Mastery**  | Full-Stack Django & Vue 3 Challenges            | 🟡 UPCOMING |
| **May - Jul**   |  **S2: Expansion**  | Systems Programming (Rust/Go) & Microservices   |     ⚪ PLANNED        |
| **Aug - Oct** |  **S3: Intelligence**  | AI Integration & Data Engineering               |  ⚪ PLANNED           |
| **Nov - Dec**     | **S4: Scale**       | Cloud-Native Deployment & K8s                   |    ⚪ PLANNED         |

---
> ### 🛡️ Engineering Habits Implemented
>
 >> * Live Observability: Heartbeat monitors in every shell to track API health.
 >> * Clean Auth Flow: Automated silent refreshes and request-level token injection.
 >> * Container Isolation: Zero dependency conflicts by running all shells in Alpine-based Node containers.

---
# **"The best way to predict the future is to build it."** _Maintained by_ [Ranzo]
