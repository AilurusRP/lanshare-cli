import 'dart:convert';
import 'dart:io';

import 'package:lanshare_cli/dep_wrappers/sse_wrapper.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

final sseClients = <SsePublisher>[];

class MsgResponse {
  MsgResponse(this.code);
  int code;

  Map<String, int> toJson() => {"code": code};
}

startServer() async {
  final app = Router();

  app.get("/events", (Request r) {
    final publisher = SsePublisher();
    sseClients.add(publisher);
    return getSseHandler(publisher)(r);
  });

  app.post("/web-msg", (Request r) async {
    final body = await r.readAsString();
    final msg = jsonDecode(body)["msg"];
    print("-------------MESSAGE FROM LANShare-web-------------");
    print(msg);
    print("----------------------------------------------------");
    return Response.ok(jsonEncode(MsgResponse(200)));
  });

  app.post("/mobile-msg", (Request r) async {
    final body = await r.readAsString();
    final msg = jsonDecode(body)["msg"];
    print("-------------MESSAGE FROM LANShare-mobile-------------");
    print(msg);
    print("----------------------------------------------------");
    return Response.ok(jsonEncode(MsgResponse(200)));
  });

  var webHandler =
      createStaticHandler('lanshare-web', defaultDocument: "index.html");

  final handler = Cascade().add(app.call).add(webHandler).handler;

  var server = await io.serve(handler, InternetAddress.anyIPv4, 7684);

  print('Serving at http://${server.address.host}:${server.port}');
}
