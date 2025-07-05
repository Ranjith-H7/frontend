#!/bin/bash

# Frontend Deployment Script
echo "🚀 Stock Trading App - Frontend Deployment"
echo "========================================="

# Check if we're in the frontend directory
if [ ! -f "package.json" ] || [ ! -f "vite.config.js" ]; then
    echo "❌ Error: Please run this script from the frontend directory"
    exit 1
fi

# Function to build the application
build_app() {
    echo "🔨 Building application for production..."
    npm run build
    
    if [ $? -eq 0 ]; then
        echo "✅ Build completed successfully!"
        echo "📁 Build output: dist/ folder"
        echo "📊 Bundle size: $(du -sh dist/ | cut -f1)"
    else
        echo "❌ Build failed!"
        exit 1
    fi
}

# Function to preview the build
preview_build() {
    echo "🔍 Starting production preview..."
    echo "🌐 Preview URL: http://localhost:4173"
    echo "Press Ctrl+C to stop preview"
    npm run preview
}

# Function to deploy to Vercel
deploy_vercel() {
    if command -v vercel &> /dev/null; then
        echo "🚀 Deploying to Vercel..."
        vercel --prod
    else
        echo "⚠️  Vercel CLI not found. Install with: npm install -g vercel"
        echo "📋 Manual deployment: Upload dist/ folder to vercel.com"
    fi
}

# Function to deploy to Netlify
deploy_netlify() {
    if command -v netlify &> /dev/null; then
        echo "🚀 Deploying to Netlify..."
        netlify deploy --prod --dir=dist
    else
        echo "⚠️  Netlify CLI not found. Install with: npm install -g netlify-cli"
        echo "📋 Manual deployment: Upload dist/ folder to netlify.com"
    fi
}

# Function to show deployment options
show_options() {
    echo ""
    echo "📦 Build completed! Choose deployment option:"
    echo "1) Preview build locally"
    echo "2) Deploy to Vercel"
    echo "3) Deploy to Netlify"
    echo "4) Manual deployment (show instructions)"
    echo "5) Exit"
    echo ""
    read -p "Choose option (1-5): " choice
    
    case $choice in
        1) preview_build ;;
        2) deploy_vercel ;;
        3) deploy_netlify ;;
        4) show_manual_instructions ;;
        5) echo "👋 Goodbye!"; exit 0 ;;
        *) echo "❌ Invalid option"; show_options ;;
    esac
}

# Function to show manual deployment instructions
show_manual_instructions() {
    echo ""
    echo "📋 Manual Deployment Instructions:"
    echo "=================================="
    echo ""
    echo "1. 📁 Upload the entire 'dist/' folder contents to your web host"
    echo "2. 🌐 Common hosting services:"
    echo "   - GitHub Pages: Push to gh-pages branch"
    echo "   - cPanel: Upload to public_html folder"
    echo "   - Firebase: firebase deploy"
    echo "   - AWS S3: Upload to S3 bucket with static hosting"
    echo ""
    echo "3. 🔧 Configure your backend CORS to allow your new domain"
    echo "4. 🧪 Test the deployed application"
    echo ""
    echo "📂 Files to upload:"
    ls -la dist/
    echo ""
}

# Main execution
echo "🔧 Current backend URL: $(grep VITE_API_URL .env | cut -d'=' -f2)"
echo ""

# Check if dist folder exists
if [ -d "dist" ]; then
    echo "📁 Existing build found in dist/"
    read -p "🔄 Rebuild application? (y/N): " rebuild
    if [[ $rebuild =~ ^[Yy]$ ]]; then
        build_app
    else
        echo "✅ Using existing build"
    fi
else
    build_app
fi

show_options
