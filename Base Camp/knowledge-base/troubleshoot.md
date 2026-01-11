# 🧹 Troubleshooting & Common Chores
> **Knowledge Base | Homelab Maintenance**

This guide covers the "Common Fixes" for the Project Factory infrastructure.

---

## ⚓ 1. Port Collisions
**The Error:** `Bind for 0.0.0.0:[PORT] failed: port is already allocated.`
- **Reason:** You are trying to start a project on a port that is already in use by another container or a system process.
- **The Fix:**
  1. Check `Base Camp/port_registry.txt` to confirm which project owns that port.
  2. Run `./janitor.sh` and use **Option 2 (Stop)** on the conflicting project.
  3. If the port is stuck, run `docker ps` to find the hidden container and `docker stop <id>` it.

## 🧠 2. RAM & CPU Bloat
**The Symptom:** Laptop fan is loud, and VS Code is lagging.
- **The Fix:**
  1. Open `./janitor.sh`.
  2. Use **Option 5 (STOP ALL)**. This hibernates every project.
  3. Manually start ONLY the one project you are working on right now.

## 💾 3. Database Connection Issues
**The Symptom:** Frontend shows "Offline" dot or Backend logs say `Is the server running on host "db" ...?`
- **The Fix:**
  1. Check if the `db` container is running: `docker compose ps`.
  2. Ensure your `.env` file in the project root has the correct `POSTGRES_USER` and `POSTGRES_PASSWORD`.
  3. If you changed the DB schema and it's crashing, run `./janitor.sh` **Option 4 (Destroy)** to wipe the volumes and start fresh with `up --build`.

## 🔌 4. Docker "Ghost" Containers
**The Symptom:** You deleted a project folder, but Docker still thinks it's there.
- **The Fix:** 1. Run `docker system prune` (This removes all stopped containers and unused networks).
  2. Use `./janitor.sh` **Option 7 (Registry Cleanup)** to remove the entry from your history.

---

## 💡 Pro-Tip: The "Golden Restart"
If everything feels broken:
1. `./janitor.sh` -> Stop All.
2. `docker system prune -f`
3. Restart your laptop (clears the Docker Desktop networking bridge).