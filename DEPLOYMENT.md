# 🚀 部署指南

本文档详细介绍如何将AI语音助手部署到Cloudflare平台。

## 📋 部署前准备

### 必需账户
- [Cloudflare账户](https://dash.cloudflare.com/sign-up)（免费版即可）
- [GitHub账户](https://github.com)（用于代码托管）

### 本地环境
- Node.js 16+ 
- npm 或 yarn
- Git

## 🎯 部署方案选择

### 方案一：自动部署（推荐）
使用GitHub Actions自动部署到Cloudflare Pages和Workers

### 方案二：手动部署
通过Cloudflare Dashboard手动部署

### 方案三：命令行部署
使用Wrangler CLI工具部署

---

## 🤖 方案一：自动部署

### 1. 准备代码仓库
```bash
# 克隆或下载项目代码
git clone <your-repo-url>
cd ai-voice-assistant

# 推送到您的GitHub仓库
git remote add origin https://github.com/your-username/ai-voice-assistant.git
git push -u origin main
```

### 2. 配置Cloudflare API令牌
1. 访问 [Cloudflare API令牌页面](https://dash.cloudflare.com/profile/api-tokens)
2. 点击"创建令牌"
3. 使用"自定义令牌"模板
4. 配置权限：
   ```
   账户 - Cloudflare Workers:编辑
   区域 - 区域:读取
   账户 - Cloudflare Pages:编辑
   ```
5. 复制生成的API令牌

### 3. 配置GitHub Secrets
在GitHub仓库设置中添加以下Secrets：
```
CLOUDFLARE_API_TOKEN = 您的Cloudflare API令牌
CLOUDFLARE_ACCOUNT_ID = 您的Cloudflare账户ID
API_KEY = 您自定义的API密钥（用于Workers认证）
```

### 4. 触发部署
推送代码到main分支即可自动触发部署：
```bash
git add .
git commit -m "Deploy AI Voice Assistant"
git push origin main
```

---

## 🖱️ 方案二：手动部署

### 1. 部署Workers
1. 登录 [Cloudflare Dashboard](https://dash.cloudflare.com)
2. 进入 **Workers 和 Pages**
3. 点击 **创建应用程序** → **创建Worker**
4. 输入Worker名称（如：`ai-voice-assistant-api`）
5. 点击 **部署**
6. 在编辑器中粘贴 `workers.js` 的完整内容
7. 点击 **保存并部署**

### 2. 配置Workers环境变量
1. 在Worker页面点击 **设置** → **变量**
2. 在 **环境变量** 部分添加：
   ```
   API_KEY = your-secret-api-key-here
   ```
3. 点击 **保存**

### 3. 部署Pages
1. 在Cloudflare Dashboard中进入 **Workers 和 Pages**
2. 点击 **创建应用程序** → **Pages**
3. 选择 **连接到Git**
4. 选择您的GitHub仓库
5. 配置构建设置：
   ```
   构建命令: npm run build
   构建输出目录: /
   根目录: /
   ```
6. 点击 **保存并部署**

---

## 💻 方案三：命令行部署

### 1. 安装Wrangler CLI
```bash
npm install -g wrangler
# 或
npm install wrangler --save-dev
```

### 2. 登录Cloudflare
```bash
wrangler login
```

### 3. 配置项目
编辑 `wrangler.toml` 文件，确保配置正确：
```toml
name = "ai-voice-assistant"
main = "workers.js"
compatibility_date = "2024-01-01"
```

### 4. 设置环境变量
```bash
# 设置API密钥
wrangler secret put API_KEY
# 输入您的密钥值
```

### 5. 部署Workers
```bash
# 部署到生产环境
wrangler deploy

# 或部署到测试环境
wrangler deploy --env staging
```

### 6. 部署Pages
Pages需要通过Dashboard或GitHub集成部署，CLI暂不支持直接部署。

---

## 🔧 部署后配置

### 1. 获取部署地址
- **Workers地址**: `https://your-worker-name.your-subdomain.workers.dev`
- **Pages地址**: `https://your-project-name.pages.dev`

### 2. 配置应用
1. 访问Pages地址
2. 在AI设置中配置：
   - **API Base URL**: Workers地址
   - **API Key**: 您设置的密钥
3. 在TTS设置中配置相同信息

### 3. 测试功能
- 测试AI对话功能
- 测试TTS语音合成
- 检查调试面板日志

---

## 🔍 故障排除

### 常见部署问题

#### 1. Workers部署失败
```bash
# 检查配置
wrangler whoami
wrangler dev --local

# 查看详细错误
wrangler tail
```

#### 2. Pages构建失败
- 检查 `package.json` 中的构建脚本
- 确认Node.js版本兼容性
- 查看构建日志中的错误信息

#### 3. API调用失败
- 确认Workers环境变量设置正确
- 检查API密钥格式
- 查看Workers日志：`wrangler tail`

### 调试工具
- **Wrangler日志**: `wrangler tail`
- **Pages构建日志**: 在Dashboard中查看
- **浏览器开发者工具**: 检查网络请求

---

## 📊 性能优化

### Cloudflare优化
- 启用Brotli压缩
- 配置缓存规则
- 使用自定义域名

### 应用优化
- 启用流式TTS
- 配置合适的并发数
- 优化文本分块大小

---

## 🔒 安全配置

### Workers安全
```javascript
// 在workers.js中添加CORS配置
const corsHeaders = {
  'Access-Control-Allow-Origin': 'https://your-pages-domain.pages.dev',
  'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization',
};
```

### Pages安全
确保 `_headers` 文件配置正确：
```
/*
  X-Frame-Options: DENY
  X-Content-Type-Options: nosniff
  X-XSS-Protection: 1; mode=block
```

---

## 📈 监控和维护

### 监控指标
- Workers请求数和错误率
- Pages访问量和加载时间
- API响应时间

### 日常维护
- 定期检查错误日志
- 更新依赖版本
- 监控配额使用情况

---

## 🆘 获取帮助

- **Cloudflare文档**: [workers.cloudflare.com](https://workers.cloudflare.com)
- **GitHub Issues**: 在项目仓库中提交问题
- **社区支持**: Cloudflare Discord社区

---

**祝您部署顺利！** 🎉
