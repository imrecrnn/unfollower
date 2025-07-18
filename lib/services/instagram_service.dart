import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'dart:convert';
import '../models/user_model.dart';

class InstagramService {
  // Instagram Graph API endpoints
  static const String authEndpoint = 'https://api.instagram.com/oauth/authorize';
  static const String tokenEndpoint = 'https://api.instagram.com/oauth/access_token';
  static const String graphApiEndpoint = 'https://graph.instagram.com';
  
  // Meta Developer Portal'dan aldığınız bilgileri buraya ekleyin
  static const String clientId = 'YOUR_CLIENT_ID';
  static const String clientSecret = 'YOUR_CLIENT_SECRET';
  static const String redirectUri = 'insfollow://oauth/callback';
  
  // Sadece gerekli izinleri isteyin
  static const List<String> scopes = [
    'instagram_basic',
    'instagram_public_content',
  ];

  Future<Map<String, String>> authenticate() async {
    try {
      // Construct the authorization URL with all required scopes
      final authUrl = Uri.parse(authEndpoint).replace(queryParameters: {
        'client_id': clientId,
        'redirect_uri': redirectUri,
        'scope': scopes.join(' '), // Instagram scopeları boşluk ile ayırır
        'response_type': 'code',
      });

      print('Auth URL: ${authUrl.toString()}'); // Debug için URL'i yazdır

      // Launch Instagram auth flow
      final result = await FlutterWebAuth2.authenticate(
        url: authUrl.toString(),
        callbackUrlScheme: 'insfollow',
      );

      print('Auth Result: $result'); // Debug için sonucu yazdır

      // Get the auth code
      final code = Uri.parse(result).queryParameters['code'];
      if (code == null) throw Exception('Yetkilendirme kodu alınamadı');

      // Exchange code for access token
      final tokenResponse = await http.post(
        Uri.parse(tokenEndpoint),
        body: {
          'client_id': clientId,
          'client_secret': clientSecret,
          'grant_type': 'authorization_code',
          'redirect_uri': redirectUri,
          'code': code,
        },
      );

      print('Token Response: ${tokenResponse.body}'); // Debug için token yanıtını yazdır

      if (tokenResponse.statusCode != 200) {
        throw Exception('Token alınamadı: ${tokenResponse.body}');
      }

      final tokenData = json.decode(tokenResponse.body);
      
      // Get long-lived access token
      final longLivedTokenResponse = await http.get(
        Uri.parse('$graphApiEndpoint/access_token').replace(
          queryParameters: {
            'grant_type': 'ig_exchange_token',
            'client_secret': clientSecret,
            'access_token': tokenData['access_token'],
          },
        ),
      );

      if (longLivedTokenResponse.statusCode != 200) {
        throw Exception('Uzun süreli token alınamadı: ${longLivedTokenResponse.body}');
      }

      final longLivedData = json.decode(longLivedTokenResponse.body);

      return {
        'access_token': longLivedData['access_token'],
        'user_id': tokenData['user_id'].toString(),
      };
    } catch (e) {
      print('Auth Error: $e'); // Debug için hatayı yazdır
      throw Exception('Giriş başarısız: $e');
    }
  }

  Future<Map<String, dynamic>> getUserProfile(String accessToken, String userId) async {
    final response = await http.get(
      Uri.parse('$graphApiEndpoint/$userId')
          .replace(queryParameters: {
        'fields': 'id,username,profile_picture_url,followers_count,follows_count',
        'access_token': accessToken,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Kullanıcı bilgileri alınamadı');
    }

    return json.decode(response.body);
  }

  Future<List<UserModel>> getFollowers(String accessToken, String userId) async {
    final followers = <UserModel>[];
    String? nextCursor;

    try {
      do {
        final response = await http.get(
          Uri.parse('$graphApiEndpoint/$userId/followers').replace(
            queryParameters: {
              'fields': 'id,username,profile_picture_url',
              'access_token': accessToken,
              if (nextCursor != null) 'after': nextCursor,
            },
          ),
        );

        if (response.statusCode != 200) {
          throw Exception('Takipçiler alınamadı');
        }

        final data = json.decode(response.body);
        
        for (var user in data['data']) {
          followers.add(UserModel(
            username: user['username'],
            profilePicUrl: user['profile_picture_url'] ?? '',
            fullName: user['name'],
          ));
        }

        nextCursor = data['paging']['cursors']['after'];
      } while (nextCursor != null);

      return followers;
    } catch (e) {
      throw Exception('Takipçiler yüklenirken hata: $e');
    }
  }

  Future<List<UserModel>> getFollowing(String accessToken, String userId) async {
    final following = <UserModel>[];
    String? nextCursor;

    try {
      do {
        final response = await http.get(
          Uri.parse('$graphApiEndpoint/$userId/following').replace(
            queryParameters: {
              'fields': 'id,username,profile_picture_url',
              'access_token': accessToken,
              if (nextCursor != null) 'after': nextCursor,
            },
          ),
        );

        if (response.statusCode != 200) {
          throw Exception('Takip edilenler alınamadı');
        }

        final data = json.decode(response.body);
        
        for (var user in data['data']) {
          following.add(UserModel(
            username: user['username'],
            profilePicUrl: user['profile_picture_url'] ?? '',
            fullName: user['name'],
          ));
        }

        nextCursor = data['paging']['cursors']['after'];
      } while (nextCursor != null);

      return following;
    } catch (e) {
      throw Exception('Takip edilenler yüklenirken hata: $e');
    }
  }

  Future<List<UserModel>> getNonFollowers(String accessToken, String userId) async {
    try {
      final followers = await getFollowers(accessToken, userId);
      final following = await getFollowing(accessToken, userId);

      final followerUsernames = followers.map((f) => f.username).toSet();
      return following.where((f) => !followerUsernames.contains(f.username)).toList();
    } catch (e) {
      throw Exception('Takip etmeyenler hesaplanırken hata: $e');
    }
  }

  Future<void> openProfileInInstagram(String username) async {
    final Uri url = Uri.parse('https://instagram.com/$username');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
} 