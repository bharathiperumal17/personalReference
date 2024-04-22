import 'package:flattrade7/screens/watchList_files/Watchlist_model.dart';
import 'package:flattrade7/screens/watchList_files/indexcard_widget.dart';
import 'package:flattrade7/screens/watchList_files/linechart.dart';
import 'package:flattrade7/screens/watchList_files/watchlist_data_provider.dart';
import 'package:flattrade7/styles.dart';
import 'package:flattrade7/websocket_provider.dart';
import 'package:flutter/material.dart';
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
                        height: 200,
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildChartCard(
                                      'NIFTY 50',
                                      '34,43,343',
                                      '(+74.32%)',
                                      profitColor,
                                      profitdata,
                                      Alignment.topLeft,
                                      context,profitColor),
                                  buildChartCard(
                                      'SENSEX',
                                      '4,43,343',
                                      '(-4.32%)',
                                      lossColor,
                                      lossdata,
                                      Alignment.topRight,
                                      context,lossColor),
                                ],
                              ),
                            ),
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
                                  value: watchListProvider
                                      .selectedMarketWatch!.tab,
                                  items: watchListProvider.marketList
                                      .map((e) => DropdownMenuItem(
                                          onTap: () {
                                            watchListProvider
                                                .changeWatchList(e);
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
                                    const EdgeInsets.symmetric(
                                        horizontal: 16.0)),
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
                    gridViewWatch
                        ? SliverGrid.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemCount: (indexListTile.length),
                            itemBuilder: (context, index) {
                              double cvalue = 0.0;
                              double lpvalue = 0.0;
                              String changevalue = "0.0";
                              double pcvalue = 0.0;

                              if (index <
                                  websockectWatch.dataFromSocket.length) {
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
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
                            },
                          )
                        : SliverToBoxAdapter(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: indexListTile.length,
                              itemBuilder: (context, index) {
                                double cvalue = 0.0;
                                double lpvalue = 0.0;
                                String changevalue = "0.0";
                                double pcvalue = 0.0;

                                if (index <
                                    websockectWatch.dataFromSocket.length) {
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

                                return SizedBox(
                                  height: 72,
                                  child: ListTile(
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
                                      width: MediaQuery.of(context).size.width -
                                          200,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child:
                                            // SpRangeChartSample(
                                            //   data: (pcvalue >= 0)
                                            //       ? profitdata
                                            //       : lossdata,
                                            //   colord: (pcvalue >= 0)
                                            //       ? profitColor
                                            //       : lossColor,
                                            // )

                                             SplineChartSample(
                                              data: (pcvalue >= 0)
                                                  ? fprofitdata
                                                  : flossdata,
                                              colord: (pcvalue >= 0)
                                                  ? profitColor
                                                  : lossColor,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon((pcvalue >=
                                                                0)
                                                            ? Icons
                                                                .arrow_drop_up_rounded
                                                            : Icons
                                                                .arrow_drop_down_rounded,color: (pcvalue >= 0)
                                                              ? profitColor
                                                              : lossColor,),
                                                  Text(
                                                    (index <
                                                            websockectWatch
                                                                .dataFromSocket
                                                                .length)
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
                                                ],
                                              ),
                                              Flexible(
                                                child: Text.rich(
                                                    TextSpan(children: [
                                                  TextSpan(
                                                    text: changevalue,
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
                                                        "( ${(index < websockectWatch.dataFromSocket.length) ? (websockectWatch.dataFromSocket[index]['pc'] ?? "0") : ""} %)",
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
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
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
