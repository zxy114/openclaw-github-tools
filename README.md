# OpenClaw GitHub Tools

GitHub 开源项目搜索 & 日报生成工具集 — Agent 技能包。

---

## 📖 快速了解

这套技能包让你的 AI Agent 自动完成：
1. **每天抓取 GitHub Trending** 热门项目 → 翻译成中文 → 生成 HTML 日报 → 部署到静态托管 → 推送通知
2. **按关键词搜索 GitHub 项目**（如「量化交易」「AI 基础设施」「Web 框架」）→ 生成 Top 10 中文报告 → 部署 + 通知

### 效果示例
- 日报：https://zxy114.github.io/ai-news-daily/published/github-trending-2026-06-01.html
- 大类报告：https://zxy114.github.io/ai-news-daily/published/quant-trading-top10-2026-06-01.html

---

## 🛠️ 技能列表（可按需单独安装）

### 1. `github-trending-daily` — 每日 Trending 日报

| 项目 | 说明 |
|------|------|
| **触发方式** | 定时任务 或 手动要求 |
| **工作流程** | 脚本抓 JSON → Agent 手写中文翻译 → 生成 HTML → git push 部署 → 通知 |
| **输出内容** | 15 个热门项目，按本周 star 增量排序，带中文解读和语言标签 |
| **核心脚本** | `scripts/generate-github-trending.sh`（54 行纯 Python，无依赖） |
| **翻译策略** | Agent 自行翻译（不调用第三方翻译 API，质量更高） |

**适合谁？** 想每天自动收到一份 GitHub 热门项目中文日报。

### 2. `github-category-search` — 按大类搜索项目

| 项目 | 说明 |
|------|------|
| **触发方式** | 用户说「搜索 XXX 类的 GitHub 项目」 |
| **工作流程** | 搜索 → 筛选 Top 10 → Agent 手写中文 → HTML → 部署 → 通知 |
| **输出内容** | Top 10 项目，按 star 数排序，带中文解读 |
| **参考模板** | `references/template.html`（HTML 报告模板） |

**适合谁？** 想随时搜索某个领域（量化交易、AI 基建、Web 框架…）的 GitHub 热门项目。

**搜索示例：**
- 「搜索量化交易的 GitHub 项目」
- 「生成 AI 基础设施 Top 10 报告」
- 「找 Web 框架类的热门项目」

---

## 📋 前提条件

- **你需要有一个 AI Agent**（OpenClaw、Claude Desktop 或其他支持 skill 的 Agent 运行时）
- **如果用于自动部署**：需要一个静态托管服务（如 GitHub Pages）+ 通知渠道配置
- **如果只是查看**：脚本本身只输出 JSON，不需要任何其他依赖

> 💡 **不是 OpenClaw 用户？** 核心抓取脚本 `generate-github-trending.sh` 是纯 Python，任何环境都能运行。SKILL.md 里的说明人类也能直接看懂，照着流程手动操作即可。

---

## 👤 人类安装指南

### 安装全部（两个技能都要）

```bash
cd <你的skills目录>
git clone https://github.com/zxy114/openclaw-github-tools.git tmp-gh-tools
cp -r tmp-gh-tools/skills/* .
rm -rf tmp-gh-tools
```

### 只安装日报（github-trending-daily）

```bash
cd <你的skills目录>
mkdir -p github-trending-daily/scripts
curl -sL "https://raw.githubusercontent.com/zxy114/openclaw-github-tools/main/skills/github-trending-daily/SKILL.md" -o github-trending-daily/SKILL.md
curl -sL "https://raw.githubusercontent.com/zxy114/openclaw-github-tools/main/skills/github-trending-daily/scripts/generate-github-trending.sh" -o github-trending-daily/scripts/generate-github-trending.sh
chmod +x github-trending-daily/scripts/generate-github-trending.sh
```

### 只安装搜索（github-category-search）

```bash
cd <你的skills目录>
mkdir -p github-category-search/references
curl -sL "https://raw.githubusercontent.com/zxy114/openclaw-github-tools/main/skills/github-category-search/SKILL.md" -o github-category-search/SKILL.md
curl -sL "https://raw.githubusercontent.com/zxy114/openclaw-github-tools/main/skills/github-category-search/references/template.html" -o github-category-search/references/template.html
```

### 部署配置（按需修改）

安装后需要让 Agent 知道你的部署目标。在对应 SKILL.md 中修改「部署配置」部分，或直接在对话里告诉 Agent。

---

### 💬 发给你的 Agent

复制下面的话，发给你的 AI Agent：

**安装全部：**
> 帮我安装这两个 skill，来源：https://github.com/zxy114/openclaw-github-tools
> 1. `github-trending-daily` — 每日 GitHub Trending 日报
> 2. `github-category-search` — 按关键词搜索 GitHub 项目
> 安装完成后告诉我，并确认部署目标配置。

**只安装日报：**
> 帮我安装这个 skill：`github-trending-daily`（每日 GitHub Trending 日报）
> 来源：https://github.com/zxy114/openclaw-github-tools/tree/main/skills/github-trending-daily
> 安装完成后告诉我，并确认部署目标配置。

**只安装搜索：**
> 帮我安装这个 skill：`github-category-search`（按关键词搜索 GitHub 项目）
> 来源：https://github.com/zxy114/openclaw-github-tools/tree/main/skills/github-category-search
> 安装完成后告诉我。

---

## 🤖 Agent 自动安装指南

> 如果你是另一个 Agent，收到用户分享的链接，按以下步骤自动安装。

### 步骤 1：克隆并安装

```bash
cd <你的skills目录>
git clone https://github.com/zxy114/openclaw-github-tools.git tmp-gh-tools
cp -r tmp-gh-tools/skills/* .
rm -rf tmp-gh-tools
```

### 步骤 2：确认安装成功

```bash
ls -la github-trending-daily/ github-category-search/
cat github-trending-daily/SKILL.md
```

确保目录存在、SKILL.md 内容完整、脚本可执行。

### 步骤 3：向用户确认

告诉用户：
> ✅ 已安装 `github-trending-daily` 和 `github-category-search`。
> 你可以对我说：
> - 「生成今天的 GitHub 日报」
> - 「搜索量化交易的 GitHub 项目」
>
> 部署目标在哪里？我需要知道你的静态托管地址和通知渠道。

### 步骤 4：记录部署配置

把用户的部署信息写入 SKILL.md 的「部署配置」部分。

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
