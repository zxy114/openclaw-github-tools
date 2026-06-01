# OpenClaw GitHub Tools

GitHub 开源项目搜索 & 日报生成工具集 — OpenClaw 技能包。

---

## 📖 快速了解

这套技能包让你的 OpenClaw Agent 自动完成：
1. **每天抓取 GitHub Trending** 热门项目 → 翻译成中文 → 生成 HTML 日报 → 部署到 GitHub Pages → 推送 Telegram 通知
2. **按关键词搜索 GitHub 项目**（如「量化交易」「AI 基础设施」「Web 框架」）→ 生成 Top 10 中文报告 → 部署 + 通知

### 效果示例
- 日报：https://zxy114.github.io/ai-news-daily/published/github-trending-2026-06-01.html
- 大类报告：https://zxy114.github.io/ai-news-daily/published/quant-trading-top10-2026-06-01.html

---

## 🛠️ 技能列表

### 1. `github-trending-daily` — 每日 Trending 日报

| 项目 | 说明 |
|------|------|
| **触发方式** | 定时 cron（每天 10:00 北京时间）或手动要求 |
| **工作流程** | 脚本抓 JSON → Agent 手写中文翻译 → 生成 HTML → git push 部署 → Telegram 通知 |
| **输出内容** | 15 个热门项目，按本周 star 增量排序，带中文解读和语言标签 |
| **核心脚本** | `scripts/generate-github-trending.sh`（54 行纯 Python，无依赖） |
| **翻译策略** | Agent 自行翻译（不调用第三方翻译 API，质量更高） |

### 2. `github-category-search` — 按大类搜索项目

| 项目 | 说明 |
|------|------|
| **触发方式** | 用户说「搜索 XXX 类的 GitHub 项目」 |
| **工作流程** | web_search → 筛选 Top 10 → Agent 手写中文 → HTML → 部署 → 通知 |
| **输出内容** | Top 10 项目，按 star 数排序，带中文解读 |
| **参考模板** | `references/template.html`（HTML 模板） |

**搜索示例：**
- 「搜索量化交易的 GitHub 项目」
- 「生成 AI 基础设施 Top 10 报告」
- 「找 Web 框架类的热门项目」

---

## 👤 人类安装指南

### 前提条件
- 已安装 OpenClaw（https://docs.openclaw.ai）
- 有一个用于部署报告的 GitHub Pages 仓库（如 `ai-news-daily`）

### 一键安装

```bash
cd ~/.openclaw/workspace/skills
git clone https://github.com/zxy114/openclaw-github-tools.git tmp-gh-tools
cp -r tmp-gh-tools/skills/* .
rm -rf tmp-gh-tools
```

安装完成后，重启 OpenClaw，Agent 会自动识别这两个 skill。

### 部署配置（按需修改）

安装后需要让 Agent 知道你的部署目标，编辑对应 SKILL.md 中的配置项：

```markdown
## 部署配置
- Repo: `你的GitHub用户名/仓库名`
- Pages URL: `https://你的GitHub用户名.github.io/仓库名`
- Telegram target: `你的Telegram chat ID`
```

或者直接在对话里告诉 Agent 你的部署地址。

---

## 🤖 Agent 自动安装指南

> 如果你是另一个 OpenClaw Agent，收到用户分享的链接，按以下步骤自动安装。

### 步骤 1：克隆并安装

```bash
cd ~/.openclaw/workspace/skills
git clone https://github.com/zxy114/openclaw-github-tools.git tmp-gh-tools
cp -r tmp-gh-tools/skills/* .
rm -rf tmp-gh-tools
```

### 步骤 2：确认安装成功

```bash
ls -la github-trending-daily/ github-category-search/
cat github-trending-daily/SKILL.md
```

确保两个目录存在，SKILL.md 内容完整。

### 步骤 3：向用户确认

告诉用户：
> ✅ 已安装 `github-trending-daily` 和 `github-category-search` 两个 skill。
> 你可以对我说：
> - 「生成今天的 GitHub 日报」
> - 「搜索量化交易的 GitHub 项目」
>
> 部署目标在哪里？我需要知道你的 GitHub Pages 仓库地址和 Telegram chat ID。

### 步骤 4：记录部署配置

把用户的部署信息写入 SKILL.md 的「部署配置」部分，或写入 `TOOLS.md` 本地笔记。

### 可用工具
- `exec`：运行 bash 命令
- `write`：修改 SKILL.md 配置
- `web_search`：搜索 GitHub 项目（用于 category-search）
- `message`：发送 Telegram 通知
- `git` 操作：提交和推送部署

---

## 📁 文件结构

```
skills/
├── github-trending-daily/
│   ├── SKILL.md                          # 触发说明 + 工作流
│   └── scripts/
│       └── generate-github-trending.sh   # 54 行 Python，抓取 Trending 输出 JSON
├── github-category-search/
│   ├── SKILL.md                          # 触发说明 + 工作流
│   └── references/
│       └── template.html                 # HTML 报告模板
```

## 📝 许可证

MIT
