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

## 하드웨어 고유 설정 (LG gram)

- `config/wireplumber/wireplumber.conf.d/51-amd-sdw-headroom.conf` — RT713/RT1320 SoundWire 헤드룸
- `config/easyeffects/db/` — LG gram Windows 유사 EQ 프리셋
- `config/sway/scripts/touchpad.sh` — 터치패드 토글 (기기 ID 하드코딩)

다른 기기라면 이 세 가지는 조정이 필요합니다.

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
