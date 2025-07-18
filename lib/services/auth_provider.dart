import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'instagram_service.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  final instagramService = InstagramService();
  
  String? _accessToken;
  String? _userId;
  String? _username;
  bool _isLoading = false;

  bool get isAuthenticated => _accessToken != null;
  bool get isLoading => _isLoading;
  String? get username => _username;
  String? get userId => _userId;
  String? get accessToken => _accessToken;

  Future<void> loginWithInstagram() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Instagram OAuth ile giriş yap
      final authData = await instagramService.authenticate();
      final accessToken = authData['access_token']!;
      final userId = authData['user_id']!;
      
      // Kullanıcı bilgilerini al
      final userProfile = await instagramService.getUserProfile(accessToken, userId);
      
      // Bilgileri güvenli şekilde sakla
      await _storage.write(key: 'access_token', value: accessToken);
      await _storage.write(key: 'user_id', value: userId);
      await _storage.write(key: 'username', value: userProfile['username']);
      
      _accessToken = accessToken;
      _userId = userId;
      _username = userProfile['username'];
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _storage.deleteAll();
      _accessToken = null;
      _userId = null;
      _username = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> checkAuthStatus() async {
    _accessToken = await _storage.read(key: 'access_token');
    _userId = await _storage.read(key: 'user_id');
    _username = await _storage.read(key: 'username');
    notifyListeners();
  }

  Future<List<UserModel>> getNonFollowers() async {
    if (_accessToken == null || _userId == null) {
      throw Exception('Lütfen önce giriş yapın');
    }
    return instagramService.getNonFollowers(_accessToken!, _userId!);
  }
} 