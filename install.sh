#!/usr/bin/env bash
# cxs 安装脚本（无需 root 权限）
#
# 用法：
#   curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/cxs/main/install.sh | bash
#   或者：
#   git clone https://github.com/YOUR_USERNAME/cxs.git && cd cxs && bash install.sh

set -e

# 安装目录（默认 ~/.local/bin，无需 root）
INSTALL_DIR="${CXS_INSTALL_DIR:-$HOME/.local/bin}"
ACCOUNTS_DIR="${CX_ACCOUNTS_DIR:-$HOME/codex-accounts}"

echo "╔═══════════════════════════════════════╗"
echo "║       cxs 安装程序                     ║"
echo "╚═══════════════════════════════════════╝"
echo ""

# 1. 创建安装目录
mkdir -p "$INSTALL_DIR"

# 2. 下载或复制 cxs 脚本
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -f "$SCRIPT_DIR/cxs" ]]; then
    cp "$SCRIPT_DIR/cxs" "$INSTALL_DIR/cxs"
    echo "✓ 已复制 cxs 到 $INSTALL_DIR/cxs"
else
    echo "错误: 找不到 cxs 脚本"
    echo "请在 cxs 项目目录下运行此脚本"
    exit 1
fi

chmod +x "$INSTALL_DIR/cxs"
echo "✓ 已设置可执行权限"

# 3. 创建账号目录
mkdir -p "$ACCOUNTS_DIR"
echo "✓ 账号目录: $ACCOUNTS_DIR"

# 4. 检查 PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo ""
    echo "⚠ $INSTALL_DIR 不在 PATH 中"
    echo ""
    echo "请将以下内容添加到 ~/.bashrc 或 ~/.zshrc:"
    echo ""
    echo "  export PATH=\"$INSTALL_DIR:\$PATH\""
    echo ""
    
    # 自动检测 shell 并提示
    SHELL_NAME=$(basename "$SHELL")
    case "$SHELL_NAME" in
        bash)
            echo "运行以下命令立即生效:"
            echo "  echo 'export PATH=\"$INSTALL_DIR:\$PATH\"' >> ~/.bashrc"
            echo "  source ~/.bashrc"
            ;;
        zsh)
            echo "运行以下命令立即生效:"
            echo "  echo 'export PATH=\"$INSTALL_DIR:\$PATH\"' >> ~/.zshrc"
            echo "  source ~/.zshrc"
            ;;
        *)
            echo "请将 $INSTALL_DIR 添加到你的 PATH 环境变量中"
            ;;
    esac
else
    echo "✓ $INSTALL_DIR 已在 PATH 中"
fi

echo ""
echo "═══════════════════════════════════════"
echo "安装完成！"
echo ""
echo "快速开始:"
echo "  cxs add              # 添加中转站账号"
echo "  cxs list             # 列出所有账号"
echo "  cxs switch <名称>    # 切换账号"
echo "  cxs auto             # 自动选额度最多的"
echo ""
echo "账号目录: $ACCOUNTS_DIR"
echo "═══════════════════════════════════════"
