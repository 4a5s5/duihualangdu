#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

console.log('🔨 构建AI语音助手...');

// 确保index.html存在
if (!fs.existsSync('index.html')) {
    console.log('📄 创建index.html入口文件...');
    fs.copyFileSync('webui.html', 'index.html');
    console.log('✅ index.html创建完成');
} else {
    console.log('✅ index.html已存在');
}

// 检查必要文件
const requiredFiles = [
    'webui.html',
    'workers.js',
    '_headers',
    '_redirects'
];

console.log('📋 检查必要文件...');
let allFilesExist = true;

requiredFiles.forEach(file => {
    if (fs.existsSync(file)) {
        console.log(`✅ ${file}`);
    } else {
        console.log(`❌ ${file} 缺失`);
        allFilesExist = false;
    }
});

if (!allFilesExist) {
    console.error('❌ 构建失败：缺少必要文件');
    process.exit(1);
}

// 验证HTML文件
console.log('🔍 验证HTML文件...');
try {
    const webuiContent = fs.readFileSync('webui.html', 'utf8');
    const indexContent = fs.readFileSync('index.html', 'utf8');
    
    if (webuiContent.includes('Vue.js') && indexContent.includes('AI语音助手')) {
        console.log('✅ HTML文件验证通过');
    } else {
        console.log('⚠️ HTML文件可能有问题');
    }
} catch (error) {
    console.error('❌ HTML文件验证失败:', error.message);
    process.exit(1);
}

// 创建构建信息
const buildInfo = {
    buildTime: new Date().toISOString(),
    version: require('../package.json').version,
    files: requiredFiles.filter(file => fs.existsSync(file))
};

fs.writeFileSync('build-info.json', JSON.stringify(buildInfo, null, 2));
console.log('📝 构建信息已保存到 build-info.json');

console.log('🎉 构建完成！');
console.log('📋 构建摘要:');
console.log(`   - 版本: ${buildInfo.version}`);
console.log(`   - 时间: ${buildInfo.buildTime}`);
console.log(`   - 文件: ${buildInfo.files.length} 个`);
console.log('');
console.log('🚀 可以部署到Cloudflare Pages了！');
