/*
  Topology API Library for being used in sources files..
*/

//Some Assumptions::
/*
  -Topology Json filename is the TopologyID ;
    for preventing making more than one file for each topology 
*/
export '../models/topology.dart';
export '../models/component.dart';

import '../models/component.dart';
import '../models/topology.dart';
//built-in packages for reading/writing files
import 'dart:io';
import 'dart:convert';

//contains map of topologies as (TopologyID->Topology) in memory in runtime; initially empty..
Map<String, Topology> topologies = {};

// This function is used for reading from file:
/*
  if filename exists it returns TopologyID of this file..
    --> {return TopologyID}
  else if filename not found or can't open this file ..
    --> {return null}
*/
String? readJSON(String FileName) {
  //Read from file::
  File myFile = File('lib/json/$FileName');
  late String stringJson;
  try {
    stringJson = myFile.readAsStringSync();
  } on FileSystemException catch (e) {
    return null;
  }
  Map<String?, dynamic> json = jsonDecode(stringJson);
  Topology top = Topology.fromJson(json);
  topologies[top.id!] = top;

  return top.id;
}

// This function is used for writing Topology to file:
/*
  if filename exists it overwrite it and returns true as a sucess indication..
    --> {return true}
  else if file name not found it creates new file for it and returns true as a sucess indication..
    --> {return true}
  else if file can't be writen in anycase return false
    --> {return false}
  else if TopologyID isn't found in memory or null return false
    --> {return false}
*/
bool writeJSON(String? TopologyID) {
  //Write to file::
  File myFile = File('lib/json/$TopologyID.json');
  if (TopologyID == null) return false;
  for (String topologyId in topologies.keys) {
    if (topologyId == TopologyID) {
      String stringJson = jsonEncode(topologies[topologyId]!.toJson());
      try {
        myFile.writeAsStringSync(stringJson);
      } on FileSystemException catch (e) {
        return false;
      }
      return true;
    }
  }
  return false;
}

//Return the map of topologies currently in memory (even if empty):
Map<String, Topology> queryTopologies() {
  return topologies;
}

//Set the map of topologies currently in memory (even if empty):
void setTopologies(Map<String, Topology> newTopologies) {
  topologies = newTopologies;
}

//Used to delete the given topology from the memory in runtime:
/*
  If topologyID is found
    --> {return true}
  Else if not found or is null
    --> {return false}
*/
bool deleteTopology(String? TopologyID) {
  if (TopologyID == null) return false;
  for (String topologyId in topologies.keys) {
    if (topologyId == TopologyID) {
      topologies.remove(topologyId); //to delete the topology from memory
      return true;
    }
  }
  return false;
}

//Used to return all the components/devices of a given topology:
/*
  if topologyID found 
    --> {return List of Components}
  if topologyID is null or not fount
    --> {return empty list []}
*/
List<Component> queryDevices(String? TopologyID) {
  List<Component> devices = [];
  if (TopologyID == null) return devices;
  for (String topologyId in topologies.keys) {
    if (topologyId == TopologyID) {
      return topologies[topologyId]!.components!;
    }
  }
  return devices;
}

//Used to return all the components/devices of a given topology with specific nodelist node:
/*
  if topologyID and netlistID found 
    --> {return List of Components}
  if topologyID OR netlistID is null or not found 
    --> {return empty list []}
*/
List<Component> queryDevicesWithNetlistNode(
    String? TopologyID, String? NetlistNodeID) {
  List<Component> devices = [];
  if (TopologyID == null || NetlistNodeID == null) return devices;
  for (String topologyId in topologies.keys) {
    if (topologyId == TopologyID) {
      for (Component comp in topologies[topologyId]!.components!) {
        for (String netlistId in comp.netlist.values) {
          if (NetlistNodeID == netlistId) {
            devices.add(comp);
            break;
          }
        }
      }
    }
  }
  return devices;
}
