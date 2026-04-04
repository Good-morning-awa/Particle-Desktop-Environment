#!/bin/bash
# ParticleDE 环境设置脚本

set -e # 遇到错误就退出

echo "[1] 安装必要的软件包..."
sudo apt update
sudo apt install -y openbox tint2 rofi pcmanfm conky lightdm feh xterm \
lightdm-gtk-greeter x11-xserver-utils xinit x11-utils \

echo "[2] 复制配置文件到用户目录..."
# 创建配置目录
mkdir -p ~/.config/openbox ~/.config/tint2

# 复制Openbox配置
cp -r config/openbox/* ~/.config/openbox/
# 复制tint2配置
cp config/tint2/tint2rc ~/.config/tint2/

echo "[3] 安装桌面会话文件..."
# 复制会话启动脚本到系统目录
sudo cp scripts/particlede-session /usr/local/bin/
sudo chmod +x /usr/local/bin/particlede-session
# 复制桌面入口文件
sudo cp config/particlede.desktop /usr/share/xsessions/

echo "[4] 提示用户..."
echo "ParticleDE 第一周配置已完成！"
echo "请注销或重启，在登录界面选择 'ParticleDE' 会话。"
echo ""
echo "首次进入桌面后，你可以："
echo "  - 按 Super键(Windows键) 启动程序"
echo "  - 在桌面右键打开菜单"
echo "  - 在面板上看到时间和任务栏"
