# dotfiles

My personal Arch Linux dotfiles — Sway-based Wayland desktop.

## Stack

| 역할 | 패키지 |
|------|--------|
| Compositor | Sway |
| Status bar | 없음 (사용 안 함) |
| Launcher / 클립보드 / 세션 메뉴 | Fuzzel |
| Notification | Swaync |
| Lock screen | Swaylock |
| Terminal | Foot |
| Shell | Fish + Starship |
| Input method | Fcitx5 (Korean) |
| System monitor | btop |
| Audio EQ | EasyEffects |
| GTK theme | adw-gtk3-dark + Papirus-Dark |

## Install

```bash
git clone https://github.com/Dlwnsaksen/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh`는 기존 실제 파일을 `<경로>.bak`으로 옮긴 뒤 심볼릭 링크를 겁니다.

## Wallpaper

Place your wallpaper at `~/.config/sway/wallpaper` (any image format).
`config/sway/config` 의 `output * bg` 줄이 이 경로를 참조합니다.

## Theme — "Chrome Gray"

배경 `#2b2b2b` / 강조 `#8ab4f8`로 통일돼 있습니다. 리테마 시 아래를 함께 고치세요:

- `config/sway/config` — 창 테두리
- `config/foot/foot.ini` — 터미널 색 (foot은 alpha 값만 라이브 리로드가 안 되므로 재시작 필요)
- `config/fuzzel/fuzzel.ini` — 런처
- `config/swaync/style.css` — 알림
- `config/swaylock/config` — 잠금 화면
- `config/btop/themes/chrome-gray.theme` — 시스템 모니터
- `config/starship.toml` — 프롬프트
- `config/gtk-3.0/gtk.css`, `config/gtk-4.0/gtk.css` — GTK 앱

Qt 앱은 `config/environment.d/theme.conf`의 `QT_QPA_PLATFORMTHEME=gtk3`로 GTK 테마를 따라갑니다.

## 새 기기로 옮길 때

하드웨어 고유 설정은 이 리포에서 모두 제거했습니다. 기기별 조정이 필요하면
`~/.config/sway/conf.d/*.conf` 에 넣으세요 — sway config 마지막에서 include 되며,
`config/sway/conf.d/local.conf` 는 .gitignore 대상입니다.

새 기기 첫 부팅 후 확인할 것:

- `swaymsg -t get_outputs` — 화면 이름/해상도/배율
- `swaymsg -t get_inputs` — 터치패드 인식 여부
- `lspci | grep -Ei 'vga|3d'` — GPU에 맞는 드라이버 추가 설치
  (AMD `vulkan-radeon`, Intel `vulkan-intel intel-media-driver`)
- `sudo usermod -aG video,input $USER` — 밝기 조절 권한
- 오디오 EQ가 필요하면 `easyeffects` 를 직접 설치해 기기에 맞게 새로 설정

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
