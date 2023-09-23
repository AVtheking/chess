<<<<<<< HEAD
=======
import 'package:multiplayer_chess/constants/utils.dart';
>>>>>>> 7efa588 (ui improved)
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  IO.Socket? socket;
  static SocketClient? _instance;

  SocketClient._internal() {
<<<<<<< HEAD
    socket = IO.io("http://192.168.83.188:3000", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false
    });
    print("Attempting to connect to the server...");
    socket!.connect();
    print("Connection attempt completed.");
=======
    socket = IO.io(uri, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false
    });
    // print("Attempting to connect to the server...");
    socket!.connect();
    // print("Connection attempt completed.");
>>>>>>> 7efa588 (ui improved)
  }
  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
