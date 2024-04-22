import 'package:demoflattrade/screens/watchList_files/Watchlist_model.dart';
import 'package:demoflattrade/screens/watchList_files/linechart.dart';
import 'package:demoflattrade/screens/watchList_files/watchlist_data_provider.dart';
import 'package:demoflattrade/styles.dart';
import 'package:demoflattrade/websocket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({super.key});

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  late String selected;

  bool drag = false;
  @override
  void initState() {
    // Provider.of<WebSocketProviderFlattradeUI>(context, listen: false).connect();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 1))
          .then((value) => websocketIndexTab());
      Provider.of<WatchListProvider>(context, listen: false)
          .getWatchList(context);
    });
    super.initState();
  }

  bool titleName = true;
  int indiceselected = 1;
  bool gridViewWatch = false;
  List<Arr> indexListTile = [];
  int count = 0;

  void websocketIndexTab() {
    if (titleName) {
      indexListTile =
          context.read<WatchListProvider>().selectedMarketWatch!.scripsarr;
    } else {
      var indexid = context
          .read<WatchListProvider>()
          .marketwatch!
          .marketwatcharr
          .where((e) => e.tab == 'INDEX')
          .map((e) => e.scripsarr[indiceselected - 1].indexid)
          .first;
      var indexTab = context
          .read<WatchListProvider>()
          .marketwatch!
          .indexlistarr
          .where((element) => element.indexid == indexid)
          .map((element) => element.indexlistarr)
          .toList();

      indexListTile = indexTab.isNotEmpty ? indexTab.last : [];
    }

    String exchTok = "";
    context.read<WebSocketProviderFlattradeUI>().dataFromSocket = [];
    for (int i = 0; i < indexListTile.length; i++) {
      exchTok += "${indexListTile[i].exch}|${indexListTile[i].token}";
      context
          .read<WebSocketProviderFlattradeUI>()
          .dataFromSocket
          .add({"tk": indexListTile[i].token});
      if (i != indexListTile.length - 1) {
        exchTok += "#";
      }
    }
    Map<String, dynamic> toSocket = {"t": "t", "k": exchTok};
    // print(toSocket);
    context.read<WebSocketProviderFlattradeUI>().addConnection(toSocket);
  }

  @override
  void dispose() {
    context.read<WebSocketProviderFlattradeUI>().disposeConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var websockectWatch = context.watch<WebSocketProviderFlattradeUI>();
    return SafeArea(
      child: Scaffold(
        body: NotificationListener(
           onNotification: (notification) {
          if (notification is ScrollStartNotification) {
            final currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
              currentFocus.unfocus();
            }
          }
          return false;
        },
          child: Consumer<WatchListProvider>(
            builder: (BuildContext context, WatchListProvider watchListProvider,
                Widget? child) {
              if (watchListProvider.marketwatch == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 185,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      titleName = !titleName;
                                      websocketIndexTab();
                                    });
                                  },
                                  icon: FaIcon(FontAwesomeIcons.list,
                                      size: 16, color: primaryColor),
                                  label: Text(
                                    titleName ? "WatchList" : "INDEX",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor),
                                    maxLines: 1,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: FaIcon(FontAwesomeIcons.bell,
                                      size: 20, color: primaryColor),
                                )
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6.0, vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(left: 15),
                                            child: Text(
                                              'NIFTY 50',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromRGBO(
                                                      19, 25, 33, 1)),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Text(
                                              '22,097.59',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: profitColor),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Text.rich(TextSpan(children: [
                                              TextSpan(
                                                text: '+85.00',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                    color: profitColor),
                                              ),
                                              const WidgetSpan(
                                                  child: SizedBox(
                                                width: 25,
                                              )),
                                              TextSpan(
                                                text: '+0.38%',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                    color: profitColor),
                                              )
                                            ])),
                                          ),
                                          SizedBox(
                                            height: 70,
                                            width: 120,
                                            child: SplineChartSample(
                                              colord: profitColor,
                                              data: profitdata,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(right: 20),
                                            child: Text(
                                              'SENSEX',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromRGBO(
                                                      19, 25, 33, 1)),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 20),
                                            child: Text(
                                              '97.59',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: lossColor),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 20),
                                            child: Text.rich(TextSpan(children: [
                                              TextSpan(
                                                text: '-85.00',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                    color: lossColor),
                                              ),
                                              const WidgetSpan(
                                                  child: SizedBox(
                                                width: 25,
                                              )),
                                              TextSpan(
                                                text: '-0.38%',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                    color: lossColor),
                                              )
                                            ])),
                                          ),
                                          SizedBox(
                                            height: 70,
                                            width: 120,
                                            child: SplineChartSample(
                                              colord: lossColor,
                                              data: lossdata,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SliverAppBar(
                      collapsedHeight: 100,
                      pinned: true,
                      primary: false,
                      leadingWidth: 200,
                      leading: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: titleName
                              ? DropdownButton(
                                  value:
                                      watchListProvider.selectedMarketWatch!.tab,
                                  items: watchListProvider.marketList
                                      .map((e) => DropdownMenuItem(
                                          onTap: () {
                                            watchListProvider.changeWatchList(e);
                                          },
                                          value: e,
                                          child: Text(e)))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      websocketIndexTab();
                                    });
                                  },
                                )
                              : DropdownButton(
                                  value: indiceselected,
                                  items: watchListProvider
                                      .marketwatch!.marketwatcharr
                                      .where((e) => e.tab == 'INDEX')
                                      .map((e) => e.scripsarr)
                                      .expand((scrips) => scrips
                                          .map((scrip) => DropdownMenuItem<int>(
                                                value: scrip.indexid,
                                                child: Text(scrip.tsym),
                                              )))
                                      .toList(),
                                  onTap: () {
                                    setState(() {});
                                  },
                                  onChanged: (selectedValue) {
                                    setState(() {
                                      indiceselected = selectedValue!;
                                      websocketIndexTab();
                                    });
                                  },
                                )),
                      actions: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              gridViewWatch = !gridViewWatch;
                            });
                          },
                          icon: Icon(Icons.grid_view_rounded,
                              size: 20, color: primaryColor),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: FaIcon(FontAwesomeIcons.ellipsisVertical,
                              size: 20, color: primaryColor),
                        )
                      ],
                      bottom: PreferredSize(
                        preferredSize:
                            Size(MediaQuery.of(context).size.width * 0.8, 10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SearchAnchor(
                            viewBackgroundColor: whiteColor,
                            viewSurfaceTintColor: whiteColor,
                            builder: (BuildContext context,
                                SearchController controller) {
                              return SearchBar(
                                elevation: MaterialStateProperty.all(2),
                                surfaceTintColor:
                                    MaterialStateProperty.all(whiteColor),
                                controller: controller,
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.symmetric(horizontal: 16.0)),
                                onTap: () {
                                  controller.openView();
                                },
                                onChanged: (_) {
                                  controller.openView();
                                },
                                leading: const Icon(Icons.search),
                              );
                            },
                            suggestionsBuilder: (context, controller) {
                              return List.generate(
                                indexListTile.length,
                                (index) {
                                  if (indexListTile[index]
                                      .tsym
                                      .toLowerCase()
                                      .contains(controller.text)) {
                                    return ListTile(
                                      title: Text(indexListTile[index].tsym),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    titleName
                        ? gridViewWatch?
                        SliverGrid.builder(
                          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                             itemCount: (watchListProvider
                                .selectedMarketWatch!.scripsarr.length),
                            itemBuilder: (context, index) {
                              double cvalue = 0.0;
                              double lpvalue = 0.0;
                              String changevalue = "0.0";
                              double pcvalue = 0.0;
          
                              if (index < websockectWatch.dataFromSocket.length) {
                                cvalue = double.tryParse(websockectWatch
                                            .dataFromSocket[index]['c'] ??
                                        "0") ??
                                    0.0;
                                lpvalue = double.tryParse(websockectWatch
                                            .dataFromSocket[index]['lp'] ??
                                        "0") ??
                                    0.0;
                                changevalue =
                                    (lpvalue - cvalue).toStringAsFixed(2);
                                pcvalue = lpvalue = double.tryParse(
                                        websockectWatch.dataFromSocket[index]
                                                ['pc'] ??
                                            "0") ??
                                    0.0;
                              }
                           return Card(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                      Text(
                                        indexListTile[index].tsym,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11,
                                            color: Color.fromRGBO(19, 25, 33, 1)),
                                      ),
                                      Text(
                                        websockectWatch.dataFromSocket[index]
                                                ['lp'] ??
                                            "0",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 11,
                                          color: (pcvalue >= 0)
                                              ? profitColor
                                              : lossColor,
                                        ),
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  changevalue,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 9,
                                                color: (pcvalue >= 0)
                                                    ? profitColor
                                                    : lossColor,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "( ${pcvalue.toString()} %)",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 8,
                                                color: (pcvalue >= 0)
                                                    ? profitColor
                                                    : lossColor,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    
                                    ]));
                          },)
                        :SliverList.builder(
                            itemCount: (watchListProvider
                                .selectedMarketWatch!.scripsarr.length),
                            itemBuilder: (context, index) {
                              final scriparr = watchListProvider
                                  .selectedMarketWatch!.scripsarr[index];
                              double cvalue = 0.0;
                              double lpvalue = 0.0;
                              String changevalue = "0.0";
                              double pcvalue = 0.0;
          
                              if (index < websockectWatch.dataFromSocket.length) {
                                cvalue = double.tryParse(websockectWatch
                                            .dataFromSocket[index]['c'] ??
                                        "0") ??
                                    0.0;
                                lpvalue = double.tryParse(websockectWatch
                                            .dataFromSocket[index]['lp'] ??
                                        "0") ??
                                    0.0;
                                changevalue =
                                    (lpvalue - cvalue).toStringAsFixed(2);
                                pcvalue = lpvalue = double.tryParse(
                                        websockectWatch.dataFromSocket[index]
                                                ['pc'] ??
                                            "0") ??
                                    0.0;
                              }
                              return SlidableAutoCloseBehavior(
                                  child: ListTile(
                                title: Text(
                                  scriparr.scripname,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11,
                                      color: Color.fromRGBO(19, 25, 33, 1)),
                                ),
                                subtitle: Text(
                                  scriparr.exch,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 8,
                                      color: Colors.blue.shade700),
                                ),
                                trailing: SizedBox(
                                  width: 150,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 50,
                                        child: SplineChartSample(
                                           data:(pcvalue >= 0)?profitdata: lossdata,
                                          colord: (pcvalue >= 0)
                                              ? profitColor
                                              : lossColor,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              (index <
                                                      websockectWatch
                                                          .dataFromSocket.length)
                                                  ? (websockectWatch
                                                              .dataFromSocket[
                                                          index]['lp'] ??
                                                      "0")
                                                  : "",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 11,
                                                color: (pcvalue >= 0)
                                                    ? profitColor
                                                    : lossColor,
                                              ),
                                            ),
                                            Flexible(
                                              child:
                                                  Text.rich(TextSpan(children: [
                                                TextSpan(
                                                  text: changevalue,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 9,
                                                    color: (pcvalue >= 0)
                                                        ? profitColor
                                                        : lossColor,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "( ${(index < websockectWatch.dataFromSocket.length) ? (websockectWatch.dataFromSocket[index]['pc'] ?? "0") : ""} %)",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 8,
                                                    color: (pcvalue >= 0)
                                                        ? profitColor
                                                        : lossColor,
                                                  ),
                                                )
                                              ])),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                isThreeLine: false,
                              ));
                            },
                          )
                        :  gridViewWatch? 
                        SliverGrid.builder(gridDelegate: 
                      const  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), 
                     itemCount: watchListProvider
                                .marketwatch!
                                .indexlistarr[indiceselected - 1]
                                .indexlistarr
                                .length,
                            itemBuilder: (context, index) {
                              double cvalue = double.tryParse(websockectWatch
                                          .dataFromSocket[index]['c'] ??
                                      "0") ??
                                  0.0;
                              double lpvalue = double.tryParse(websockectWatch
                                          .dataFromSocket[index]['lp'] ??
                                      "0") ??
                                  0.0;
                              double changevalue = lpvalue - cvalue;
          
                              double pcvalue = double.tryParse(websockectWatch
                                          .dataFromSocket[index]['pc'] ??
                                      "0") ??
                                  0.0;
                          return Card(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                      Text(
                                        indexListTile[index].tsym,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11,
                                            color: Color.fromRGBO(19, 25, 33, 1)),
                                      ),
                                      Text(
                                        websockectWatch.dataFromSocket[index]
                                                ['lp'] ??
                                            "0",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 11,
                                          color: (pcvalue >= 0)
                                              ? profitColor
                                              : lossColor,
                                        ),
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  changevalue.toStringAsFixed(2),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 9,
                                                color: (pcvalue >= 0)
                                                    ? profitColor
                                                    : lossColor,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "( ${pcvalue.toString()} %)",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 8,
                                                color: (pcvalue >= 0)
                                                    ? profitColor
                                                    : lossColor,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ]));
                        },)
                         :SliverList.builder(
                            itemCount: watchListProvider
                                .marketwatch!
                                .indexlistarr[indiceselected - 1]
                                .indexlistarr
                                .length,
                            itemBuilder: (context, index) {
                              double cvalue = double.tryParse(websockectWatch
                                          .dataFromSocket[index]['c'] ??
                                      "0") ??
                                  0.0;
                              double lpvalue = double.tryParse(websockectWatch
                                          .dataFromSocket[index]['lp'] ??
                                      "0") ??
                                  0.0;
                              double changevalue = lpvalue - cvalue;
          
                              double pcvalue = double.tryParse(websockectWatch
                                          .dataFromSocket[index]['pc'] ??
                                      "0") ??
                                  0.0;
          
                              return ListTile(
                                      title: Text(
                                        indexListTile[index].tsym,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11,
                                            color: Color.fromRGBO(19, 25, 33, 1)),
                                      ),
                                      subtitle: Text(
                                        indexListTile[index].exch,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 8,
                                            color: Colors.blue.shade700),
                                      ),
                                      trailing: SizedBox(
                                        width: 150,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                                width: 50,
                                                child: SplineChartSample(
                                                  data:(pcvalue >= 0)?profitdata: lossdata,
                                                  colord: (pcvalue >= 0)
                                                      ? profitColor
                                                      : lossColor,
                                                )),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    websockectWatch
                                                                .dataFromSocket[
                                                            index]['lp'] ??
                                                        "0",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 11,
                                                      color: (pcvalue >= 0)
                                                          ? profitColor
                                                          : lossColor,
                                                    ),
                                                  ),
                                                  Text.rich(TextSpan(children: [
                                                    TextSpan(
                                                      text: changevalue
                                                          .toStringAsFixed(2),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 9,
                                                        color: (pcvalue >= 0)
                                                            ? profitColor
                                                            : lossColor,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "( ${pcvalue.toString()} %)",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 8,
                                                        color: (pcvalue >= 0)
                                                            ? profitColor
                                                            : lossColor,
                                                      ),
                                                    )
                                                  ])),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      isThreeLine: false,
                                    );
                                   
                            },
                          )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
// SliverReorderableList(
//   // onReorderEnd: (p0) => ,
//   // onReorderStart: (p0) => ,
//   itemCount:
//       watchListProvider.selectedMarketWatch!.scripsarr.length,
//   itemBuilder: (context, index) {
//     final scriparr = watchListProvider
//         .selectedMarketWatch!.scripsarr[index];
//     return ReorderableDragStartListener(
//       key: ValueKey(scriparr.tsym),
//       index: index,
//       child: SizedBox(
//         height: 100,
//         width: double.infinity,
//         child: Text(scriparr.scripname),
//       ),
//     );
//   },
//   onReorder: (oldIndex, newIndex) {
//     watchListProvider.swapScripts(oldIndex, newIndex,
//         watchListProvider.selectedMarketWatch!.tab);
//   },
// )
