class NewBusinessHelper{
  final String post;
  final String updatedAt;
  final Object data;
  NewBusinessHelper({this.post, this.updatedAt, this.data});

  factory NewBusinessHelper.fromJson(Map<String, dynamic> json) {
    return NewBusinessHelper(
      post: json['data'][0]['post'],
      updatedAt: json['data'][0]['updated_at'],
      data: json['data'],
    );
  }
}