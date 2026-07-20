import 'package:qr/qr.dart';

void generateQrCode(String data) {
  final qrCode = QrCode.fromData(
    data: data,
    errorCorrectLevel: QrErrorCorrectLevel.L,
  );
  final qrImage = QrImage(qrCode);
  final moduleCount = qrImage.moduleCount;

  for (int row = 0; row < moduleCount; row++) {
    final buffer = StringBuffer();
    for (int col = 0; col < moduleCount; col++) {
      if (qrImage.isDark(row, col)) {
        buffer.write('\x1B[47m  \x1B[0m');
      } else {
        buffer.write('\x1B[40m  \x1B[0m');
      }
    }
    print(buffer.toString());
  }
}
