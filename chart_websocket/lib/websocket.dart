// import 'package:demoflattrade/websocket_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class WebSocketExample extends StatefulWidget {
//   const WebSocketExample({Key? key}) : super(key: key);

//   @override
//   _WebSocketExampleState createState() => _WebSocketExampleState();
// }

// class _WebSocketExampleState extends State<WebSocketExample> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('WebSocket Example'),
//       ),
//       body: StreamBuilder(
//         stream: context.watch<WebSocketProviderFlattradeUI>().getstreamcontroller(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           }

//           if (snapshot.connectionState == ConnectionState.done) {
//             return const Center(
//               child: Text('Connection Closed'),
//             );
//           }

//           if (snapshot.hasData) {
//             print("Connection State: ${snapshot.connectionState}");
//             print("Data: ${snapshot.data}");

//             return Center(
//               child: Text('Received: ${snapshot.data}'),
//             );
//           }
//           print("Connection State: ${snapshot.connectionState}");
//           print("Data: ${snapshot.data}");

//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: const Text('WS'),
//         onPressed: () {
//           context.read<WebSocketProviderFlattradeUI>().addConnection(nextdata);
//         },
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     context.read<WebSocketProviderFlattradeUI>().disposeConnection();
//     super.dispose();
//   }
// }

// var nextdata = {"t": "t", "k": "NSE|2277#BSE|1"};
