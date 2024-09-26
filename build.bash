#!/bin/bash

set -e

#####
# 基础变量
#####
#
# 构建依赖列表
_BUILD_DEPS=(
    'g++' 'build-essential' 'pkg-config' 'libx11-dev' 'libjpeg-dev'
    'libpng-dev' 'libgl1-mesa-dev' 'libudev-dev' 'libgbm-dev' 'libx11-dev'
    'xinit' 'openbox' 'xterm' 'meson' 'ninja-build' 'libdrm-dev' 'libxext-dev'
    'libglu1-mesa-dev' 'x11-apps'
)
# 路径变量
_SRCDIR="$PWD"
_PREFIX='/usr/lib/graphics-bench-deepin'
#####
# 构建参数
#####
#
# 安装路径
_MESON_PREFIX=(
	'-Dprefix="${_PREFIX}"'
)
# glmark2 构建参数
_GLMARK2_OPTS=(
	'-Dflavors=x11-gl,x11-gl-egl'
)
# mesa-demos 构建参数
_MESA_DEMOS_OPTS=(
	'-Dwith-glut=false'
        '-Degl=enabled'
        '-Dgles1=disabled'
	'-Dgles2=disabled'
	'-Dglut=disabled'
	'-Dosmesa=disabled'
	'-Dlibdrm=enabled'
	'-Dx11=enabled'
	'-Dvulkan=enabled'
	'-Dwayland=disabled'
	'-Dwith-system-data-files=false'
)

echo '正在安装依赖 ...'
sudo apt install -y ${_BUILD_DEPS[@]}

echo '正在执行清理 ...'
rm -rf \
	"$_SRCDIR"/{glmark2,mesa-demos,byte-unixbench}/build \
	"$_PREFIX"

if git rev-parse --is-inside-work-tree; then
    echo '正在更新 Git 子项目 ...'
    git submodule update --init --recursive
fi

echo '正在安装 glmark2 ...'
mkdir -pv "$_SRCDIR"/glmark2/build
cd "_$SRCDIR"/glmark2/build
meson "$_SRCDIR"/glmark2 \
	${_MESON_PREFIX[@]} \
	${_GLMARK2_OPTS[@]}
ninja
ninja install

echo '正在安装 meson-demos ...'
mkdir -pv "$_SRCDIR"/mesa-demos/build
cd "$_SRCDIR"/mesa-demos/build
meson "$_SRCDIR"/mesa-demos/build \
	${_MESON_PREFIX[@]} \
	${_MESA_DEMOS_OPTS[@]}
ninja
ninja install

echo '正在安装 UnixBench ...'
cp -av "$_SRCDIR"/unixbench \
	"$_PREFIX"/

echo '正在安装测试脚本 ...'
cp -av "$_SRCDIR"/bench-scripts \
	"$_PREFIX"/
sed \
	-e "s|@PREFIX@|${_PREFIX}|g" \
	-i "$_PREFIX"/bench-scripts/*.bash

echo '正在启动 X11 测试会话 ...'
xinit "$_PREFIX"/bench-scripts/xinitrc
