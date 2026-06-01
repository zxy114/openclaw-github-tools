---
name: github-trending-daily
description: "抓取 GitHub Trending 每日热门项目，生成中文日报，支持聊天输出/HTML/部署上线。"
---

# GitHub Trending 日报

每天自动生成 GitHub Trending 热门项目中文日报。

## 🎯 首次安装引导（必须执行）

**安装完成后，主动告诉用户以下内容：**

> ✅ `github-trending-daily` 已安装！
>
> **怎么用：**
> - **手动触发：** 对我说「生成今天的 GitHub 日报」
> - **自动执行：** 我可以设置每天定时运行（推荐时间由你定）
> - **输出方式（任选）：**
>   - 🗨️ **聊天直接看** — 我在对话里列出项目清单（零配置，开箱即用）
>   - 📄 **HTML 文件** — 生成 HTML 文件，可本地查看
>   - 🌐 **部署上线** — 部署到静态托管平台（如 GitHub Pages），链接推送通知（需配置地址）
>
> **需要我配置什么：**
> 1. 输出方式？（聊天看 / HTML 文件 / 部署上线）
> 2. 如果要部署，告诉我托管地址
> 3. 要不要设置自动定时执行？
>
> **零配置开箱即用**——搜完直接聊天给你看。
> 只有想部署上线时才需要额外配置。
> 告诉我你的偏好，我帮你搞定。

如果用户说「不需要自动执行」，手动触发也随时能用。

## 触发条件
- 定时任务
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

### 2. 生成中文内容
Agent 读取 JSON，手写中文翻译 + 解读（💡）：

**聊天模式（零配置）：** 直接在对话里输出格式化的项目列表

**HTML 模式：** 生成 HTML 文件
- 输出路径：`<output_dir>/github-trending-YYYY-MM-DD.html`
- 15 个项目按 stars 本周增量排序
- 前 3 名红色 rank，其余绿色
- 每条包含：中文名 + 一行解读 + 语言标签（含颜色圆点）+ stars + GitHub 链接

### 3. 部署（可选）
```bash
cd <repo_dir>
cp <report_path> published/
git add published/github-trending-YYYY-MM-DD.html
git commit -m "Add GitHub trending YYYY-MM-DD"
git pull --rebase origin main
git push
```

### 4. 验证（仅部署时）
```bash
curl -sI <pages_url>/published/github-trending-YYYY-MM-DD.html | head -1
```
预期：HTTP 200

### 5. 发送通知（可选）
通过当前对话渠道发送报告链接。

## 关键规则
- **翻译交给 Agent 自己做**，不调用任何免费翻译 API
- 解读要有自己的观点，不要只复述描述
- stars 数据来自页面 regex 匹配（格式：`数字 stars`）
- 语言颜色映射（常用）：Python=#3572A5, TypeScript=#3178c6, JavaScript=#f1e05a, Rust=#dea584, Go=#00ADD8, Java=#b07219, C++=#f34b7d, Markdown=#e34c26

## 部署配置（可选，仅部署上线时需要）
- Repo: `<用户自定义>`
- Pages URL: `<用户自定义>`

## HTML 模板
报告使用 GitHub Dark 主题样式（#0d1117 背景），响应式布局，900px 最大宽度。
