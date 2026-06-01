---
name: github-category-search
description: "按关键词/大类搜索 GitHub 开源项目，生成中文 HTML 报告并部署到 GitHub Pages。"
---

# GitHub 大类项目搜索报告

按用户指定的关键词搜索 GitHub 热门项目，生成中文报告。

## 触发条件
用户说「搜索 XXX 类的 GitHub 项目」「生成 XXX Top N 报告」
如：量化交易、AI 基础设施、Web 框架、数据库等

## 工作流

### 1. 搜索
用 `web_search` 搜索：
```
query: "github {关键词} stars:>500"
count: 10
```
也可搜索 trending + 特定关键词组合。

### 2. 筛选整理
- 按 stars 排序，取 Top 10（或用户指定数量）
- 过滤重复/低质量/已废弃项目
- 确认每个项目的描述、stars、主要语言

### 3. 生成中文 HTML 报告
Agent 手写中文翻译 + 解读（💡），生成 HTML：
- 输出路径：`<output_dir>/{category-slug}-top10-YYYY-MM-DD.html`
- 前 3 名红色 rank，其余绿色
- 每条包含：中文名 + 一行解读 + stars + GitHub 链接

### 4. 部署
```bash
cd <repo_dir>
cp <report_path> published/
git add published/<filename>.html
git commit -m "Add <category> report YYYY-MM-DD"
git pull --rebase origin main
git push
```

### 5. 验证
```bash
curl -sI <pages_url>/published/<filename>.html | head -1
```

### 6. 发送通知
用 `message` 工具发送 Telegram 链接。

## HTML 模板
参考 `references/template.html` 的样式结构，与 github-trending-daily 共用相同 CSS。

## 部署配置
- Repo: `zxy114/ai-news-daily`
- Pages URL: `https://zxy114.github.io/ai-news-daily`
- Telegram target: `telegram:728346555`
