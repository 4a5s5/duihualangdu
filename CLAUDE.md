# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

这是一个部署在 Cloudflare 上的 AI 语音助手项目，集成了 AI 对话和 TTS 语音合成功能。项目采用双平台部署架构：
- **前端**: Cloudflare Pages（静态网站托管）
- **后端**: Cloudflare Workers（API 服务）+ Cloudflare Functions（备用 API）

## 核心命令

### 开发命令
```bash
# 启动 Workers 开发服务器
npm run dev
# 或
wrangler dev

# 本地预览（不依赖远程）
npm run preview
# 或  
wrangler dev --local

# 直接打开 HTML 文件进行前端开发
# 浏览器中打开 webui.html
```

### 部署命令
```bash
# 部署到生产环境
npm run deploy
# 或
wrangler deploy

# 部署到测试环境
npm run deploy:staging
# 或
wrangler deploy --env staging

# 构建项目（确保所有文件就绪）
npm run build

# 一键部署脚本
# Windows: 运行 deploy.bat
# Linux/Mac: ./deploy.sh
```

### 调试和监控
```bash
# 查看 Worker 日志
npm run tail
# 或
wrangler tail

# 准备部署环境
npm run prepare
```

## 架构结构

### 双 API 架构设计
项目实现了两套 API 系统以提供冗余和灵活性：

1. **主 API**: `workers.js` - Cloudflare Workers
   - 路径: 直接域名根路径 `/v1/audio/speech`
   - 特点: 高性能，全局分布，处理复杂的文本分块和批处理逻辑
   - 包含完整的 HTML 内容内嵌，可独立提供 Web 界面

2. **备用 API**: `functions/api/` - Cloudflare Functions 
   - 路径: `/api/v1/audio/speech`，`/api/health`
   - 特点: 基于文件的路由，更易维护和扩展
   - 提供健康检查端点

### 关键技术实现

#### TTS 处理流程
- **文本预处理**: 自动清理和分块，处理长文本（>15000字符）
- **批处理机制**: 内置并发控制避免 Cloudflare 子请求限制
- **OpenAI 兼容**: 映射 OpenAI 语音模型到 Microsoft Edge TTS
- **流式支持**: 支持流式和非流式音频输出

#### 语音模型映射
```javascript
const OPENAI_VOICE_MAP = {
  "shimmer": "zh-CN-XiaoxiaoNeural",    // 温柔女声
  "alloy": "zh-CN-YunyangNeural",       // 专业男声
  "fable": "zh-CN-YunjianNeural",       // 激情男声
  "onyx": "zh-CN-XiaoyiNeural",         // 活泼女声
  "nova": "zh-CN-YunxiNeural",          // 阳光男声
  "echo": "zh-CN-liaoning-XiaobeiNeural" // 东北女声
};
```

### 前端架构
- **单文件应用**: `webui.html` 包含完整的 Vue.js 应用
- **模块化设计**: AI 对话模式 + TTS 合成模式
- **状态管理**: 本地存储配置和对话历史
- **调试面板**: 内置 API 调用日志和错误诊断

## 配置和环境

### Workers 环境变量
```bash
# 必需
API_KEY=your-secret-api-key

# 可选：限制访问域名
ALLOWED_ORIGINS=https://your-domain.com,https://your-pages.dev
```

### 部署环境配置
- **生产环境**: `wrangler.toml` 中的 `[env.production]`
- **测试环境**: `wrangler.toml` 中的 `[env.staging]`
- **构建输出**: 根目录 `/`，无需特殊构建工具

## 开发工作流

### 本地开发
1. 修改 `webui.html` 进行前端开发
2. 修改 `workers.js` 进行 Workers API 开发
3. 修改 `functions/api/` 进行 Functions API 开发
4. 使用 `npm run dev` 启动 Workers 开发服务器

### 部署流程
1. 运行 `npm run build` 确保文件完整性
2. 前端自动部署: Git 推送触发 Pages 自动部署
3. 后端手动部署: `npm run deploy` 部署 Workers

### 调试技巧
- 使用内置调试面板查看 API 调用详情
- `wrangler tail` 查看 Workers 实时日志
- 浏览器开发者工具网络面板检查请求状态
- 健康检查端点: `/api/health`

## 安全考虑

### API 密钥验证
所有 TTS API 请求都需要 Bearer Token 认证。

### CORS 配置
```javascript
const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization',
};
```

### 安全头
项目包含 `_headers` 文件配置了完整的安全头：XSS 保护、内容类型保护、框架保护等。

## 常见问题排查

### TTS 生成失败
- 检查文本长度（建议 <15000 字符）
- 确认 API 密钥配置正确
- 查看 Workers 日志确认错误详情

### 部署失败
- 检查 `wrangler.toml` 配置
- 确认 Cloudflare 账户权限
- 运行 `npm run build` 确保文件完整性

### 性能优化
- 长文本自动分块处理，无需手动优化
- 利用 Cloudflare 全球 CDN 自动缓存和压缩
- 智能重试机制处理网络错误