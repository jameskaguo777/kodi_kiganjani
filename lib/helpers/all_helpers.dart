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

class NotificationCenterHelper {
  final List<dynamic> data;

  NotificationCenterHelper({this.data});

  factory NotificationCenterHelper.fromJson(Map<String, dynamic> json) {
    return NotificationCenterHelper(
      data: json['data'],
    );
  }
}

class TaxCalenderHelper {
  final List<dynamic> data;

  TaxCalenderHelper({this.data});

  factory TaxCalenderHelper.fromJson(Map<String, dynamic> json) {
    return TaxCalenderHelper(
      data: json['data'],
    );
  }
}

class ContactHelper {
  final List<dynamic> data;

  ContactHelper({this.data});

  factory ContactHelper.fromJson(Map<String, dynamic> json) {
    return ContactHelper(
      data: json['data'],
    );
  }
}

class LogoutHelper {
  final String logout;

  LogoutHelper({this.logout});

  factory LogoutHelper.fromJson(Map<String, dynamic> json) {
    return LogoutHelper(
      logout: json['logout'],
    );
  }
}

class SubscriberHelper {
  final Map<String, dynamic> data;
  final int active;
  final int remainingDays;

  SubscriberHelper({this.data, this.active, this.remainingDays});

  factory SubscriberHelper.fromJson(Map<String, dynamic> json) {
    return SubscriberHelper(
        data: json['data'][0],
        active: json['data'][0]['active'],
        remainingDays: json['data'][0]['remaining_days']);
  }
}

class PackagesHelper {
  final List<dynamic> data;

  PackagesHelper({this.data});

  factory PackagesHelper.fromJson(Map<String, dynamic> json) {
    return PackagesHelper(data: json['data']);
  }
}
