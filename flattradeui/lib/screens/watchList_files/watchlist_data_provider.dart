// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps, avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:demoflattrade/screens/watchList_files/Watchlist_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

// String middleWereUrl = 'http://192.168.2.166:29093/';
String middleWereUrl = 'http://192.168.2.148:29093/';

class WatchListProvider extends ChangeNotifier {
  Marketwatch? marketwatch;
  List marketList = [];
  Marketwatcharr? selectedMarketWatch;
  // List<HoldingsQty> holdingsQty;
  final context;
  bool scripnamebool = true;
  bool scripLpbool = true;
  bool scripPercBool = true;
  

  // Favourite? favourite1;
  // Favourite? favourite2;

  // static SocketService socketService = SocketService();
  // Stream<dynamic>? socketStream = socketService.stream;

  WatchListProvider({
    required this.context,
  }) {
    // mapingTheSocketValues();
  }

  Future<void> getWatchList(BuildContext context) async {
    String url = '${middleWereUrl}getLists';
    // var userId = await TokenRepository().getUSerid();
    // var sUserToken = await TokenRepository().getToken();
    var userId = "FT033889";
    var sUserToken =
        "e6138093d10d29505f08dac11859a065ceaaff3b831ab5ca17dee45b4e9f1efa";
    // Timer.periodic(const Duration(seconds: 3), (Timer timer) {
    //   final keepingActive = {
    //     "t": "h",
    //   };

    //   SocketService().subscribe(keepingActive);
    // });
    var payLoad = '{"uid":"$userId","jkey":"$sUserToken"}';
    try {
      print(payLoad);
      Response response = await http.post(Uri.parse(url), body: payLoad);
      if (response.statusCode == 200) {
        var marketwatcharr = jsonDecode(response.body);
        if (marketwatcharr['status'] == 'I') {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
          // return;
        } else if (marketwatcharr['status'] == 'S') {
          // WatchListRespository().connectWebSocket(userId!, sUserToken!);
          marketwatch = marketwatchFromJson(response.body);

          selectedMarketWatch = marketwatch!.marketwatcharr.first;

          marketList =
              marketwatch!.marketwatcharr.map((e) => e.tab).take(5).toList();

          // final streamConnect = SocketService().stream!.asBroadcastStream();
        }
      }
    } catch (e) {
      print(e);
      // Handle other errors
    }
    notifyListeners();

    // mapingTheSocketValues();
    // mapingTheSocketValues();
  }

  changeWatchList(String newMarketWatch) {
// print(newMarketWatch);
    for (var element in marketwatch!.marketwatcharr) {
      if (element.tab == newMarketWatch) {
        selectedMarketWatch = element;
        notifyListeners();
      }
    }
  }
  // getHoldings() async {
  //   try {
  //     var userId = await TokenRepository().getUSerid();
  //     var sUserToken = await TokenRepository().getToken();
  //     String url = '${middleWereUrl}getHoldings';
  //     String playLoad =
  //         '{ "uid": "$userId","jkey": "$sUserToken", "prd":"","exch":"NSE"}';
  //     Response response = await http.post(Uri.parse(url), body: playLoad);
  //     if (response.statusCode == 200) {
  //       var result = jsonDecode(response.body);
  //       if (result["holdingsqtyarr"] != null) {
  //         holdingsQty =
  //             holdingsQtyFromJson(jsonEncode(result["holdingsqtyarr"]));

  //         notifyListeners();
  //       }
  //       // return result["technicalsData"];
  //     }
  //   } catch (e) {
  //     return [];
  //   }
  // }

  // changeTabName(
  //     {required String prevtab,
  //     required String newTab,
  //     required String scrips}) async {
  //   try {
  //     var userId = await TokenRepository().getUSerid();
  //     var sUserToken = await TokenRepository().getToken();
  //     String url = '${middleWereUrl}changeTabName';
  //     String playLoad =
  //         '{ "uid": "$userId","jkey": "$sUserToken","prevtab": "$prevtab","newtab":"$newTab","scrips":"$scrips"}';
  //     Response response = await http.post(Uri.parse(url), body: playLoad);
  //     if (response.statusCode == 200) {
  //       var result = jsonDecode(response.body);
  //       if (result["status"] == "S") {
  //         for (var element in marketWatch.marketwatcharr) {
  //           if (element.tab == prevtab) {
  //             element.tab = newTab;
  //             notifyListeners();
  //             break;
  //           }
  //         }
  //         notifyListeners();
  //       }
  //       // return result["technicalsData"];
  //     }
  //   } catch (e) {
  //     return [];
  //   }
  // }

  // mapingTheSocketValues() async {
  //   SocketService().socketStream.listen((socketData) {
  //     Map<String, dynamic> decodeData = jsonDecode(socketData);

  //     if (decodeData.containsValue("tk") || decodeData.containsValue("tf")) {
  //       if ((decodeData.containsKey('lp'))) {
  //         for (var element in marketWatch.marketwatcharr) {
  //           for (var scripsarr in element.scripsarr) {
  //             if (decodeData["tk"] == scripsarr.token) {
  //               if (decodeData.containsKey('c')) {
  //                 scripsarr.c = decodeData['c'];
  //               }
  //               scripsarr.ltp = decodeData['lp'];
  //               scripsarr.daychgper = decodeData['pc'];
  //             }
  //           }
  //         }
  //         for (var element in marketWatch.indexlistarr) {
  //           for (var scripsarr in element.indexlistarr) {
  //             if (decodeData["tk"] == scripsarr.token) {
  //               if (decodeData.containsKey('c')) {
  //                 scripsarr.c = decodeData['c'];
  //               }
  //               scripsarr.ltp = decodeData['lp'];
  //               scripsarr.daychgper = decodeData['pc'];
  //             }
  //           }
  //         }
  //       }
  //     }
  //     notifyListeners();
  //   });
  // }

  // // mapingTheSocketIndexValues() async {
  // //   await for (var socketData in socketStream!) {
  // //     Map<String, dynamic> decodeData = jsonDecode(socketData);
  // //     // print(decodeData);

  // //     if (decodeData.containsValue("tk") || decodeData.containsValue("tf")) {
  // //       if ((decodeData.containsKey('lp'))) {
  // //         for (var element in marketWatch.indexlistarr) {
  // //           for (var scripsarr in element.indexlistarr) {
  // //             if (decodeData.containsValue(scripsarr.token)) {
  // //               if (decodeData.containsKey('c')) {
  // //                 scripsarr.c = decodeData['c'];
  // //               }
  // //               scripsarr.ltp = decodeData['lp'];
  // //               scripsarr.daychgper = decodeData['pc'];
  // //             }
  // //           }
  // //         }
  // //       }
  // //     }
  // //     notifyListeners();
  // //   }
  // // }

  // // mappingFavorites()async{

  // //   if (favourite1!= null && favourite2!= null) {
  // //      await  for(var element in socketStream1 ) {
  // //        Map<String, dynamic> decodeData = jsonDecode(element);
  // //        if (decodeData["tk"]==favourite1!.token) {
  // //          favourite1!.daychgper=decodeData["pc"];
  // //          notifyListeners();
  // //        }
  // //      }
  // //   }
  // // }

  // var temp = '';
  // Map<String, dynamic> nextTabScript = {};
  // Map<String, dynamic> curScript = {};

  // Future<String> addNewScripts(String tab, String exch, String token) async {
  //   var userId = await TokenRepository().getUSerid();
  //   var sUserToken = await TokenRepository().getToken();
  //   try {
  //     String url = '${middleWereUrl}addScripList';
  //     var payLoad =
  //         '{ "uid": "$userId","tab":"$tab","scrip":"$exch|$token","jkey":"$sUserToken"}';

  //     // print(payLoad);

  //     Response response = await http.post(Uri.parse(url), body: payLoad);
  //     if (response.statusCode == 200) {
  //       var responseData = jsonDecode(response.body);

  //       for (var element in marketWatch.marketwatcharr) {
  //         if (element.tab == tab) {
  //           element.scripsarr =
  //               scripArrFromJson(jsonEncode(responseData['marketwatchscrip']));

  //           notifyListeners();
  //           break;
  //         }
  //       }
  //       return responseData["status"];
  //     }
  //   } catch (e) {
  //     return "";
  //   }
  //   return "";
  // }

  // deleteScripts(String tab, String exch, String token) async {
  //   var userId = await TokenRepository().getUSerid();
  //   var sUserToken = await TokenRepository().getToken();
  //   try {
  //     String url = '${middleWereUrl}deleteScripList';
  //     var payLoad =
  //         '{ "uid": "$userId","tab":"$tab","scrip":"$exch|$token","jkey":"$sUserToken"}';

  //     print(payLoad);

  //     Response response = await http.post(Uri.parse(url), body: payLoad);
  //     if (response.statusCode == 200) {
  //       var responseData = jsonDecode(response.body);

  //       for (var element in marketWatch.marketwatcharr) {
  //         if (element.tab == tab) {
  //           element.scripsarr =
  //               scripArrFromJson(jsonEncode(responseData['marketwatchscrip']));

  //           notifyListeners();
  //           break;
  //         }
  //       }
  //       return responseData["status"];
  //     }
  //   } catch (e) {
  //     return "";
  //   }
  //   return "";
  // }

  // dragscrip(String tab, String? scrip) async {
  //   var userId = await TokenRepository().getUSerid();
  //   var sUserToken = await TokenRepository().getToken();

  //   var scrips1 = '';

  //   for (var element in marketWatch.marketwatcharr) {
  //     if (element.tab == tab) {
  //       for (var i = element.scripsarr.length - 1; i >= 0; i--) {
  //         scrips1 +=
  //             '${element.scripsarr[i].exch}|${element.scripsarr[i].token}#';
  //       }
  //       break;
  //     }
  //   }
  //   try {
  //     String url = '${middleWereUrl}dragScripFromList';
  //     var payLoad =
  //         '{ "uid": "$userId","tab":"$tab","scrips":"${scrip ?? scrips1}","jkey":"$sUserToken"}';

  //     // print(payLoad);

  //     Response response = await http.post(Uri.parse(url), body: payLoad);
  //     if (response.statusCode == 200) {
  //       var responseData = jsonDecode(response.body);
  //       return responseData["status"];
  //     }
  //   } catch (e) {
  //     return "";
  //   }
  //   return "";
  // }

  swapScripts(int oldIndex, int newIndex, String wlname) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final item = selectedMarketWatch!.scripsarr.removeAt(oldIndex);
    selectedMarketWatch!.scripsarr.insert(newIndex, item);
    notifyListeners();

    // for (var element in marketwatch!.marketwatcharr) {
    //   if (element.tab == wlname) {
    //     final item = element.scripsarr.removeAt(oldIndex);
    //     element.scripsarr.insert(newIndex, item);
    //     notifyListeners();
    //   }
    // }
  }

  // String? getWatchListCount(String wlName) {
  //   for (var element in marketWatch.marketwatcharr) {
  //     if (element.tab == wlName) {
  //       // print(wlName);
  //       return element.scripsarr.length.toString();
  //     }
  //   }
  //   return null;
  // }

  // List<Marketwatcharr> withoutIndexList() {
  //   List<Marketwatcharr> stockList = [];

  //   for (var element in marketWatch.marketwatcharr) {
  //     if (element.tabtype != "default") {
  //       stockList.add(element);
  //     }
  //   }
  //   return stockList;
  // }

  // sortingScripName(String tabName) {
  //   if (scripnamebool) {
  //     for (var element in marketWatch.marketwatcharr) {
  //       if (element.tab == tabName) {
  //         element.scripsarr.sort(
  //           (a, b) => a.tsym.compareTo(b.tsym),
  //         );

  //         dragscrip(tabName, null);
  //         break;
  //       }
  //     }
  //     scripnamebool = !scripnamebool;
  //   } else {
  //     for (var element in marketWatch.marketwatcharr) {
  //       if (element.tab == tabName) {
  //         element.scripsarr.sort(
  //           (a, b) => b.tsym.compareTo(a.tsym),
  //         );

  //         dragscrip(tabName, null);
  //         break;
  //       }
  //     }
  //     scripnamebool = !scripnamebool;
  //   }
  //   notifyListeners();
  // }

  // sortingLp(String tabName) {
  //   if (scripLpbool) {
  //     for (var element in marketWatch.marketwatcharr) {
  //       if (element.tab == tabName) {
  //         element.scripsarr.sort(
  //           (a, b) => double.parse(a.ltp).compareTo(double.parse(b.ltp)),
  //         );

  //         dragscrip(tabName, null);
  //         break;
  //       }
  //     }
  //     scripLpbool = !scripLpbool;
  //   } else {
  //     for (var element in marketWatch.marketwatcharr) {
  //       if (element.tab == tabName) {
  //         element.scripsarr.sort(
  //           (a, b) => double.parse(b.ltp).compareTo(double.parse(a.ltp)),
  //         );

  //         dragscrip(tabName, null);
  //         break;
  //       }
  //     }
  //     scripLpbool = !scripLpbool;
  //   }
  //   notifyListeners();
  // }

  // sortingPerc(String tabName) {
  //   if (scripPercBool) {
  //     for (var element in marketWatch.marketwatcharr) {
  //       if (element.tab == tabName) {
  //         element.scripsarr.sort(
  //           (a, b) => a.daychgper.compareTo(b.daychgper),
  //         );

  //         dragscrip(tabName, null);
  //         break;
  //       }
  //     }
  //     scripPercBool = !scripPercBool;
  //   } else {
  //     for (var element in marketWatch.marketwatcharr) {
  //       if (element.tab == tabName) {
  //         element.scripsarr.sort(
  //           (a, b) => b.daychgper.compareTo(a.daychgper),
  //         );

  //         dragscrip(tabName, null);
  //         break;
  //       }
  //     }
  //     scripPercBool = !scripPercBool;
  //   }
  //   notifyListeners();
  // }

  // void changeTabView() {
  //   isListView = !isListView;
  //   notifyListeners();
  // }
}
