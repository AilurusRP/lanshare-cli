import 'dart:io';

Future<String?> getLocalIPv4() async {
  try {
    List<NetworkInterface> interfaces = await NetworkInterface.list(
      includeLoopback: false,
      type: InternetAddressType.IPv4,
    );

    for (var interface in interfaces) {
      for (var addr in interface.addresses) {
        if (addr.address.startsWith("192.168.")) {
          return addr.address;
        }
      }
    }

    return null;
  } catch (e, s) {
    print("$e\n$s");
    return null;
  }
}
