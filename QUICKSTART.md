# ⚡ 快速开始

5分钟部署AI语音助手到Cloudflare！

## 🚀 一键部署

### Windows用户
```cmd
# 双击运行
deploy.bat
```

### Linux/Mac用户
```bash
# 给脚本执行权限
chmod +x deploy.sh

# 运行部署脚本
./deploy.sh
```

## 📋 手动部署步骤

### 1. 克隆项目
```bash
git clone <your-repo-url>
cd ai-voice-assistant
```

### 2. 安装依赖
```bash
npm install
```

### 3. 准备环境
```bash
npm run prepare
```

### 4. 构建项目
```bash
npm run build
```

### 5. 部署Workers
```bash
# 登录Cloudflare
npx wrangler login

# 设置API密钥
npx wrangler secret put API_KEY

# 部署
npm run deploy
```

### 6. 部署Pages
1. 访问 [Cloudflare Dashboard](https://dash.cloudflare.com)
2. 进入 **Workers 和 Pages** → **创建应用程序** → **Pages**
3. 连接GitHub仓库
4. 配置构建设置：
   - 构建命令: `npm run build`
   - 构建输出目录: `/`

## 🔧 配置应用

### 1. 获取部署地址
- Workers: `https://your-worker.workers.dev`
- Pages: `https://your-project.pages.dev`

### 2. 配置API
1. 访问Pages地址
2. 在AI设置中填入Workers地址和API密钥
3. 在TTS设置中填入相同信息

## ✅ 测试功能

### AI对话测试
1. 切换到AI对话模式
2. 输入"你好"测试
3. 检查是否有语音播放

### TTS测试
1. 切换到TTS模式
2. 输入测试文本
3. 点击生成语音

## 🐛 常见问题

### Q: Workers部署失败
A: 检查是否已登录：`npx wrangler whoami`

### Q: Pages构建失败
A: 确认Node.js版本 >= 16

### Q: API调用失败
A: 检查API密钥和地址配置

## 📞 获取帮助

- 查看 [完整文档](README.md)
- 查看 [部署指南](DEPLOYMENT.md)
- 提交 [GitHub Issue](https://github.com/your-username/ai-voice-assistant/issues)

---

**开始享受AI语音助手吧！** 🎉
