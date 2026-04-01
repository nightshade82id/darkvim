# DarkVim

DarkVim adalah konfigurasi Neovim yang dirancang untuk meningkatkan produktivitas dan kenyamanan dalam pengembangan perangkat lunak. Dengan fokus pada kecepatan, efisiensi, dan estetika, DarkVim menyediakan lingkungan kerja yang optimal untuk para pengembang. DarkVim juga dapat digunakan pada perangkat Android dengan menggunakan Termux, memungkinkan pengembangan di mana saja.

### Screenshots

![Dashboard](screenshots/dashboard.png)
![Editor with File Explorer](screenshots/editor-fe.png)
![Editor with File Explorer and Terminal](screenshots/editor-feNt.png)

## Fitur Utama

- **Tema Gelap**: DarkVim menggunakan tema gelap [coal.nvim](https://github.com/cranberry-clockworks/coal.nvim) yang nyaman untuk mata.

- **Transparansi latar belakang**: Menambahkan efek transparansi untuk meningkatkan estetika.

- **Panel Penjelajah File**: [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua) untuk memudahkan navigasi proyek dengan panel penjelajah file yang intuitif.

- **Terminal Terintegrasi**: [toggleterm](https://github.com/akinsho/toggleterm.nvim) terminal bawaan untuk menjalankan perintah tanpa meninggalkan editor.

- **Dukungan LSP**: Integrasi dengan Language Server Protocol untuk fitur seperti autocompletion, linting, dan debugging. (Cek file konfigurasi untuk informasi lebih lanjut)

- **GitHub Copilot autocompletion**: Memanfaatkan kekuatan AI [copilot.vim](https://github.com/github/copilot.vim) untuk memberikan saran kode yang relevan dan meningkatkan produktivitas. 

> [!WARNING]
> Untuk perangkat versi Android lama atau custom ROM dengan spesifikasi rendah, mungkin mengalami masalah peforma dengan fitur GitHub Copilot. Disarankan untuk menonaktifkan fitur ini jika mengalami lag atau masalah performa.

## Persyaratan

- Neovim versi 0.11 atau lebih baru
- Nerd Font untuk ikon yang optimal (opsional tetapi disarankan)
- Compiler C untuk `nvim-treesitter`

## Instalasi

- Instal Neovim pada sistem Anda.
  Contoh untuk Linux:
   ```bash
   sudo apt install neovim # untuk berbasis Debian/Ubuntu
   sudo dnf install neovim # untuk berbasis Fedora
   sudo pacman -S neovim # untuk berbasis Arch
   pkg install neovim # untuk Android via Termux
   ```
  Contoh untuk macOS (menggunakan Homebrew):
    ```bash
    brew install neovim
    ```
  Contoh untuk Windows (menggunakan Winget):
    ```powershell
    winget install Neovim.Neovim
    ```

- Instal file `init.lua` ke direktori konfigurasi Neovim Anda
  Contoh untuk Linux/macOS/Android:
   ```bash
   curl -o ~/.config/nvim/init.lua https://raw.githubusercontent.com/nightshade82id/darkvim/main/init.lua 
   ```
  Contoh untuk Windows:
   ```powershell
   curl -o $env:APPDATA\nvim\init.lua https://raw.githubusercontent.com/nightshade82id/darkvim/main/init.lua 
   ```

- Instal Nerd Font untuk ikon yang optimal (disarankan JetBrains Mono Nerd Font)
  Contoh untuk Linux:
   ```bash
   sudo pacman -S ttf-jetbrains-mono-nerd # untuk berbasis Arch
   curl -OL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.tar.xz # untuk distribusi lainnya
   ```
  Contoh untuk macOS (menggunakan Homebrew):
   ```bash
   brew install --cask font-jetbrains-mono-nerd-font
   ```
  Contoh untuk Windows (menggunakan Winget):
   ```powershell
   winget install -e --id DEVCOM.JetBrainsMonoNerdFont
   ```

## Keybindings

### General

- `Ctrl + e`: Toggle file explorer
- `Ctrl + t`: Toggle terminal 

### LSP (Language Server Protocol)

- `gd`: Go to definition
- `K`: Show documentation
- `gr`: Show references
- `Space + rn`: Rename symbol
- `Space + ca`: Code action 
- `[d`: Previous diagnostic
- `]d`: Next diagnostic

### Navigasi dan manajemen file

- `Return / o`: Buka file atau direktori
- `a`: Tambah file atau direktori baru
- `d`: Hapus file atau direktori
- `r`: Ganti nama file atau direktori
- `x`: Potong file atau direktori
- `c`: Salin file atau direktori
- `p`: Tempel file atau direktori yang dipotong atau disalin
- `R`: Refresh tampilan file explorer

## GitHub Copilot 

- `:Copilot auth`: Autentikasi dengan GitHub Copilot
- `:Copilot status`: Periksa status Copilot
- `:Copilot enable`: Aktifkan Copilot 
- `:Copilot disable`: Nonaktifkan Copilot

## Credits

- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [coal.nvim](https://github.com/cranberry-clockworks/coal.nvim)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [alpha-nvim](https://github.com/goolord/alpha-nvim)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [copilot.vim](https://github.com/github/copilot.vim)
- [mason.nvim](https://github.com/williamboman/mason.nvim)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua)
- [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
