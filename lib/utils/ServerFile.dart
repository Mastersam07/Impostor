import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

generateServerFile(regionName, ip, port) {
  var bytesArray = int32(0);
  bytesArray.add(regionName.length);
  bytesArray = concatArrays(bytesArray, utf8.encode(regionName));
  bytesArray.add(ip.length);
  bytesArray = concatArrays(bytesArray, utf8.encode(ip));
  bytesArray = concatArrays(bytesArray, int32(1));

  var serverName = regionName + "-Master-1";

  bytesArray.add(serverName.length);
  bytesArray = concatArrays(bytesArray, utf8.encode(serverName));
  bytesArray = concatArrays(bytesArray, utf8.encode(ip));
  bytesArray = concatArrays(bytesArray, int16(port));
  bytesArray = concatArrays(bytesArray, int32(0));

  List<int> intList = bytesArray.cast<int>();

  return Uint8List.fromList(intList);
}

concatArrays(array1, array2) {
  var newArray = [];
  for (var i = 0; i < array1.length; i++) {
    newArray.add(array1[i]);
  }
  for (var i = 0; i < array2.length; i++) {
    newArray.add(array2[i]);
  }
  return newArray;
}

// Convert integer number to little-endian 32-bits int representation
int32(int) {
  return [
    (int & 0xFF),
    (int & 0xFF00) >> 8,
    (int & 0xFF0000) >> 16,
    (int & 0xFF000000) >> 24
  ];
}

// Convert integer number to little-endian 16-bits int representation
int16(int) {
  return [(int & 0xFF), (int & 0xFF00) >> 8];
}

// Set of helpers to save file

//  get local path
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

// create file path
Future<File> get _localFile async {
  final path = await _localPath;

  return File('$path/regionInfo.dat');
}

// write to file
Future<File> writeConfig(var blob) async {
  final file = await _localFile;

  // Write the file.
  return file.writeAsBytes(blob);
}
