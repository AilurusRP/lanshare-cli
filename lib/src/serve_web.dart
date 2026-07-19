import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_static/shelf_static.dart';

serveWeb() async {
  var handler =
      createStaticHandler('lanshare-web', defaultDocument: "index.html");

  var server = await io.serve(handler, 'localhost', 7684);

  print('Serving at http://${server.address.host}:${server.port}');
}
