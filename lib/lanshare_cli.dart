import 'package:eventsource/publisher.dart';
import 'package:lanshare_cli/src/msg_input.dart';

import 'src/start_server.dart';

run() async {
  await startServer();

  await msgInput(onMsg: (String msg) {
    for (var flusher in sseClients) {
      flusher.add(Event(event: "message", data: msg));
    }
  });
}
