<h1 align="center">
  <img src="https://raw.githubusercontent.com/Kilo7alm/7alm/main/banner.png" width="100%" alt="7alm Banner" />
</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Android-12-orange?style=for-the-badge" alt="Android 12" />
  <img src="https://img.shields.io/badge/Device-j7elte-blue?style=for-the-badge" alt="j7elte" />
  <img src="https://img.shields.io/badge/Module-v1.0-ff69b4?style=for-the-badge" alt="v1.0" />
  <img src="https://img.shields.io/badge/crDroid-Ready-green?style=for-the-badge" alt="crDroid" />
</p>

<hr />

# ⚡ 7alm — Performance & Smoothness Module

> **For Samsung Galaxy J7 (j7elte)** running **crDroid Android 12**  
> Tune CPU, GPU, IO, memory and animation for a buttery-smooth daily driver.

---

## ✨ Features

<div align="center">

| ⚡ CPU & GPU | 💾 Memory | 🖥 System |
|---|---|---|
| schedutil / interactive governor | Balanced swappiness (20) | SurfaceFlinger touch timer (10ms) |
| 30% min freq boost | Dirty ratio tuning (20/10) | display_smooth_level=3 |
| GPU floor at 50% max | Cache pressure (100) | FIFO UI pipeline |
| Input boost (touch) | Page cluster (3) | Animation scale reduced |
| IO scheduler: mq-deadline | KSM disabled | Dalvik heap tuned |

</div>

---

## 📦 What's Inside

```bash
📁 7alm/
├── 📄 module.prop          # Module identity & metadata
├── 📄 module.yaml           # Feature manifest
├── 📄 system.prop           # System props (UI, surface, dalvik)
├── 📄 customize.sh          # Flash UI & permissions
├── 📄 post-fs-data.sh       # Boot-time tuning (CPU/GPU/IO/VM)
└── 📄 service.sh            # Post-boot tweaks (animation, scheduler)
```

---

## 🚀 Installation

```bash
# 1. Ensure Magisk is installed (v26+ recommended)
# 2. Download 7alm-v1.0.zip
# 3. Flash via Magisk → Install → Select ZIP → Reboot ✅
```

> ⚠️ **Only for `j7elte`**. Flashing on other devices can cause instability.

---

## 📥 Download

<p align="center">
  <a href="#"><img src="https://img.shields.io/badge/Download-7alm_v1.0-238636?style=for-the-badge" alt="Download" /></a>
  <a href="#"><img src="https://img.shields.io/badge/Telegram-Join-0088cc?style=for-the-badge" alt="Telegram" /></a>
</p>

---

## 📋 Compatibility

| Spec | Detail |
|---|---|
| **Device** | Samsung Galaxy J7 (`j7elte`) |
| **ROM** | crDroid Android 12 |
| **Magisk** | v26+ recommended |
| **Root** | Magisk Systemless |

---

## 🔒 Credits

- **Author**: Kilo
- **Module**: 7alm v1.0
- **Community**: crDroid / Magisk / XDA

> Made with ❤️ for smoother J7 days.

---

## ⭐ Support

Star ⭐ the repo, share with friends, or open an issue if you run into anything.

```
<p align="right">
  <img src="https://img.shields.io/github/stars/Kilo7alm/7alm?style=social" alt="Stars" />
</p>
```