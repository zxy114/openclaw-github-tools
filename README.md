# OpenClaw GitHub Tools

GitHub 开源项目搜索 & 日报生成工具集 — OpenClaw 技能包。

## Skills

### 1. github-trending-daily
抓取 GitHub Trending 每日热门项目，生成中文 HTML 日报并部署到 GitHub Pages。
- 自带脚本：`scripts/generate-github-trending.sh`（54 行纯 Python）
- 输出 JSON → Agent 翻译 → HTML → 部署 → Telegram 通知

### 2. github-category-search
按关键词/大类搜索 GitHub 开源项目，生成中文 HTML 报告。
- 触发：搜索量化交易/AI 基础设施/Web 框架等
- 搜索 → 筛选 Top 10 → 手写中文 → HTML → 部署

## 安装

```bash
cd ~/.openclaw/workspace
git clone https://github.com/zxy114/openclaw-github-tools.git
cp -r openclaw-github-tools/skills/* skills/
```

## 使用

将 skills 目录复制到你的 OpenClaw `skills/` 路径下即可被 Agent 自动识别。

## 许可证

MIT
