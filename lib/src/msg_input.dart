import 'dart:convert';
import 'dart:io';

import 'package:lanshare_cli/src/utils/generate_qr_code.dart';
import 'package:lanshare_cli/src/utils/get_local_ip.dart';

msgInput({required Function(String) onMsg}) async {
  print("Input your message below.");
  print(
      "To finish input and send the message, type `:` in a new line and press `Enter`.");
  print("--------------------Your Message-------------------");

  final ip = await getLocalIPv4();
  if (ip == null) {
    throw Exception(
        "No valid local IP address found. Please check your network connection.");
  }
  generateQrCode("http://$ip:7684");

  final msgLines = <String>[];
  stdin.transform(utf8.decoder).transform(const LineSplitter()).listen((line) {
    if (line != ":") {
      msgLines.add(line);
    } else {
      onMsg(msgLines.join("\n"));
      msgLines.clear();
    }
  });
}
