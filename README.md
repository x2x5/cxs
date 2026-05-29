# cxs - Codex 多账号切换器

快速切换多个 Codex 账号（中转站 / OAuth），支持自动额度查询。

## 安装

```bash
git clone https://github.com/x2x5/cxs.git
cd cxs
bash install.sh
```

或者直接下载使用：

```bash
mkdir -p ~/.local/bin
curl -fsSL https://raw.githubusercontent.com/x2x5/cxs/main/cxs -o ~/.local/bin/cxs
chmod +x ~/.local/bin/cxs
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
```

无需 root 权限，装在用户目录下。

## 快速开始

```bash
# 添加一个中转站账号（交互式输入 URL 和 Key）
cxs add

# 添加 OAuth 账号
cxs add mychatgpt
# 选择 2，然后自己复制 auth.json

# 列出所有账号
cxs list

# 切换账号
cxs switch 0530-142135-breeze

# 自动切换到额度最多的（仅 OAuth）
cxs auto

# 查看当前状态
cxs status
```

## 目录结构

```
~/codex-accounts/
├── base_config.toml          ← 基础模板（共享）
├── 0530-142135-breeze/
│   └── auth.json             ← 中转站凭据
├── 0530-142500-coral/
│   └── auth.json             ← OAuth 凭据
└── ...
```

## 账号类型

### 中转站

`cxs add` 自动生成：

```json
{
  "api_key": "sk-xxx",
  "base_url": "https://xxx.com/v1"
}
```

### OAuth (ChatGPT Plus/Pro)

手动创建：

```json
{
  "mode": "oauth",
  "tokens": {
    "access_token": "...",
    "account_id": "..."
  }
}
```

## 基础模板

中转站用户需要创建 `~/codex-accounts/base_config.toml`：

```toml
model = "o3"
provider = "openai"
base_url = "{{BASE_URL}}"
```

切换时，`{{BASE_URL}}` 会被替换成 auth.json 里的实际地址。

## 命令

| 命令 | 说明 |
|------|------|
| `cxs add [名称]` | 添加账号（不填名称自动生成） |
| `cxs switch <名称>` | 切换到指定账号 |
| `cxs list` | 列出所有账号 |
| `cxs status` | 总览：所有账号 + 额度 |
| `cxs current` | 显示当前账号 |
| `cxs quota [名称]` | 查看额度（仅 OAuth） |
| `cxs auto` | 自动切换到额度最多的 |
| `cxs edit <名称>` | 编辑 auth.json |
| `cxs diff <名称>` | 对比 |

## 环境变量

| 变量 | 默认值 | 说明 |
|------|--------|------|
| `CX_ACCOUNTS_DIR` | `~/codex-accounts` | 账号目录 |

## License

MIT
