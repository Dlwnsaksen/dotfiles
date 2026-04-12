# dotfiles

My personal Arch Linux dotfiles — Sway-based Wayland desktop.

## Stack

| 역할 | 패키지 |
|------|--------|
| Compositor | Sway |
| Status bar | Waybar |
| Launcher | Wofi |
| Notification | Swaync |
| Lock screen | Swaylock |
| Terminal | Foot |
| Shell | Fish + Starship |
| Input method | Fcitx5 (Korean) |

## Install

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Wallpaper

Place your wallpaper at `~/.config/sway/wallpaper` (any image format).

## Theme

Colors are defined as CSS/config variables — edit these two files to retheme:
- `config/sway/config` — window borders
- `config/waybar/style.css` — bar colors
- `config/wofi/style.css` — launcher colors
- `config/swaylock/config` — lock screen colors
- `config/foot/foot.ini` — terminal colors

## Keybinds

| 키 | 동작 |
|----|------|
| `Super+Space` | 앱 런처 |
| `Super+T` | 터미널 |
| `Super+W` | 브라우저 |
| `Super+C` | 에디터 |
| `Super+E` | 파일 매니저 |
| `Super+Q` | 창 닫기 |
| `Super+F` | 전체화면 |
| `Super+L` | 잠금 |
| `Super+V` | 클립보드 |
| `Super+Shift+S` | 영역 스크린샷 |
| `Print` | 전체화면 스크린샷 |
| `Ctrl+Alt+Delete` | 세션 메뉴 |
| `Ctrl+Shift+Escape` | 시스템 모니터 (btop) |
