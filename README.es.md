# Walls

<p align="center">
  <a href="https://github.com/anthonyportugal/walls/actions/workflows/ci.yml"><img src="https://img.shields.io/github/actions/workflow/status/anthonyportugal/walls/ci.yml?branch=main&style=flat-square&logo=githubactions&logoColor=white&label=CI" alt="CI"></a>
  <a href="https://kernel.org"><img src="https://img.shields.io/badge/SO-Linux-FCC624?style=flat-square&logo=linux&logoColor=black" alt="Linux"></a>
  <a href="https://developers.google.com/speed/webp"><img src="https://img.shields.io/badge/Formato-WebP_Optimizado-green?style=flat-square" alt="WebP"></a>
  <a href="https://github.com/catppuccin/catppuccin"><img src="https://img.shields.io/badge/Paleta-Catppuccin_Mocha-cba6f7?style=flat-square&logo=catppuccin&logoColor=1e1e2e" alt="Tema"></a>
  <a href="https://www.gnu.org/software/bash/"><img src="https://img.shields.io/badge/CLI-Bash-4EAA25?style=flat-square&logo=gnu-bash&logoColor=white" alt="Bash CLI"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/Licencia-MIT-blue.svg?style=flat-square" alt="Licencia"></a>
</p>

*Read this in other languages:* [English](README.md)

Colección curada de fondos de pantalla ligeros y en alta resolución optimizados para escritorios minimalistas en Linux, gestores de ventanas en mosaico y la paleta de colores [Catppuccin Mocha](https://github.com/catppuccin/catppuccin).

> [!TIP]
> 🧩 **Ecosistema Modular de Dotfiles:**  
> [Base y CLI](https://github.com/anthonyportugal/dotfiles) • [MangoWM (Wayland)](https://github.com/anthonyportugal/dotfiles-mangowm) • [BSPWM (X11)](https://github.com/anthonyportugal/dotfiles-bspwm) • **Fondos de Pantalla [Actual]** • [Sistema](https://github.com/anthonyportugal/dotfiles-system)
> 
> Diseñado para integrarse perfectamente con [anthonyportugal/dotfiles](https://github.com/anthonyportugal/dotfiles) (tanto en sesiones MangoWM como BSPWM) o para funcionar como un gestor de fondos de pantalla totalmente autónomo.

---

## ✨ Características Principales

- ⚡ **Almacenamiento Puro en WebP:** Cero sobrepeso de archivos PNG o JPG sin comprimir; tamaño de clonación entre 50% y 80% menor con menor consumo de memoria en los daemons de fondos de pantalla.
- 🛠️ **CLI de Gestión Autónomo:** Agrega, autoconvierte, lista, vincula y diagnostica fondos de pantalla fácilmente mediante `bin/walls`.
- 🎛️ **Compatibilidad Dual-WM:** Integración lista para usar con `swaybg` (Wayland / MangoWM) y `feh` (X11 / BSPWM).
- 🖼️ **Galería Automatizada:** Generador instantáneo de tablas de vista previa en Markdown para mantener el README limpio, responsivo y actualizado.

---

## 🛠️ CLI de Gestión (`bin/walls`)

El repositorio incluye un CLI autónomo para gestionar la colección y la integración en el sistema:

```bash
# Iniciar el asistente de configuración interactivo (vincula colección, comando CLI y audita estado)
./bin/walls setup

# O iniciar directamente en español
./bin/walls setup --lang es

# Resincronizar los enlaces simbólicos de fondos y CLI sin tocar Git
walls sync

# Descargar las últimas actualizaciones del repositorio remoto y resincronizar
walls update

# Vincular fondos en ~/.local/share/wallpapers y el comando en ~/.local/bin/walls
./bin/walls link

# Verificar la salud del repositorio, formatos y estado de los enlaces
walls doctor

# Listar todos los fondos con resolución y tamaño de archivo
walls list

# Agregar una nueva imagen (convierte a WebP y numera w-XXX en wallpapers/)
walls add ~/Downloads/wallpaper.png

# Desvincular de ~/.local/share/wallpapers y ~/.local/bin/walls
walls unlink
```

---

## 🚀 Uso con Gestores de Ventanas

### 1. MangoWM (Wayland)

Los fondos de pantalla se gestionan automáticamente a través de `swaybg`:

```bash
swaybg -i ~/.local/share/wallpapers/w-001.webp -m fill
```

*Selector interactivo:* Presiona `Super + W` o `Super + Ctrl + W` dentro de la sesión de MangoWM para abrir el selector de fondos Fuzzel.

### 2. BSPWM (X11)

Los fondos de pantalla se gestionan automáticamente a través de `feh`:

```bash
feh --no-fehbg --bg-fill ~/.local/share/wallpapers/w-001.webp
```

*Selector interactivo:* Presiona `Super + W` dentro de la sesión de BSPWM para abrir el selector de fondos Rofi.

### 3. Bootstrap Integrado de Dotfiles

Al iniciar el ecosistema mediante [anthonyportugal/dotfiles](https://github.com/anthonyportugal/dotfiles):

```bash
dotfiles bootstrap --profile desktop --wm mangowm --wallpapers --apply
```

---

## ⚡ Formatos y Optimización

- **Exclusividad WebP:** Único formato de imagen rastreado en este repositorio. Ofrece alta fidelidad visual con un peso de archivo entre 50% y 80% menor frente a PNGs sin comprimir, lo que permite una decodificación casi instantánea y menor uso de RAM en `swaybg` y `feh`.
- **Cero Duplicación:** Las imágenes de origen originales (PNG, JPG) se convierten automáticamente al agregarse y nunca se comitean en Git, manteniendo un historial de repositorio ultraligero.

---

## 🎨 Galería

<details open>
<summary><b>🖼️ Colección de Fondos de Pantalla (4 disponibles)</b> <i>— Clic para colapsar / expandir</i></summary>
<br>

| `w-001` (1080p) | `w-002` (2K) |
| :---: | :---: |
| <img src="wallpapers/w-001.webp" width="380" alt="w-001"> | <img src="wallpapers/w-002.webp" width="380" alt="w-002"> |
| `w-003` (2K) | `w-004` (2K QHD) |
| <img src="wallpapers/w-003.webp" width="380" alt="w-003"> | <img src="wallpapers/w-004.webp" width="380" alt="w-004"> |

</details>

---

## 👤 Autor

Diseñado y mantenido por [Anthony Portugal](https://anthonyportugal.github.io/es/).

---

## 📄 Licencia y Atribución

- **Scripts y CLI (`bin/walls`, `scripts/`):** Distribuido bajo la [Licencia MIT](LICENSE) © [Anthony Portugal](https://github.com/anthonyportugal).
- **Fondos de pantalla e ilustraciones:** Curados y adaptados en color para la estética Catppuccin Mocha para personalización de escritorio personal y no comercial. Todos los derechos de autor y propiedad intelectual pertenecen a sus respectivos artistas originales. Si eres el creador original de algún fondo incluido aquí y deseas que sea acreditado o retirado, por favor abre un issue y se atenderá a la brevedad.
