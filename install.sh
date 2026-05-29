#!/usr/bin/env bash
set -e

INSTALL_DIR="${CXS_INSTALL_DIR:-$HOME/.local/bin}"
ACCOUNTS_DIR="${CX_ACCOUNTS_DIR:-$HOME/codex-accounts}"
REPO="https://raw.githubusercontent.com/x2x5/cxs/refs/heads/master"

# 卸载
if [[ "${1:-}" == "--uninstall" ]]; then
    echo "卸载 cxs..."
    rm -f "$INSTALL_DIR/cxs"
    rm -rf "$ACCOUNTS_DIR"
    rm -f "$HOME/.codex/.current_account"
    rm -rf "$HOME/.codex/.quota_cache"
    echo "已卸载"
    exit 0
fi

# 安装
mkdir -p "$INSTALL_DIR"
mkdir -p "$ACCOUNTS_DIR"

if command -v curl &>/dev/null; then
    curl -fsSL "$REPO/cxs" -o "$INSTALL_DIR/cxs"
elif command -v wget &>/dev/null; then
    wget -q "$REPO/cxs" -O "$INSTALL_DIR/cxs"
else
    echo "错误: 需要 curl 或 wget"
    exit 1
fi

chmod +x "$INSTALL_DIR/cxs"

if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    SHELL_NAME=$(basename "$SHELL")
    case "$SHELL_NAME" in
        bash) RC="$HOME/.bashrc" ;;
        zsh)  RC="$HOME/.zshrc" ;;
        *)    RC="" ;;
    esac
    if [[ -n "$RC" ]]; then
        echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >> "$RC"
        echo "已添加 PATH 到 $RC，运行 source $RC 生效"
    fi
fi

echo ""
echo "安装完成！"
echo "  cxs add     # 添加账号"
echo "  cxs list    # 列出"
echo "  cxs status  # 状态"
