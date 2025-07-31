#!/bin/bash

# AI语音助手部署脚本
# 用于快速部署到Cloudflare Pages和Workers

set -e

echo "🎙️ AI语音助手部署脚本"
echo "========================"

# 检查必要工具
check_dependencies() {
    echo "📋 检查依赖..."
    
    if ! command -v node &> /dev/null; then
        echo "❌ Node.js 未安装，请先安装 Node.js 16+"
        exit 1
    fi
    
    if ! command -v npm &> /dev/null; then
        echo "❌ npm 未安装"
        exit 1
    fi
    
    echo "✅ 依赖检查完成"
}

# 安装依赖
install_dependencies() {
    echo "📦 安装项目依赖..."
    npm install
    echo "✅ 依赖安装完成"
}

# 部署Workers
deploy_workers() {
    echo "🚀 部署Cloudflare Workers..."
    
    if [ ! -f "wrangler.toml" ]; then
        echo "❌ wrangler.toml 文件不存在"
        exit 1
    fi
    
    # 检查是否已登录
    if ! npx wrangler whoami &> /dev/null; then
        echo "🔐 请先登录Cloudflare..."
        npx wrangler login
    fi
    
    # 部署Workers
    npx wrangler deploy
    echo "✅ Workers部署完成"
}

# 准备Pages部署
prepare_pages() {
    echo "📄 准备Pages部署文件..."
    
    # 创建index.html作为入口文件
    if [ ! -f "index.html" ]; then
        cp webui.html index.html
        echo "✅ 创建index.html入口文件"
    fi
    
    echo "✅ Pages文件准备完成"
}

# 显示部署信息
show_deployment_info() {
    echo ""
    echo "🎉 部署完成！"
    echo "=============="
    echo ""
    echo "📋 下一步操作："
    echo "1. 访问Cloudflare Dashboard"
    echo "2. 进入 Workers 和 Pages → 创建应用程序 → Pages"
    echo "3. 连接您的GitHub仓库"
    echo "4. 配置构建设置："
    echo "   - 构建命令: npm run build"
    echo "   - 构建输出目录: /"
    echo "   - 根目录: /"
    echo ""
    echo "🔧 配置Workers环境变量："
    echo "   API_KEY = 您的密钥"
    echo ""
    echo "📱 使用说明："
    echo "   - Pages域名: https://your-project.pages.dev"
    echo "   - Workers域名: https://your-worker.workers.dev"
    echo "   - 在应用中配置API地址和密钥即可使用"
    echo ""
}

# 主函数
main() {
    echo "选择部署选项："
    echo "1. 完整部署（Workers + 准备Pages文件）"
    echo "2. 仅部署Workers"
    echo "3. 仅准备Pages文件"
    echo "4. 安装依赖"
    
    read -p "请选择 (1-4): " choice
    
    case $choice in
        1)
            check_dependencies
            install_dependencies
            deploy_workers
            prepare_pages
            show_deployment_info
            ;;
        2)
            check_dependencies
            install_dependencies
            deploy_workers
            ;;
        3)
            prepare_pages
            echo "✅ Pages文件准备完成，请手动部署到Cloudflare Pages"
            ;;
        4)
            check_dependencies
            install_dependencies
            ;;
        *)
            echo "❌ 无效选择"
            exit 1
            ;;
    esac
}

# 运行主函数
main
