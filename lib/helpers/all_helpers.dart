class TaxCalculatorHelper {
  final List<dynamic> taxCal;

  TaxCalculatorHelper({this.taxCal});

  factory TaxCalculatorHelper.fromJson(Map<String, dynamic> json) {
    return TaxCalculatorHelper(
      taxCal: json['data'],
    );
  }
}

class NewsPostHelper {
  // final String post;
  // final String updatedAt;
  final List<dynamic> data;
  NewsPostHelper({this.data});

  factory NewsPostHelper.fromJson(Map<String, dynamic> json) {
    return NewsPostHelper(
      // post: json['data'][0]['post'],
      // updatedAt: json['data'][0]['updated_at'],
      data: json['data'],
    );
  }
}

class AboutInfoHelper {
  final String post;
  final String updatadAt;

  AboutInfoHelper({this.post, this.updatadAt});

  factory AboutInfoHelper.fromJson(Map<String, dynamic> json) {
    return AboutInfoHelper(
      post: json['data'][0]['post'],
      updatadAt: json['data'][0]['updated_at'],
    );
  }
}
