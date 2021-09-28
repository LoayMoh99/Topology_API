import 'package:TopologyAPI/api/API.dart';
import "package:test/test.dart";

void main(List<String> args) {
  //
  //Testing read JSON Function::
  //
  String? topId = readJSON("top1.json");
  test('Testing read JSON - File Exists', () {
    expect("top1", topId);
  });
  String? topId2 = readJSON("top4.json");
  test('Testing read JSON - File Doesnot Exist', () {
    expect(null, topId2);
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
  test('Testing query Topologies Function - There is topologies list.', () {
    expect(1, tops.length);
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
}
