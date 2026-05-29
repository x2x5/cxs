#!/usr/bin/env bash
# cxs 安装脚本（无需 root 权限）
set -e

INSTALL_DIR="${CXS_INSTALL_DIR:-$HOME/.local/bin}"
ACCOUNTS_DIR="${CX_ACCOUNTS_DIR:-$HOME/codex-accounts}"
REPO="https://raw.githubusercontent.com/x2x5/cxs/refs/heads/master"

mkdir -p "$INSTALL_DIR"
mkdir -p "$ACCOUNTS_DIR"

# 下载 cxs 脚本
if command -v curl &>/dev/null; then
    curl -fsSL "$REPO/cxs" -o "$INSTALL_DIR/cxs"
elif command -v wget &>/dev/null; then
    wget -q "$REPO/cxs" -O "$INSTALL_DIR/cxs"
else
    echo "错误: 需要 curl 或 wget"
    exit 1
fi

chmod +x "$INSTALL_DIR/cxs"

# 检查 PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    SHELL_NAME=$(basename "$SHELL")
    case "$SHELL_NAME" in
        bash) RC="$HOME/.bashrc" ;;
        zsh)  RC="$HOME/.zshrc" ;;
        *)    RC="" ;;
    esac
    if [[ -n "$RC" ]]; then
        echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >> "$RC"
        echo "已添加 PATH 到 $RC"
        echo "运行: source $RC 立即生效"
    else
        echo "请手动添加 $INSTALL_DIR 到 PATH"
    fi
fi

echo ""
echo "安装完成！"
echo ""
echo "快速开始:"
echo "  cxs add     # 添加中转站账号"
echo "  cxs list    # 列出账号"
echo "  cxs status  # 查看状态"
