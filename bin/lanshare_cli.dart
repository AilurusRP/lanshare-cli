import 'dart:io';

msgInput() {
  print("Input your message below.");
  print(
      "To finish input and send the message, type `:` in a new line and press `Enter`.");
  print("--------------------Your Message-------------------");

  while (true) {
    final msgLines = <String>[];
    String? line;

    while ((line = stdin.readLineSync()) != null && line != ":") {
      msgLines.add(line!);
    }

    if (msgLines.isEmpty) continue;

    return msgLines.join('\n');
  }
}

void main(List<String> args) async {
  while (true) {
    msgInput();
  }
}
