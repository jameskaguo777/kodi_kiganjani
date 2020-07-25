class LoginHelper {
  final String accessToken;
  final String tokenType;
  final int statusCode;

  LoginHelper({this.accessToken, this.tokenType, this.statusCode});

  factory LoginHelper.fromJson(Map<String, dynamic> json) {
    return LoginHelper(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      statusCode: json['status_code'],
    );
  }
}
