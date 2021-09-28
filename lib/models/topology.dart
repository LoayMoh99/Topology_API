import 'component.dart';

class Topology {
  String? id;
  List<Component>? components;

  Topology({
    this.id,
    this.components,
  });

  Topology.fromJson(Map<String?, dynamic> json) {
    this.id = json['id'];
    this.components = <Component>[];
    if (json['components'] != null) {
      List comps = json['components'].cast();
      for (int i = 0; i < comps.length; ++i) {
        this.components?.add(Component.fromJson(comps[i]));
      }
    }
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    if (this.components != null) {
      List<Map<String?, dynamic>> componentList = [];

      for (int i = 0; i < this.components!.length; ++i) {
        componentList.add(this.components![i].toJson());
      }
      data['components'] = componentList;
    } else
      data['components'] = null;
    return data;
  }
}
