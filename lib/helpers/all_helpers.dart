class TaxCalculatorHelper {
  final List<dynamic> taxCal;

  TaxCalculatorHelper({this.taxCal});

  factory TaxCalculatorHelper.fromJson(Map<String, dynamic> json) {
    return TaxCalculatorHelper(
      taxCal: json['data'],
    );
  }
}

class TaxCalculatorHelperList {
  final String name;
  final double value;

  TaxCalculatorHelperList({this.name, this.value});
  factory TaxCalculatorHelperList.fromMap(Map<String, dynamic> json) {
    return TaxCalculatorHelperList(
      name: json['name'],
      value: json['value'],
    );
  }
}
