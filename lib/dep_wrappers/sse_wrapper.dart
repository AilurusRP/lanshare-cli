import 'package:eventsource/publisher.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_eventsource/shelf_eventsource.dart';

class SsePublisher extends EventSourcePublisher {
  SsePublisher({
    super.cacheCapacity = 0,
    super.comparableIds = false,
    super.enableLogging = true,
  });
}

Handler getSseHandler(
  EventSourcePublisher publisher, {
  String channel = "",
  bool gzip = false,
}) {
  return eventSourceHandler(publisher, channel: channel, gzip: gzip);
}
