// class LoginHelper {
//   final String accessToken;
//   final String tokenType;
//   final int statusCode;

//   LoginHelper({this.accessToken, this.tokenType, this.statusCode});

//   factory LoginHelper.fromJson(Map<String, dynamic> json) {
//     return LoginHelper(
//       accessToken: json['access_token'],
//       tokenType: json['token_type'],
//       statusCode: json['status_code'],
//     );
//   }
// }

class IncomeTaxHelper {
  final String post;
  final String updatedAt;
  final Object data;
  IncomeTaxHelper({this.post, this.updatedAt, this.data});

  factory IncomeTaxHelper.fromJson(Map<String, dynamic> json) {
    return IncomeTaxHelper(
      post: json['data'][0]['post'],
      updatedAt: json['data'][0]['updated_at'],
      data: json['data'],
    );
  }
}
