# Particle-Desktop-Environment

这是一个基于X11，集成Openbox, tint2, rofi等组件的轻量级桌面环境开源项目。

## 快速启动
# 创建挂载点
sudo mkdir -p /mnt/hgfs
# 手动挂载共享文件夹
sudo vmhgfs-fuse .host:/ /mnt/hgfs -o allow_other -o uid=1000
运行安装脚本
cd /mnt/hgfs/particle-de-project
chmod +x scripts/setup_env.sh
chmod +x scripts/particlede-session
```bash
./scripts/setup_env.sh
```

在安装lightdm时选择lightdm为default display manager

重启或登出，点击登录界面的右下角齿轮图标，选择ParticleDE并登录
