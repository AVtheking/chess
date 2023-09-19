import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  IO.Socket? socket;
  static SocketClient? _instance;

  SocketClient._internal() {
    socket = IO.io("http://192.168.83.188:3000", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false
    });
    print("Attempting to connect to the server...");
    socket!.connect();
    print("Connection attempt completed.");
  }
  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
