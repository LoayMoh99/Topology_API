class Specification {
  double? defaultValue;
  double? min;
  double? max;
  Specification({this.defaultValue, this.min, this.max});

  Specification.fromJson(Map<String?, dynamic> json) {
    this.defaultValue = json['default'] * 1.0;
    this.min = json['min'] * 1.0;
    this.max = json['max'] * 1.0;
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['default'] = this.defaultValue;
    data['min'] = this.min;
    data['max'] = this.max;
    return data;
  }
}
