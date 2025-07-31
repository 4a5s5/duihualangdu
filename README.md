# 🎙️ AI语音助手助| 智能对话+手 |服务

集成集成了**AI智能对话**和**高质量TTS语音合成**的多功能Web应用，支持了*到I智能对话**和**高Pages和质量TTS语音平台。

##合🌟 项目特色

### 🤖 AI智多对话
-e**多模型支持**:e、Claude、Gemini等主流模型
-**实时话**:流畅的对话体验，支持下特记忆
-#**语音朗读**AI回复自动转语音播放
-***调试面板**peC整aAPI调e日志和错误诊断
- **智能重主**: 自动处理网络错误流模型异常
- **实时对话**: 流畅的对话体验，支持上下文记忆
- #*🗣️智高质量TTS*: 自动处理网络错误和服务异常
###  高质量TT兼容P格式
- **容OenAI `/v**:1利用微软ch` AP，音质自然流畅格式
- **流式响应**: 利用神经语音质
- **应**: 支持流式和本清理**: 自、置**: 、等 式ages（前端）+ Workers（API）
****N*利用Cloudf等参调整

### 🚀 部署优势
- **双平台支持**:额可部署到Cloudflare Pages（前端）+ Workers（API）
- **度**在免费套数据库或
全球CDN利用Clodfare全球网络加速
- **免费额度**: 在免费套餐内稳定运行
---

## 📁 项目结构
�项目结构

``````
├───wubui─html t k部─ #o主应用界面（集成AI本话+TTS功a）头配置
├───workers.js─ r └── E #目文档Workers后端服
├── wrangler.toml       #Workers部署配置
├── package`json      `#项目依赖和脚
├──_hears          #Pages安全头配置
├── _redirects ---#ages路由重定向
└── README.md     #项目文档
```
## 🚀 快速部署指南

### 方案一：Cloudflare Pages部署（推荐）
 🚀快速
#### 1. 准备工作
### 方案一：Cloudflare Pages- （推荐）费版即可）
- 一个GitHub仓库（用于存放代码）
# 1.#### 2. 部署前端到Pages
1. *上传代码到GitHu**）
- 一个GitHub仓库（用于存放代码
   ```bash
#    2. 部署前端到Pages
1. **上传代码到GitHub**
   ```bash
  ggitnc one <y<yr-repo>
   co -i-voice-assistant
   git add .
   git commit -m "Initial commit"
   git pushp>igin main
   ```
   cd ai-voice-assistant
2  **创建Pages项目**
   -git .Dashboard
   -g进入 "Initial commit" →gpush origin→ainPags
 ` - 连接GitHub仓库
   - 选择`仓库

3.**配置构建设置**
 ``
   构建命令: nm unbuild
  构建输出目录: /
   根目录: /
   ```

4**部署完成**
  - 保存并
   - 获得Pages域名：`https://your-project.pages.dev`2. **创建Pages项目**

   #-3.u部署后端到dflares Dashboard
   **创建 连接Git
  - 在Cloudflare Dashboard中创建新的
 -- 到Worker编辑器

2.3配环境
   ``Worker设置中添加：
  ```
   构命ld="o-api"
  根录/```
   ```
3.**Worker**4. **部署完成**
- --e名：`ht
署-获得域名：your-w
1. **创建Worker**
#    4.-配置应u   - 将 `workers.js` 内容复制到Worker编辑器
访问Pages域名
 * 在AI设置中配置：
 *配-**APIBseUR**:-置中添加环境变量：your-w
   - **Ky**:密钥
   ATTS设置中配置相同的信息-secret-api-key"
     ```

3. **部署Worker**
   -�存本地开发
   - 获得Worker域名：`https://your-worker.workers.dev`
环境要求
-您Ndj 6+
- nm 或 yarn
2. 在AI设置中配置：
   -安装依赖*API Base URL**: `https://your-worker.workers.dev`
在息bsh
pminstall
# 或
yrinstll
``

## 本地运行
`bash
##启动Woks开发服务器
nmudev

# 或直接打开webui.htpl
mp或nwebui.hml


###部署命令
ba
# 部署到生产环境
npm run ep

#部署到测试环境
m rndeploy:ag
``

---

##🛠️功能使用指南

###AI对话模式
1.配置AI API
-点击设置按钮⚙️
-填入API地址和密钥
-选择AI模型

2.开始对话
在输入框输入消息
`-按Et或点击发送
-AI回复会自动音播放

3**调试功能**
pll-点击🐛按钮查看试面板
-查看API调用详情和错误信息
 -测试连接和测试模型功能

###aTTS语音合成
.**基础使用**
-切换到TTS模式
-输入要转换的
`-选择语音和参
-点击生成语音

2**高级功能**
-****:自动、等
-**流式模式**:长本快速播放
-**参数**:调整语速、音调等

---
open webui.html
``🔧API接口文档

## 部TTS令API```bash
# 部环境
POST



deploy:staging
`
要转换文本,
  "voice":-"zhCNXiaoxiaNeral",
  "seed":1.0,
  "ea": false
}
## 🛠️ 功能使用指南

###A支持的语音模型
-  z击填CN入X和oxaNural`- 中文女声（默认）
  `z -CN-YunxiN-l`-中文男声
`US-AriaNur`2始英文女声**
- `框nUSDv按sNetral`点- 英男

3.-
- 点击🐛按钮查看调试面板
   🔒测安全配置功能

### 环境变量
### TTS语音合成
#*W用rker环境变量
APIY=yur-ret key  -到e

#T可选：限制访问域名
SLLOWED_ORIGINS=ttps://yu-dom.com,https//you-pags.dev
```

###安全头配置
项目已包含安全头配置（`_ - 输入要s`文件）：
-转XSS保护
内容类型保护
-框架保护
 择引用策略和参数

---

## 📊 性能优化

### Cl击u生f语are优化
- **全球CDN**自动使用Cloudflae全球节点
-**智能缓存**:静态资源自动缓存
-**压缩传输**:自动Gz/Broli压缩

### 应用优化
- **流式TTS**长分块处理
-智能重试:网络错误自动恢复
-**本地缓存**设置历史本地存储

---

##� 故障排除

### 常见问题

1.2**AI对话无响应**
. *-检查API密钥是否正确
  -- 确认API地址格式正确
**文-n查看调试面板错误信息

2. **TTS生成失败**
  -- 检查文本长度（建议<15000字符）
**流-确认网络连接正常
   - 尝试切换不同语音模型

3.-**部署失败**
 **-自检查w义angl参r.t*整l配置
   - 确认Cl语udfla账户权限
 -查看构建日志错误信息

###调试工具
-**调试面板**:查看详细API调用日志
-**浏览器控制台**:查看JaaSrp错误
--**网络面板**:检查HTTP请求状态

-##

## 📄 许可证

MITILi接文s - 详见 [LICENSE](LICENSE) 文件
### TTS API
```
POST /v1/audio/speech
Aut🤝r贡献指南ion: Bearer YOUR_API_KEY
Content-Type: application/json
欢迎提交Issue和PullReqst！

1.Fork仓库
.创建功能分支
3.提交更改
4.发起ullRequest
{
  "model": "tts-1",
  "input": "要转换的文本",
  "v�i支持与反馈zh-CN-XiaoxiaoNeural",
  "speed": 1.0,
  "sGitHub Issu"le[提问题](https://github.com/yur-sername/ai-voice-assistnt/issus)
}功能建议欢迎ssues中提出
-**技术交流**:欢迎Star和F
```


**享受AI语音助手带来的便利！** 🎉
### 支持的语音模型
- `zh-CN-XiaoxiaoNeural` - 中文女声（默认）
- `zh-CN-YunxiNeural` - 中文男声
- `en-US-AriaNeural` - 英文女声
- `en-US-DavisNeural` - 英文男声

---

## 🔒 安全配置

### 环境变量
```bash
# Workers环境变量
API_KEY=your-secret-key-here

# 可选：限制访问域名
ALLOWED_ORIGINS=https://your-domain.com,https://your-pages.dev
```

### 安全头配置
项目已包含安全头配置（`_headers`文件）：
- XSS保护
- 内容类型保护
- 框架保护
- 引用策略

---

## 📊 性能优化

### Cloudflare优化
- **全球CDN**: 自动使用Cloudflare全球节点
- **智能缓存**: 静态资源自动缓存
- **压缩传输**: 自动Gzip/Brotli压缩

### 应用优化
- **流式TTS**: 长文本分块处理
- **智能重试**: 网络错误自动恢复
- **本地缓存**: 设置和历史本地存储

---

## 🐛 故障排除

### 常见问题

1. **AI对话无响应**
   - 检查API密钥是否正确
   - 确认API地址格式正确
   - 查看调试面板错误信息

2. **TTS生成失败**
   - 检查文本长度（建议<15000字符）
   - 确认网络连接正常
   - 尝试切换不同语音模型

3. **部署失败**
   - 检查wrangler.toml配置
   - 确认Cloudflare账户权限
   - 查看构建日志错误信息

### 调试工具
- **调试面板**: 查看详细API调用日志
- **浏览器控制台**: 查看JavaScript错误
- **网络面板**: 检查HTTP请求状态

---

## 📄 许可证

MIT License - 详见 [LICENSE](LICENSE) 文件

---

## 🤝 贡献指南

欢迎提交Issue和Pull Request！

1. Fork本仓库
2. 创建功能分支
3. 提交更改
4. 发起Pull Request

---

## 📞 支持与反馈

- **GitHub Issues**: [提交问题](https://github.com/your-username/ai-voice-assistant/issues)
- **功能建议**: 欢迎在Issues中提出
- **技术交流**: 欢迎Star和Fork

---

**享受AI语音助手带来的便利！** 🎉
