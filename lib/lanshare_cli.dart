import 'package:lanshare_cli/src/generate_qr_code.dart';
import 'package:lanshare_cli/src/get_local_ip.dart';
import 'package:lanshare_cli/src/msg_input.dart';

run() async {
  final ip = await getLocalIPv4();
  if(ip == null) {
    throw Exception("No valid local IP address found. Please check your network connection.");
  }
  generateQrCode(ip);
  while (true) {
    final msg = msgInput();
  }
}
