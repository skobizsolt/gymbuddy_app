import './global.dart';

class Endpoints {
  final String _url = Global.url;

  // Auth-controller
  String get login => '$_url/auth/login';

  String get register => '$_url/auth/register';

  String verifyVerification(String token) =>
      '$_url/auth/verify-verification?token=$token';

  String resendVerification(String token) =>
      '$_url/auth/resend-verification?token=$token';

  String get resetPassword => '$_url/auth/reset-password';

  String savePassword(String token) => '$_url/auth/save-password?token=$token';

  String get changePassword => '$_url/auth/change-password';

  // User-controller
  String getOrUpdateUser(int userId) => '$getUsers/$userId/profile';

  String get getUsers => '$_url/users';
}
