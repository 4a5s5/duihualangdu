@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo 🎙️ AI语音助手部署脚本
echo ========================

:check_dependencies
echo 📋 检查依赖...

where node >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Node.js 未安装，请先安装 Node.js 16+
    pause
    exit /b 1
)

where npm >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ npm 未安装
    pause
    exit /b 1
)

echo ✅ 依赖检查完成

:main_menu
echo.
echo 选择部署选项：
echo 1. 完整部署（Workers + 准备Pages文件）
echo 2. 仅部署Workers
echo 3. 仅准备Pages文件
echo 4. 安装依赖
echo 5. 退出

set /p choice="请选择 (1-5): "

if "%choice%"=="1" goto full_deploy
if "%choice%"=="2" goto deploy_workers_only
if "%choice%"=="3" goto prepare_pages_only
if "%choice%"=="4" goto install_deps_only
if "%choice%"=="5" goto end
echo ❌ 无效选择
goto main_menu

:install_dependencies
echo 📦 安装项目依赖...
call npm install
if %errorlevel% neq 0 (
    echo ❌ 依赖安装失败
    pause
    exit /b 1
)
echo ✅ 依赖安装完成
goto :eof

:deploy_workers
echo 🚀 部署Cloudflare Workers...

if not exist "wrangler.toml" (
    echo ❌ wrangler.toml 文件不存在
    pause
    exit /b 1
)

echo 🔐 检查Cloudflare登录状态...
call npx wrangler whoami >nul 2>&1
if %errorlevel% neq 0 (
    echo 🔐 请先登录Cloudflare...
    call npx wrangler login
)

echo 🚀 开始部署Workers...
call npx wrangler deploy
if %errorlevel% neq 0 (
    echo ❌ Workers部署失败
    pause
    exit /b 1
)
echo ✅ Workers部署完成
goto :eof

:prepare_pages
echo 📄 准备Pages部署文件...

if not exist "index.html" (
    copy "webui.html" "index.html" >nul
    echo ✅ 创建index.html入口文件
)

echo ✅ Pages文件准备完成
goto :eof

:show_deployment_info
echo.
echo 🎉 部署完成！
echo ==============
echo.
echo 📋 下一步操作：
echo 1. 访问Cloudflare Dashboard
echo 2. 进入 Workers 和 Pages → 创建应用程序 → Pages
echo 3. 连接您的GitHub仓库
echo 4. 配置构建设置：
echo    - 构建命令: npm run build
echo    - 构建输出目录: /
echo    - 根目录: /
echo.
echo 🔧 配置Workers环境变量：
echo    API_KEY = 您的密钥
echo.
echo 📱 使用说明：
echo    - Pages域名: https://your-project.pages.dev
echo    - Workers域名: https://your-worker.workers.dev
echo    - 在应用中配置API地址和密钥即可使用
echo.
goto :eof

:full_deploy
call :install_dependencies
call :deploy_workers
call :prepare_pages
call :show_deployment_info
goto end

:deploy_workers_only
call :install_dependencies
call :deploy_workers
goto end

:prepare_pages_only
call :prepare_pages
echo ✅ Pages文件准备完成，请手动部署到Cloudflare Pages
goto end

:install_deps_only
call :install_dependencies
goto end

:end
echo.
echo 按任意键退出...
pause >nul
