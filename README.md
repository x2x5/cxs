# cxs - Codex 多账号切换器

快速切换多个 Codex 账号（中转站 / OAuth），支持自动额度查询。

## 安装

```bash
curl -fsSL https://raw.githubusercontent.com/x2x5/cxs/refs/heads/master/install.sh | bash
```

无需 root 权限，装在 `~/.local/bin`。

## 快速开始

```bash
# 添加中转站账号
cxs add

# 列出所有账号
cxs list

# 切换
cxs switch 0530-142135-breeze

# 查看额度（OAuth）
cxs status
```

## 命令

| 命令 | 说明 |
|------|------|
| `cxs add` | 添加账号（自动生成名称） |
| `cxs switch <名称>` | 切换 |
| `cxs list` | 列出 |
| `cxs status` | 总览 |
| `cxs quota` | 查看额度 |
| `cxs auto` | 自动选额度最多的 |
| `cxs edit <名称>` | 编辑 auth.json |

## License

MIT
