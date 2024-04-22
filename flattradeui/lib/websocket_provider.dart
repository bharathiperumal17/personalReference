import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class WebSocketProviderFlattradeUI extends ChangeNotifier {
  late IOWebSocketChannel _channel;
  late StreamSubscription<dynamic> subscription;
  late Timer _timer;
  List<Map<String, dynamic>> dataFromSocket = [];

  WebSocketProviderFlattradeUI() {
    _connect();
    startSendingData();
  }

  void _connect() {
    _channel = IOWebSocketChannel.connect(
      'wss://piconnect.flattrade.in/PiConnectWSTp/',
    );
    _channel.sink.add(jsonEncode(intialData));
    subscription = _channel.stream.listen(
      (data) {
        maptoScoketData(jsonDecode(data));
        notifyListeners();
      },
      onError: (error) {
        _reconnect();
      },
      onDone: () {
        _reconnect();
      },
    );
  }

void _reconnect() async {
  try {
    await _channel.sink.close();
  } catch (error) {
    print('Error while closing WebSocket connection: $error');
  }
  _connect();
}




void startSendingData() async {
  _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
    // print("touchpoint==>${DateTime.now()}");
      _channel.sink.add(jsonEncode({"t": "h"}));
      notifyListeners();
    });
  
}

  void addConnection(Map<String, dynamic> data) {
    _channel.sink.add(jsonEncode(data));
  }

  void disposeConnection() {
    _timer.cancel();
    subscription.cancel();
    _channel.sink.close(status.goingAway);
  }

  maptoScoketData(Map<String, dynamic> socketvalue) {
    for (int i = 0; i < dataFromSocket.length; i++) {
      if (dataFromSocket[i]['tk'] == socketvalue['tk']) {
        dataFromSocket[i].addAll(socketvalue);
      }
    }
    notifyListeners();
  }
}

var intialData = {
  "t": "c",
  "uid": "FT033889",
  "actid": "FT033889",
  "source": "API",
  "susertoken":
      "e6138093d10d29505f08dac11859a065ceaaff3b831ab5ca17dee45b4e9f1efa"
};
// var nextdata = {"t": "t", "k": "NSE|2277#BSE|1"};
// var nextdata = {"t": "t", "k": "NSE|2277#BSE|1"};