# dotfiles

Configuration files and helper scripts for my dwm environment on Arch Linux and Debian.

These dotfiles are primarily intended to be installed by my `dwm-install` scripts, but the repository can also be cloned and used manually.

## Installation

The recommended method is to use:

```text
https://github.com/rabbi-lion/dwm-install
```

The installer clones this repository temporarily, copies the required files into place and installs the system configuration where needed.

To clone the repository manually:

```sh
git clone https://github.com/rabbi-lion/dotfiles.git
```

Existing matching configuration files may be overwritten when deployed.

## Contents

The repository contains configuration for:

- bash
- dunst
- Firefox
- GTK
- mpv
- Neovim
- nsxiv
- Redshift
- Thunderbird
- Thunar
- Xresources
- X11
- yt-dlp
- Zathura

It also contains helper scripts for:

- dwmblocks
- nsxiv
- st
- wallpaper handling

## X session

The graphical session is started through `.xinitrc`.

It launches:

```text
Xresources
Redshift
wallpaper
dunst
dwmblocks
dwm
```

Caps Lock and Escape are swapped for the X session.

## Status bar

The dwmblocks scripts are stored in:

```text
.local/bin/statusbar/
```

The default status bar contains:

```text
internet | brightness | volume | battery | clock
```

The blocks support signaling and mouse actions where applicable.

## nsxiv

The repository contains configuration and helper files for `nsxiv`.

`nsxiv` itself is **compiled from source from my GitHub repository** by `dwm-install`; it is not installed from the Arch Linux repositories.

Source:

`https://github.com/rabbi-lion/nsxiv`

Relevant dotfiles include:

- `.config/nsxiv/exec/key-handler`
- `.local/bin/nsxiv-rifle`
- `.local/share/applications/nsxiv.desktop`

The setup provides:

- directory-aware image opening
- Thunar integration
- Trash support
- common image MIME associations
- keyboard handling

Stock nsxiv scaling behavior is preserved.

## mpv

mpv configuration is stored under:

```text
.config/mpv/
```

This includes:

- general mpv settings
- input bindings
- image-scaling shaders
- a script for moving the current file to Trash

The included shaders retain their original licenses and attribution.

## st helpers

The repository contains:

```text
.local/bin/st-copyout
.local/bin/st-urlhandler
```

These are third-party helper scripts from Luke Smith's st repository and retain their original MIT/X Consortium license.

## Firefox

Firefox configuration is deployed as a system policy from:

`system/etc/firefox/policies/policies.json`

The policy configures privacy and interface preferences and installs:

- uBlock Origin
- Dark Reader
- Enhancer for YouTube
- I Still Don't Care About Cookies

It also fixes file-picker behavior for the X11/dwm environment by setting:

`widget.use-xdg-desktop-portal.file-picker = 0`

This makes Firefox use its native file picker instead of the XDG desktop portal file picker.

## Thunderbird

Thunderbird configuration is provided through:

`system/usr/lib/thunderbird/distribution/policies.json`

The policy applies the same file-picker fix:

`widget.use-xdg-desktop-portal.file-picker = 0`

This makes Thunderbird use its native file picker instead of the XDG desktop portal file picker.

## Redshift

Redshift configuration is stored in:

```text
.config/redshift.conf
```

The installer replaces the latitude and longitude placeholders with values supplied during installation.

Default temperatures are:

```text
Day:   6500 K
Night: 4500 K
```

## Wallpaper

The default wallpaper is:

```text
dante-et-vergil-dans-le-neuvieme-cercle-de-l'enfer.jpg
```

Wallpaper helpers are:

```text
.local/bin/wallpaper
.local/bin/wallpaper-slideshow
```

## Repository layout

```text
dotfiles/
├── LICENSE
├── LICENSING_NOTICE
├── .bash_profile
├── .bashrc
├── .Xresources
├── .xinitrc
├── .config/
├── .local/
├── system/
└── dante-et-vergil-dans-le-neuvieme-cercle-de-l'enfer.jpg
```

## Notes

These files are designed around my dwm setup and may overwrite existing configuration when installed.

Machine-specific configuration is intentionally kept outside this repository.

## License

Made by rabbi-lion.

Original material in this repository is licensed under the GNU General Public License version 3.

See `LICENSE` for the full license text.

Third-party material retains its original license and attribution. See `LICENSING_NOTICE` for details.
