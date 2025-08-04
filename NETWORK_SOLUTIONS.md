# 🌐 网络访问解决方案

解决AI语音助手在不同网络环境下的访问问题。

## 🚨 问题描述

部署到Cloudflare后，某些地区用户需要VPN才能访问TTS API服务。

## 💡 解决方案

### 方案一：使用Pages Functions（推荐）

#### 优势
- ✅ 与前端同域名，无跨域问题
- ✅ 利用Cloudflare全球网络
- ✅ 国内外都可正常访问
- ✅ 无需额外配置

#### 部署步骤
1. **使用现有的Pages Functions**
   ```
   functions/api/v1/audio/speech.js  # TTS API
   functions/api/health.js           # 健康检查
   ```

2. **配置环境变量**
   在Pages设置中添加：
   ```
   API_KEY = your-secret-key
   ```

3. **更新应用配置**
   ```javascript
   // 在webui.html中配置
   config: {
     baseUrl: 'https://your-project.pages.dev/api',
     apiKey: 'your-secret-key',
     autoSelectEndpoint: true
   }
   ```

### 方案二：自定义域名

#### 配置自定义域名
1. **添加域名到Cloudflare**
   - 将域名添加到Cloudflare
   - 更新DNS服务器

2. **配置DNS记录**
   ```
   # 为Pages配置
   CNAME  api    your-project.pages.dev
   
   # 为Workers配置
   CNAME  tts    your-worker.workers.dev
   ```

3. **国内DNS优化**
   ```
   # 使用国内DNS服务商
   A      api    [国内CDN IP]
   CNAME  tts    [国内CDN域名]
   ```

### 方案三：多端点智能切换

#### 配置多个备用端点
```javascript
// 在webui.html中配置
config: {
  autoSelectEndpoint: true,
  endpoints: [
    {
      name: 'Pages Functions',
      url: 'https://your-project.pages.dev/api',
      description: '主要端点，国内外可访问'
    },
    {
      name: '自定义域名',
      url: 'https://api.yourdomain.com',
      description: '自定义域名，优化国内访问'
    },
    {
      name: '备用服务',
      url: 'https://backup-api.example.com',
      description: '备用API服务'
    }
  ]
}
```

#### 智能切换逻辑
- 自动测试所有端点健康状态
- 选择第一个可用的端点
- 失败时自动切换到备用端点

### 方案四：国内服务商部署

#### 1. 腾讯云函数
```javascript
// serverless.yml
service: ai-voice-assistant
provider:
  name: tencent
  runtime: Nodejs16.13
  region: ap-guangzhou

functions:
  tts:
    handler: index.main
    events:
      - apigw:
          path: /v1/audio/speech
          method: POST
```

#### 2. 阿里云函数计算
```yaml
# template.yml
ROSTemplateFormatVersion: '2015-09-01'
Transform: 'Aliyun::Serverless-2018-04-03'
Resources:
  ai-voice-assistant:
    Type: 'Aliyun::Serverless::Service'
    Properties:
      Description: AI语音助手
    tts:
      Type: 'Aliyun::Serverless::Function'
      Properties:
        Handler: index.handler
        Runtime: nodejs16
        CodeUri: ./
```

## 🔧 实施步骤

### 立即解决方案（5分钟）

1. **启用Pages Functions**
   ```bash
   # 确保functions目录存在
   mkdir -p functions/api/v1/audio
   
   # 部署时会自动包含Functions
   npm run deploy
   ```

2. **更新应用配置**
   ```javascript
   // 访问 https://your-project.pages.dev
   // 在设置中将API地址改为：
   // https://your-project.pages.dev/api
   ```

3. **测试访问**
   ```bash
   # 测试健康检查
   curl https://your-project.pages.dev/api/health
   
   # 测试TTS API
   curl -X POST https://your-project.pages.dev/api/v1/audio/speech \
     -H "Authorization: Bearer your-key" \
     -H "Content-Type: application/json" \
     -d '{"input":"测试","voice":"zh-CN-XiaoxiaoNeural"}'
   ```

### 长期优化方案

1. **配置自定义域名**
   - 购买域名
   - 添加到Cloudflare
   - 配置DNS记录

2. **国内CDN加速**
   - 使用腾讯云CDN
   - 配置回源到Cloudflare
   - 优化国内访问速度

3. **多地部署**
   - 国外：Cloudflare Pages/Workers
   - 国内：腾讯云/阿里云函数
   - 智能DNS解析

## 🧪 测试方法

### 网络连通性测试
```bash
# 测试不同端点
curl -I https://your-project.pages.dev/api/health
curl -I https://api.yourdomain.com/health
curl -I https://your-worker.workers.dev/health
```

### 应用内测试
1. 打开调试面板
2. 查看端点选择日志
3. 测试TTS功能
4. 检查网络请求状态

## 📊 性能对比

| 方案 | 国内访问 | 国外访问 | 部署难度 | 维护成本 |
|------|----------|----------|----------|----------|
| Pages Functions | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| 自定义域名 | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐ |
| 国内服务商 | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐ | ⭐⭐ |
| 多端点切换 | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐ |

## 🎯 推荐方案

### 个人用户
**Pages Functions** - 简单易用，无需额外配置

### 企业用户
**自定义域名 + 多端点** - 稳定可靠，可控性强

### 开发者
**多地部署** - 最佳性能，全球覆盖

## 🆘 故障排除

### 常见问题

1. **Pages Functions不工作**
   - 检查functions目录结构
   - 确认环境变量配置
   - 查看Functions日志

2. **自定义域名解析失败**
   - 检查DNS配置
   - 确认SSL证书状态
   - 测试域名解析

3. **智能切换不生效**
   - 检查健康检查端点
   - 确认超时设置
   - 查看浏览器控制台

### 调试命令
```bash
# 检查DNS解析
nslookup api.yourdomain.com

# 测试端点连通性
curl -v https://your-project.pages.dev/api/health

# 检查SSL证书
openssl s_client -connect api.yourdomain.com:443
```

---

**选择最适合您的方案，享受无障碍的AI语音服务！** 🎉
