// // socket_service.dart
// import 'dart:convert';

// import 'package:flattrade/sharedPreferendces.dart';
// import 'package:flutter/material.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';

// class SocketService with ChangeNotifier {
//   static WebSocketChannel _channel = WebSocketChannel.connect(
//     Uri.parse('wss://piconnect.flattrade.in/PiConnectWSTp/'),
//   );

//  static Stream get stream => _channel.stream.asBroadcastStream();

//   Future<void> connect() async {
//     try {
//       var userId = await TokenRepository().getUSerid();
//       var sUserToken = await TokenRepository().getToken();
//       // _channel = WebSocketChannel.connect(
//       //   Uri.parse('wss://piconnect.flattrade.in/PiConnectWSTp/'),
//       // );

//       _channel.sink.add(
//         jsonEncode(
//           {
//             "t": "c",
//             "uid": userId,
//             "actid": userId,
//             "source": "API",
//             "susertoken": sUserToken
//           },
//         ),
//       );
//       notifyListeners(); // Notify listeners about the available stream
//     } catch (e) {
//       // Handle connection errors
//       print("Error connecting: $e");
//     }
//   }

//   subScribeScrips(dynamic subscribeScripts) {
//     print(subscribeScripts);
//     _channel.sink.add(jsonEncode(subscribeScripts));
//   }

//   void disconnect() {
//     _channel.sink.close();
//     // _channel = null;
//     notifyListeners(); // Notify listeners about the closed stream
//   }
// }
import 'dart:async';
import 'dart:convert';

import 'package:demoflattrade/sharedPreferendces.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();

  factory SocketService() => _instance;

  SocketService._internal();

  static final WebSocketChannel _channel =
      IOWebSocketChannel.connect('wss://piconnect.flattrade.in/PiConnectWSTp/');

  Stream<dynamic> socketStream = _channel.stream.asBroadcastStream();

  static Stream marketdata = _channel.stream.asBroadcastStream();

// StreamSubscription watchListSubscription=marketdata.listen((event) {

//  });
  void connect() async {
    try {
      var userId = await TokenRepository().getUSerid();
      var sUserToken = await TokenRepository().getToken();

      _channel.sink.add(
        jsonEncode(
          {
            "t": "c",
            "uid": userId,
            "actid": userId,
            "source": "API",
            "susertoken": sUserToken
          },
        ),
      );
    } catch (e) {
      // Handle connection errors
      print("Error connecting: $e");
    }
  }

  void disconnect() {
    _channel.sink.close();
  }

  void subscribe(dynamic data) {
    _channel.sink.add(jsonEncode(data));
  }
}
