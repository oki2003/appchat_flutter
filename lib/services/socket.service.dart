import 'dart:async';
import 'package:appchat_flutter/constants/api.dart';
import 'package:appchat_flutter/enums/socket_title.dart';
import 'package:appchat_flutter/models/response/send_message_response.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;

class SocketService {
  static late socket_io.Socket _socket;
  static final StreamController<Map<SocketTitle, dynamic>> messageController =
      StreamController<Map<SocketTitle, dynamic>>.broadcast();

  void connect(accessToken) {
    _socket = socket_io.io(
      Api.baseSocketURL,
      socket_io.OptionBuilder()
          .setTransports(['websocket'])
          .setAuth({'token': accessToken})
          .disableAutoConnect()
          .build(),
    );

    _socket.connect();

    _socket.onConnect((_) {
      print('Connected: ${_socket.id}');
    });

    listenFromServer(_socket);

    _socket.onDisconnect((_) {
      print('Disconnected');
    });
  }

  void sendToServer(SocketTitle title, Map<dynamic, dynamic> data) {
    switch (title) {
      case SocketTitle.sendMessage:
        _socket.emitWithAck(
          title.name,
          data,
          ack: (response) {
            final Map<SocketTitle, dynamic> data = {
              SocketTitle.sendMessage: response,
            };
            messageController.add(data);
          },
        );
        break;
      case SocketTitle.typing:
        _socket.emit(title.name, data);
        break;
      default:
        break;
    }
  }

  void listenFromServer(socket_io.Socket socket) {
    socket.on(SocketTitle.receiveMessage.name, (dynamic data) {
      final Map<SocketTitle, dynamic> res = {SocketTitle.receiveMessage: data};
      messageController.add(res);
    });

    socket.on(SocketTitle.typing.name, (dynamic data) {
      final Map<SocketTitle, dynamic> res = {SocketTitle.typing: data};
      messageController.add(res);
    });
  }

  void disconnect() {
    _socket.disconnect();
  }
}
