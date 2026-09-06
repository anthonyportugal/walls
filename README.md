# Walls

Curated collection of high-resolution, lightweight wallpapers optimized for minimalist Linux setups, tiling window managers, and the [Catppuccin Mocha](https://github.com/catppuccin/catppuccin) color palette.

Designed to integrate seamlessly with [anthonyportugal/dotfiles](https://github.com/anthonyportugal/dotfiles) (MangoWM & BSPWM).

## 🛠 Management CLI (`bin/walls`)

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
```bash
swaybg -i ~/.local/share/wallpapers/w-001.webp -m fill
```

### 2. BSPWM (X11)
```bash
feh --no-fehbg --bg-fill ~/.local/share/wallpapers/w-001.webp
```

### 3. Integrated Dotfiles Bootstrap
When bootstrapping dotfiles via [anthonyportugal/dotfiles](https://github.com/anthonyportugal/dotfiles):

```bash
dotfiles bootstrap --profile desktop --wm mangowm --wallpapers --apply
```

---

## ⚡ Formats & Optimization

- **WebP:** Sole format in this repository. Offers high visual fidelity with ~50-80% smaller file sizes compared to uncompressed PNGs, leading to near-instant decoding and reduced RAM usage in `swaybg` and `feh`.
- **Zero Duplication:** Original PNG/JPG images are converted upon addition into `wallpapers/` and not tracked in Git to maintain a featherweight clone size.

---

## 🎨 Gallery

<details open>
<summary><b>🖼️ Wallpaper Collection (4 available)</b> <i>— Click to collapse / expand</i></summary>
<br>

| `w-001` (1080p) | `w-002` (2K) |
| :---: | :---: |
| <img src="wallpapers/w-001.webp" width="380" alt="w-001"> | <img src="wallpapers/w-002.webp" width="380" alt="w-002"> |
| **`w-003` (2K)** | **`w-004` (2K QHD)** |
| <img src="wallpapers/w-003.webp" width="380" alt="w-003"> | <img src="wallpapers/w-004.webp" width="380" alt="w-004"> |

</details>

---

## 📄 License

MIT © [Anthony Portugal](https://github.com/anthonyportugal)
