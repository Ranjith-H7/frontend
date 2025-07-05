#!/bin/bash

# Frontend-only launcher for Stock Trading App
echo "🎨 Starting Frontend with Remote Backend..."

# Check if we're in the frontend directory
if [ ! -f "package.json" ] || [ ! -f "vite.config.js" ]; then
    echo "❌ Error: Please run this script from the frontend directory"
    echo "Expected files: package.json, vite.config.js"
    exit 1
fi

# Function to update backend URL
update_backend_url() {
    echo "🔧 Configuring backend URL..."
    
    if [ -z "$1" ]; then
        echo "Please enter your Render backend URL (e.g., https://your-app.onrender.com):"
        read -r BACKEND_URL
    else
        BACKEND_URL=$1
    fi
    
    # Remove trailing slash if present
    BACKEND_URL=$(echo "$BACKEND_URL" | sed 's:/*$::')
    
    # Update .env file
    echo "VITE_API_URL=$BACKEND_URL" > .env
    echo "✅ Backend URL updated to: $BACKEND_URL"
}

# Check if .env exists and has VITE_API_URL
if [ ! -f ".env" ] || ! grep -q "VITE_API_URL=" .env || grep -q "your-backend-app.onrender.com" .env; then
    echo "⚠️  Backend URL not configured or using placeholder"
    update_backend_url "$1"
fi

# Install dependencies if node_modules doesn't exist
if [ ! -d "node_modules" ]; then
    echo "📦 Installing dependencies..."
    npm install
fi

# Function to handle cleanup on exit
cleanup() {
    echo ""
    echo "🛑 Shutting down frontend server..."
    exit 0
}

# Set up signal handlers
trap cleanup SIGINT SIGTERM

echo ""
echo "✅ Frontend Configuration:"
echo "🌐 Frontend: http://localhost:5173"
echo "🔗 Backend: $(grep VITE_API_URL .env | cut -d'=' -f2)"
echo ""
echo "🚀 Starting development server..."
echo "Press Ctrl+C to stop"
echo ""

# Start frontend development server
npm run dev
