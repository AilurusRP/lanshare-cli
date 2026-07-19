import 'dart:convert';
import 'dart:io';

msgInput({required Function(String) onMsg}) {
  print("Input your message below.");
  print(
      "To finish input and send the message, type `:` in a new line and press `Enter`.");
  print("--------------------Your Message-------------------");

  final msgLines = <String>[];
  stdin.transform(utf8.decoder).transform(const LineSplitter()).listen((line) {
    if (line != ":") {
      msgLines.add(line);
    } else {
      onMsg(msgLines.join("\n"));
    }
  });
}
