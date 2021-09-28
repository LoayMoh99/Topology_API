import 'package:TopologyAPI/api/API.dart';

void main(List<String> args) {
  print("Before edit");
  String? topId = readJSON("top33333.json");
  Map<String, Topology> tops = queryTopologies();
  Topology t1 = tops[topId] ?? Topology(id: "defaultTop", components: []);
  List<Component> devices = queryDevices("top1");
  print(devices);
  devices = queryDevicesWithNetlistNode("top1", "vss");
  print(devices);
  t1.id = "top44";
  t1.components?[0].id = "res";
  t1.components?[0].spec?.defaultValue = 100.0;
  t1.components?[0].netlist["t1"] = "vdd";
  tops["top44"] = t1;
  print("After edit");
  writeJSON("top44");
}
