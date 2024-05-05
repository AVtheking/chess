import 'package:multiplayer_chess/constants/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  IO.Socket? socket;
  static SocketClient? _instance;
  String? token;

  SocketClient._internal() {
    socket = IO.io(uri, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'extraHeaders': {'Authorization': 'Bearer $token'}
    });
    setToken();
  }
  void setToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('x-auth-access_token');
    this.token = token;
    if (token != null && socket != null) {
      socket!.io.options!['extraHeaders'] = {'Authorization': 'Bearer $token'};
    }
    connect();
  }

  void connect() {
    socket!.connect();
  }

  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
