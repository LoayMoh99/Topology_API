import 'package:TopologyAPI/api/API.dart';
import "package:test/test.dart";

void main(List<String> args) {
  //
  //Testing read JSON Function::
  //
  String? topId = readJSON("top1.json");
  readJSON("top33333.json");
  readJSON("top44.json");
  test('Testing read JSON - File Exists', () {
    expect("top1", topId);
  });
  String? topId2 = readJSON("top4.json");
  test('Testing read JSON - File Doesnot Exist', () {
    expect(null, topId2);
  });
  String? topId3 = readJSON("top1.json");
  test('Testing read JSON - File Existed but read before', () {
    expect("top1", topId3);
  });

  //
  //Testing write Json Function::
  //
  bool resultWriteFile = writeJSON("top1");
  test('Testing write JSON - Topology ID Exists', () {
    expect(true, resultWriteFile);
  });
  bool resultWriteFile2 = writeJSON(null);
  test('Testing write JSON - Topology ID is Null', () {
    expect(false, resultWriteFile2);
  });
  bool resultWriteFile3 = writeJSON("top111");
  test('Testing write JSON - Topology ID Doesnot Exist', () {
    expect(false, resultWriteFile3);
  });

  //
  //Testing query Topologies Function::
  //
  Map<String, Topology> tops = queryTopologies();
  test('Testing query Topologies Function - There is a topologies list.', () {
    expect(3, tops.length);
    expect(true, tops.isNotEmpty);
  });

  //
  //Testing delete Topology Function::
  //
  bool resultDelete = writeJSON("top1");
  test('Testing delete Topology - Topology ID Exists', () {
    expect(true, resultDelete);
  });
  bool resultDelete2 = writeJSON(null);
  test('Testing delete Topology - Topology ID is Null', () {
    expect(false, resultDelete2);
  });
  bool resultDelete3 = writeJSON("top111");
  test('Testing delete Topology - Topology ID Doesnot Exist', () {
    expect(false, resultDelete3);
  });

  //
  //Testing query Devices of Specific Topology Function::
  //
  List<Component> devices = queryDevices("top1");
  test('Testing query Topologies Function - TopologyID existed.', () {
    expect(2, devices.length);
    expect(true, devices.isNotEmpty);
  });
  List<Component> devices2 = queryDevices("top111");
  test('Testing query Topologies Function -  TopologyID doesnot exist.', () {
    expect(0, devices2.length);
    expect(false, devices2.isNotEmpty);
  });
  List<Component> devices3 = queryDevices(null);
  test('Testing query Topologies Function -  TopologyID is Null.', () {
    expect(0, devices3.length);
    expect(false, devices3.isNotEmpty);
  });

  //
  //Testing query Devices of Specific Topology & Netlist Function::
  //
  List<Component> devicesNetlist = queryDevicesWithNetlistNode("top1", "n1");
  test(
      'Testing query Topologies Function - TopologyID and NetlistID both existed.',
      () {
    expect(2, devicesNetlist.length);
    expect(true, devicesNetlist.isNotEmpty);
  });
  List<Component> devicesNetlist2 = queryDevicesWithNetlistNode("top111", "n1");
  test(
      'Testing query Topologies Function -  TopologyID doesnot exist whatever NodeListID.',
      () {
    expect(0, devicesNetlist2.length);
    expect(false, devicesNetlist2.isNotEmpty);
  });
  List<Component> devicesNetlist22 =
      queryDevicesWithNetlistNode("top1", "nnn1");
  test(
      'Testing query Topologies Function -  TopologyID exist but NodeListID doesnot.',
      () {
    expect(0, devicesNetlist22.length);
    expect(false, devicesNetlist22.isNotEmpty);
  });
  List<Component> devicesNetlist3 = queryDevicesWithNetlistNode(null, null);
  test(
      'Testing query Topologies Function -  TopologyID / NetlistID either is Null.',
      () {
    expect(0, devicesNetlist3.length);
    expect(false, devicesNetlist3.isNotEmpty);
  });
}
