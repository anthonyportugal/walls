# Walls

<p align="center">
  <a href="https://kernel.org"><img src="https://img.shields.io/badge/OS-Linux-FCC624?style=flat-square&logo=linux&logoColor=black" alt="Linux"></a>
  <a href="https://developers.google.com/speed/webp"><img src="https://img.shields.io/badge/Format-WebP_Optimized-green?style=flat-square" alt="WebP"></a>
  <a href="https://github.com/catppuccin/catppuccin"><img src="https://img.shields.io/badge/Palette-Catppuccin_Mocha-f5c2e7?style=flat-square&logo=catppuccin&logoColor=1e1e2e" alt="Theme"></a>
  <a href="https://www.gnu.org/software/bash/"><img src="https://img.shields.io/badge/CLI-Bash-4EAA25?style=flat-square&logo=gnu-bash&logoColor=white" alt="Bash CLI"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square" alt="License"></a>
</p>

Curated collection of high-resolution, lightweight wallpapers optimized for minimalist Linux setups, tiling window managers, and the [Catppuccin Mocha](https://github.com/catppuccin/catppuccin) color palette.

> [!TIP]
> Designed to integrate seamlessly with [anthonyportugal/dotfiles](https://github.com/anthonyportugal/dotfiles) (both MangoWM and BSPWM sessions) or function as a completely standalone wallpaper manager.

---

## ✨ Key Highlights

- ⚡ **Pure WebP Storage:** Zero uncompressed PNG/JPG bloat; 50–80% smaller clone size with reduced memory consumption in wallpaper daemons.
- 🛠️ **Standalone Management CLI:** Seamlessly add, auto-convert, list, link, and diagnose wallpapers via `bin/walls`.
- 🎛️ **Dual-WM Compatibility:** Plug-and-play integration with `swaybg` (Wayland / MangoWM) and `feh` (X11 / BSPWM).
- 🖼️ **Automated Gallery:** Instant Markdown preview table generator keeping the README clean, responsive, and up-to-date.

---

## 🛠️ Management CLI (`bin/walls`)

The repository includes a standalone CLI to manage the collection and system integration:

```bash
# Link wallpapers to ~/.local/share/wallpapers and command to ~/.local/bin/walls
./bin/walls link

# Check repository health, formats, and link status
walls doctor

# List all wallpapers with resolution and file size
walls list

# Add a new image (converts to WebP, auto-numbers w-XXX in wallpapers/)
walls add ~/Downloads/wallpaper.png

# Unlink from ~/.local/share/wallpapers and ~/.local/bin/walls
walls unlink
```

---

## 🚀 Usage with Window Managers

### 1. MangoWM (Wayland)

Wallpapers are automatically managed via `swaybg`:

```bash
swaybg -i ~/.local/share/wallpapers/w-001.webp -m fill
```

*Interactive Selector:* Press `Super + W` or `Super + Ctrl + W` inside the MangoWM session to open the Fuzzel wallpaper picker.

### 2. BSPWM (X11)

Wallpapers are automatically managed via `feh`:

```bash
feh --no-fehbg --bg-fill ~/.local/share/wallpapers/w-001.webp
```

*Interactive Selector:* Press `Super + W` inside the BSPWM session to open the Rofi wallpaper picker.

### 3. Integrated Dotfiles Bootstrap

When bootstrapping the ecosystem via [anthonyportugal/dotfiles](https://github.com/anthonyportugal/dotfiles):

```bash
dotfiles bootstrap --profile desktop --wm mangowm --wallpapers --apply
```

---

## ⚡ Formats & Optimization

- **WebP Exclusivity:** Sole image format tracked in this repository. Delivers high visual fidelity with ~50-80% smaller file sizes compared to uncompressed PNGs, leading to near-instant decoding and reduced RAM usage in `swaybg` and `feh`.
- **Zero Duplication:** Original source images (PNG, JPG) are automatically converted upon addition and never committed to Git, preserving a featherweight repository history.

---

## 🎨 Gallery

<details open>
<summary><b>🖼️ Wallpaper Collection (4 available)</b> <i>— Click to collapse / expand</i></summary>
<br>

| `w-001` (1080p) | `w-002` (2K) |
| :---: | :---: |
| <img src="wallpapers/w-001.webp" width="380" alt="w-001"> | <img src="wallpapers/w-002.webp" width="380" alt="w-002"> |
| `w-003` (2K) | `w-004` (2K QHD) |
| <img src="wallpapers/w-003.webp" width="380" alt="w-003"> | <img src="wallpapers/w-004.webp" width="380" alt="w-004"> |

</details>

---

## 📄 License

MIT © [Anthony Portugal](https://github.com/anthonyportugal)
