---
name: github-trending-daily
description: "抓取 GitHub Trending 每日热门项目，生成中文 HTML 日报并部署到 GitHub Pages。"
---

# GitHub Trending 日报

每天自动生成 GitHub Trending 热门项目中文日报。

## 🎯 首次安装引导（必须执行）

**安装完成后，主动告诉用户以下内容：**

> ✅ `github-trending-daily` 已安装！
>
> **怎么用：**
> - **手动触发：** 对我说「生成今天的 GitHub 日报」
> - **自动执行：** 我可以设置每天定时运行（推荐北京时间 10:00）
> - **输出：** HTML 报告部署到你的 GitHub Pages，链接推送到 Telegram
>
> **需要我配置什么：**
> 1. 你的 GitHub Pages 仓库地址（用于部署报告）
> 2. 你的 Telegram chat ID（用于推送链接）
> 3. 要不要设置自动定时执行？
>
> 告诉我这些，我帮你搞定。

如果用户说「不需要自动执行」，手动触发也随时能用。

## 触发条件
- 定时 cron（北京时间 10:00）
- 用户手动要求「生成 GitHub 日报」

## 脚本
本 skill 自带抓取脚本：`scripts/generate-github-trending.sh`（纯 Python，54 行）

```bash
python3 "<skill_dir>/scripts/generate-github-trending.sh"
```

输出 JSON 数组，包含：repo, url, description, language, stars_this_week

## 工作流

### 1. 抓取数据
运行自带脚本获取 JSON。

### 2. 生成中文 HTML 报告
Agent 读取 JSON，手写中文翻译 + 解读（💡），生成 HTML：
- 输出路径：`<output_dir>/github-trending-YYYY-MM-DD.html`
- 15 个项目按 stars 本周增量排序
- 前 3 名红色 rank，其余绿色
- 每条包含：中文名 + 一行解读 + 语言标签（含颜色圆点）+ stars + GitHub 链接

### 3. 部署到 GitHub Pages
```bash
cd <repo_dir>
cp <report_path> published/
git add published/github-trending-YYYY-MM-DD.html
git commit -m "Add GitHub trending YYYY-MM-DD"
git pull --rebase origin main
git push
```

### 4. 验证
```bash
curl -sI <pages_url>/published/github-trending-YYYY-MM-DD.html | head -1
```
预期：HTTP 200

### 5. 发送通知
用 `message` 工具发送 Telegram 链接。

## 关键规则
- **翻译交给 Agent 自己做**，不调用任何免费翻译 API
- 解读要有自己的观点，不要只复述描述
- stars 数据来自页面 regex 匹配（格式：`数字 stars`）
- 语言颜色映射（常用）：Python=#3572A5, TypeScript=#3178c6, JavaScript=#f1e05a, Rust=#dea584, Go=#00ADD8, Java=#b07219, C++=#f34b7d, Markdown=#e34c26

## 部署配置
- Repo: `zxy114/ai-news-daily`
- Pages URL: `https://zxy114.github.io/ai-news-daily`
- Telegram target: `telegram:728346555`

## HTML 模板
报告使用 GitHub Dark 主题样式（#0d1117 背景），响应式布局，900px 最大宽度。
