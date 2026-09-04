# Walls

Curated collection of high-resolution, lightweight wallpapers optimized for minimalist Linux setups, tiling window managers, and the [Catppuccin Mocha](https://github.com/catppuccin/catppuccin) color palette.

Designed to integrate seamlessly with [anthonyportugal/dotfiles](https://github.com/anthonyportugal/dotfiles) (MangoWM & BSPWM).

---

## 🎨 Gallery

| Preview | Name | Resolution | Format | Palette |
| :---: | :--- | :---: | :---: | :--- |
| ![w-001](wallpapers/w-001.webp) | `w-001` | 1920 × 1080 | WebP | Catppuccin Mocha |

---

## ⚡ Formats & Optimization

- **WebP:** Sole format in this repository. Offers high visual fidelity with ~50-80% smaller file sizes compared to uncompressed PNGs, leading to near-instant decoding and reduced RAM usage in `swaybg` and `feh`.
- **Zero Duplication:** Original PNG/JPG images are converted upon addition into `wallpapers/` and not tracked in Git to maintain a featherweight clone size.

---

## 🛠 Management CLI (`bin/walls`)

The repository includes a standalone CLI to manage the collection and system integration:

```bash
# Link wallpapers to ~/.local/share/wallpapers and command to ~/.local/bin/walls
./bin/walls link

# Check repository health, formats, and link status
walls doctor

# List all wallpapers with resolution and file size
walls list

# Add a new image (converts to WebP, auto-numbers w-XXX in wallpapers/, avoids duplicating original)
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
When bootstrapping dotfiles via `anthonyportugal/dotfiles`:

```bash
~/.dotfiles/base/bin/dotfiles bootstrap --profile desktop --wm mangowm --wallpapers --apply
```

---

## 📄 License

MIT © [Anthony Portugal](https://github.com/anthonyportugal)
