# 🛠️ Base Camp: Internal Technical Manual
> **Focus:** Rapid scaffolding and resource management for the 2026 Roadmap.

This directory contains the automation scripts and templates used to power the **Project Factory**.

---

## 🏗️ The Project Factory Scripts

### 1. `init-challenge.sh` (or `.bat`)
The primary orchestrator. It assembles a unique, isolated stack for each weekly challenge.
* **Port Mapping:** Automatically calculates a unique port offset from `port_registry.txt` to prevent collisions.
* **Assembly:** Syncs the chosen Frontend Shell with the Shared Backend and Infrastructure.
* **Personalization:** Updates the app name in `index.html` and `App.vue` based on your project choice.

### 2. `janitor.sh`
The resource manager. Use this to keep your machine lean by managing container lifecycles.
* **Hibernation:** Uses `docker compose stop` to clear RAM/CPU while keeping data intact.
* **Targeted Control:** Start, Stop, or Restart specific projects using their assigned port number.
* **Emergency Clear:** One command to shut down every registered project in the lab.

---

## 🧩 Frontend Shells
When running the init script, you will choose one of four "Shells":
1. **Base:** Standard implementation with full Tailwind and Auth integration.
2. **Dashboard:** Data-rich interface with sidebar navigation and status heartbeats.
3. **Terminal:** Retro-CLI aesthetic for system-level and security challenges.
4. **Minimalist:** High-speed, logic-first shell for rapid prototyping.

---

## 🧠 Knowledge Base & Resources
* **[Service Layer Pattern](./knowledge-base/service-layer.md):** The standard for keeping your backend clean.
* **[Django Pro Patterns](./knowledge-base/django-pro.md):** Custom Managers, QuerySets, and Signals.
* **[Vue 3 Performance](./knowledge-base/vue-tips.md):** Composables and Pinia strategies.
* **[Postgres Optimization](./knowledge-base/sql-cheatsheet.md):** Indexes and query diagnostics.

---


# **"System Ready. Calibrating for February 1st."** _Maintained by_ [Ranzo]