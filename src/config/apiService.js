import axios from 'axios';
import { API_ENDPOINTS } from './api';

// Create axios instance with default config
const apiClient = axios.create({
  timeout: 10000,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Add request interceptor (removed token auth since your backend doesn't use JWT)
apiClient.interceptors.request.use(
  (config) => {
    // Add any global headers here if needed
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// Add response interceptor for global error handling
apiClient.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      // Clear auth data on unauthorized
      localStorage.removeItem('userId');
      localStorage.removeItem('username');
      localStorage.removeItem('email');
      
      // Redirect to login if not already there
      if (!window.location.pathname.includes('/login')) {
        window.location.href = '/';
      }
    }
    return Promise.reject(error);
  }
);

// API Service class
class ApiService {
  // Authentication
  static async register(userData) {
    const response = await apiClient.post(API_ENDPOINTS.REGISTER, userData);
    return response.data;
  }

  static async login(credentials) {
    const response = await apiClient.post(API_ENDPOINTS.LOGIN, credentials);
    return response.data;
  }

  static async getProfile() {
    const response = await apiClient.get(API_ENDPOINTS.USER_PROFILE(localStorage.getItem('userId')));
    return response.data;
  }

  // User Management
  static async getUserPortfolio(userId) {
    const response = await apiClient.get(API_ENDPOINTS.USER_PORTFOLIO(userId));
    return response.data;
  }

  static async getUserStats(userId) {
    const response = await apiClient.get(API_ENDPOINTS.USER_STATS(userId));
    return response.data;
  }

  static async updateUser(userId, userData) {
    const response = await apiClient.put(API_ENDPOINTS.UPDATE_USER(userId), userData);
    return response.data;
  }

  static async addBalance(userId, amount) {
    const response = await apiClient.post(API_ENDPOINTS.ADD_BALANCE, { userId, amount });
    return response.data;
  }

  // Trading
  static async buyAsset(tradeData) {
    const response = await apiClient.post(API_ENDPOINTS.BUY, tradeData);
    return response.data;
  }

  static async sellAsset(tradeData) {
    const response = await apiClient.post(API_ENDPOINTS.SELL, tradeData);
    return response.data;
  }

  // Assets
  static async getAssets(params = {}) {
    const response = await apiClient.get(API_ENDPOINTS.ASSETS, { params });
    return response.data;
  }

  static async getAsset(assetId) {
    const response = await apiClient.get(`${API_ENDPOINTS.ASSETS}/${assetId}`);
    return response.data;
  }

  static async getAssetGraphData(assetId, period = '1d') {
    const response = await apiClient.get(API_ENDPOINTS.GRAPH_DATA(assetId), {
      params: { period }
    });
    return response.data;
  }

  // Transactions
  static async getUserTransactions(userId, params = {}) {
    const response = await apiClient.get(API_ENDPOINTS.TRANSACTIONS(userId), { params });
    return response.data;
  }

  static async getTransactionStats(userId) {
    const response = await apiClient.get(`${API_ENDPOINTS.TRANSACTIONS(userId)}/stats`);
    return response.data;
  }

  // Health
  static async getHealth() {
    const response = await apiClient.get(API_ENDPOINTS.HEALTH);
    return response.data;
  }

  static async getNextUpdate() {
    const response = await apiClient.get(API_ENDPOINTS.NEXT_UPDATE);
    return response.data;
  }
}

export default ApiService;
