class UserModel {
  final String username;
  final String profilePicUrl;
  final String? fullName;

  UserModel({
    required this.username,
    required this.profilePicUrl,
    this.fullName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] as String,
      profilePicUrl: json['profile_picture_url'] as String? ?? '',
      fullName: json['full_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'profile_picture_url': profilePicUrl,
      'full_name': fullName,
    };
  }
} 