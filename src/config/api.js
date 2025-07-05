// API Configuration
const isDevelopment = import.meta.env.MODE === 'development';
const isProduction = import.meta.env.PROD;

// API Base URL - Your actual Render backend URL
export const API_BASE_URL = import.meta.env.VITE_API_URL || 
  'https://backend-4yki.onrender.com';

// API Endpoints
export const API_ENDPOINTS = {
  // Authentication
  REGISTER: `${API_BASE_URL}/api/auth/register`,
  LOGIN: `${API_BASE_URL}/api/auth/login`,
  
  // User Management
  USER_PROFILE: (userId) => `${API_BASE_URL}/api/users/${userId}`,
  UPDATE_USER: (userId) => `${API_BASE_URL}/api/users/${userId}`,
  USER_PORTFOLIO: (userId) => `${API_BASE_URL}/api/users/${userId}/portfolio`,
  USER_STATS: (userId) => `${API_BASE_URL}/api/users/${userId}/stats`,
  
  // Portfolio
  PORTFOLIO: (userId) => `${API_BASE_URL}/api/portfolio/${userId}`,
  BUY: `${API_BASE_URL}/api/buy`,
  SELL: `${API_BASE_URL}/api/sell`,
  ADD_BALANCE: `${API_BASE_URL}/api/add-balance`,
  
  // Assets
  ASSETS: `${API_BASE_URL}/api/assets`,
  GRAPH_DATA: (assetId) => `${API_BASE_URL}/api/graphdata/${assetId}`,
  TRANSACTIONS: (userId) => `${API_BASE_URL}/api/transactions/${userId}`,
  NEXT_UPDATE: `${API_BASE_URL}/api/next-update`,
  
  // Health
  HEALTH: `${API_BASE_URL}/health`
};

export default {
  API_BASE_URL,
  API_ENDPOINTS,
  isDevelopment,
  isProduction
};
