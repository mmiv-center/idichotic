import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

class BackendService {
  @Route.get('/upload')
  Future<Response> upload() async {
    return Response.ok("Data submitted");
  }
}