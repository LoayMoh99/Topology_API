import 'specification.dart';

class Component {
  String? id;
  String? type;
  Specification? spec;
  Map<String, String> netlist = {};

  Component({
    this.id,
    this.type,
    this.spec,
    this.netlist = const {},
  });

  Component.fromJson(Map<String?, dynamic> json) {
    this.id = json['id'];
    this.type = json['type'];
    if (this.type == "resistor")
      this.spec = Specification.fromJson(json['resistance']);
    else
      this.spec = Specification.fromJson(json['m(l)']);

    this.netlist = _netllistFromJson(json["netlist"]);
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    if (this.type == "resistor")
      data['resistance'] = this.spec?.toJson();
    else
      data['m(l)'] = this.spec?.toJson();

    data['netlist'] = _netllistToJson(this.netlist);
    return data;
  }

  //helper function ->private
  Map<String, String> _netllistFromJson(Map<String?, dynamic> json) {
    final Map<String, String> netlistData = new Map<String, String>();
    for (var key in json.keys) {
      netlistData[key ?? ""] = json[key];
    }
    return netlistData;
  }

  //helper function ->private
  Map<String?, dynamic> _netllistToJson(Map<String, String> data) {
    final Map<String?, dynamic> netlistJson = new Map<String?, dynamic>();
    for (var key in data.keys) {
      netlistJson[key] = data[key];
    }
    return netlistJson;
  }
}
