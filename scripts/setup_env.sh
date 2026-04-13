#!/bin/bash
set -e

# 核心修复：定位项目根目录
SCRIPT_DIR=$(cd $(dirname $0)/.. && pwd)
cd $SCRIPT_DIR

# 1. 仅安装图标/文件管理器必需依赖
echo "[1] 安装核心依赖..."
sudo apt update
sudo apt install -y pcmanfm papirus-icon-theme imagemagick software-properties-common

# 2. 生成基础壁纸
echo "[2] 生成壁纸..."
mkdir -p ~/Pictures/particle-wallpapers
convert -size 1920x1080 xc:#1a1b26 ~/Pictures/particle-wallpapers/wallpaper-1080p.png

# 3. 复制配置文件
echo "[3] 复制文件管理器配置..."
mkdir -p ~/.config/pcmanfm/LXDE
cp -r $SCRIPT_DIR/configs/pcmanfm/. ~/.config/pcmanfm/

# 4. 部署自定义图标
echo "[4] 部署Papirus-Dark图标..."
mkdir -p ~/.icons
cp -r $SCRIPT_DIR/icons/Papirus-Dark ~/.icons/
# 刷新图标缓存
gtk-update-icon-cache -f -t ~/.icons/Papirus-Dark/ &>/dev/null
sudo gtk-update-icon-cache -f -t /usr/share/icons/Papirus-Dark/ &>/dev/null

# 5. 强制关联图标主题
echo "[5] 配置图标生效..."
# PCManFM专属配置
echo '[Desktop]
icon_theme=Papirus-Dark' > ~/.config/pcmanfm/LXDE/desktop-items-0.conf
# 全局图标配置
echo 'gtk-icon-theme-name="Papirus-Dark"' > ~/.gtkrc-2.0
mkdir -p ~/.config/gtk-3.0
echo '[Settings]
gtk-icon-theme-name=Papirus-Dark' > ~/.config/gtk-3.0/settings.ini

# 6. 部署会话文件
echo "[6] 部署会话文件..."
# 1. 部署 particlede-session 启动脚本
sudo cp $SCRIPT_DIR/scripts/particlede-session /usr/local/bin/
sudo chmod +x /usr/local/bin/particlede-session
# 2.复制到系统会话目录
SESSION_DESKTOP_SRC="$SCRIPT_DIR/configs/particlede.desktop"
SESSION_DESKTOP_DST="/usr/share/xsessions/particlede.desktop"
sudo cp "$SESSION_DESKTOP_SRC" "$SESSION_DESKTOP_DST"
# 3. 更新系统会话数据库，确保识别
sudo update-desktop-database /usr/share/xsessions/ &>/dev/null

echo "✅ 图标还原+会话文件部署完成！重启后选择ParticleDE即可"