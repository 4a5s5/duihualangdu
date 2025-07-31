#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

console.log('🛠️ 准备AI语音助手部署环境...');

// 创建必要的目录
const directories = [
    'scripts',
    '.github/workflows'
];

directories.forEach(dir => {
    if (!fs.existsSync(dir)) {
        fs.mkdirSync(dir, { recursive: true });
        console.log(`📁 创建目录: ${dir}`);
    }
});

// 检查关键配置文件
const configFiles = [
    'wrangler.toml',
    'package.json',
    '_headers',
    '_redirects',
    '.gitignore'
];

console.log('📋 检查配置文件...');
configFiles.forEach(file => {
    if (fs.existsSync(file)) {
        console.log(`✅ ${file}`);
    } else {
        console.log(`⚠️ ${file} 不存在，可能需要手动创建`);
    }
});

// 检查核心文件
const coreFiles = [
    'webui.html',
    'workers.js',
    'README.md'
];

console.log('📋 检查核心文件...');
let coreFilesOk = true;
coreFiles.forEach(file => {
    if (fs.existsSync(file)) {
        console.log(`✅ ${file}`);
    } else {
        console.log(`❌ ${file} 缺失`);
        coreFilesOk = false;
    }
});

if (!coreFilesOk) {
    console.error('❌ 核心文件缺失，请检查项目完整性');
    process.exit(1);
}

// 验证package.json
try {
    const pkg = require('../package.json');
    if (pkg.name && pkg.version && pkg.scripts) {
        console.log(`✅ package.json 验证通过 (${pkg.name} v${pkg.version})`);
    } else {
        console.log('⚠️ package.json 可能配置不完整');
    }
} catch (error) {
    console.error('❌ package.json 验证失败:', error.message);
}

// 检查Git仓库
if (fs.existsSync('.git')) {
    console.log('✅ Git仓库已初始化');
} else {
    console.log('⚠️ 未检测到Git仓库，建议运行: git init');
}

console.log('');
console.log('🎉 环境准备完成！');
console.log('');
console.log('📋 下一步操作:');
console.log('1. 确保所有配置文件正确');
console.log('2. 设置Cloudflare API令牌');
console.log('3. 运行 npm run build 构建项目');
console.log('4. 运行 npm run deploy 部署到Cloudflare');
console.log('');
console.log('📖 详细部署指南请查看 DEPLOYMENT.md');
