# Frontend Configuration Guide

## 🎯 Using Remote Backend (Render)

Since you have your backend deployed on Render, follow these steps to configure the frontend:

### 1. Update Backend URL

Edit the `.env` file in the frontend directory:

```bash
# Replace with your actual Render backend URL
VITE_API_URL=https://your-backend-app.onrender.com
```

### 2. Quick Setup Commands

```bash
# Navigate to frontend directory
cd frontend

# Set your backend URL (replace with your actual URL)
echo "VITE_API_URL=https://your-backend-app.onrender.com" > .env

# Install dependencies (if not already installed)
npm install

# Start frontend development server
npm run dev
```

### 3. Using the Helper Script

```bash
# From frontend directory
./start-frontend.sh

# Or with URL as parameter
./start-frontend.sh https://your-backend-app.onrender.com
```

## 🔗 Backend URL Format

Your Render backend URL should be in the format:
- `https://your-app-name.onrender.com`
- Make sure it's the correct URL where your backend is deployed
- No trailing slash needed

## 🧪 Testing the Connection

Once the frontend is running:

1. Open http://localhost:5173
2. Try to register a new account
3. If successful, the frontend is properly connected to your backend

## 🐛 Troubleshooting

### CORS Issues
If you get CORS errors, make sure your backend's CORS configuration includes:
```javascript
app.use(cors({
  origin: ['http://localhost:5173', 'https://your-frontend-domain.com'],
  credentials: true
}));
```

### API Connection Errors
- Verify your backend URL is correct
- Check that your backend is running on Render
- Ensure all API endpoints are working

### Environment Variables
- Make sure `.env` file exists in frontend directory
- Verify `VITE_API_URL` is set correctly
- Restart the development server after changing `.env`

## 📋 Current Status

✅ Frontend: Running on http://localhost:5173
🔗 Backend: Your Render deployment
🔄 API Configuration: Using environment variables

## 🚀 Next Steps

1. Update the backend URL in `.env`
2. Test the connection
3. Start developing/testing your application
