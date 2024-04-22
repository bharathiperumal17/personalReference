

// import 'dart:convert';

// Marketwatch marketwatchFromJson(String str) => Marketwatch.fromJson(json.decode(str));

// String marketwatchToJson(Marketwatch data) => json.encode(data.toJson());

// class Marketwatch {
//     List<Marketwatcharr> marketwatcharr;
//     List<Indexlistarr> indexlistarr;
//     String status;
//     String errMsg;

//     Marketwatch({
//         required this.marketwatcharr,
//         required this.indexlistarr,
//         required this.status,
//         required this.errMsg,
//     });

//     factory Marketwatch.fromJson(Map<String, dynamic> json) => Marketwatch(
//         marketwatcharr: List<Marketwatcharr>.from(json["marketwatcharr"].map((x) => Marketwatcharr.fromJson(x))),
//         indexlistarr: List<Indexlistarr>.from(json["indexlistarr"].map((x) => Indexlistarr.fromJson(x))),
//         status: json["status"],
//         errMsg: json["errMsg"],
//     );

//     Map<String, dynamic> toJson() => {
//         "marketwatcharr": List<dynamic>.from(marketwatcharr.map((x) => x.toJson())),
//         "indexlistarr": List<dynamic>.from(indexlistarr.map((x) => x.toJson())),
//         "status": status,
//         "errMsg": errMsg,
//     };
// }

// class Indexlistarr {
//     int indexid;
//     List<Arr> indexlistarr;

//     Indexlistarr({
//         required this.indexid,
//         required this.indexlistarr,
//     });

//     factory Indexlistarr.fromJson(Map<String, dynamic> json) => Indexlistarr(
//         indexid: json["indexid"],
//         indexlistarr: List<Arr>.from(json["indexlistarr"].map((x) => Arr.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "indexid": indexid,
//         "indexlistarr": List<dynamic>.from(indexlistarr.map((x) => x.toJson())),
//     };
// }

// class Arr {
//     Exch exch;
//     String token;
//     String scripname;
//     String tsym;
//     String pp;
//     String ls;
//     Ti ti;
//     String instname;
//     String qty;
//     String ltp;
//     String daychg;
//     String daychgper;
//     String openchg;
//     String openchgper;
//     String c;
//     String openprice;
//     String positonno;
//     String nontrd;
//     Weekly weekly;
//     String cname;
//     String isin;
//     String symbol;
//     int indexid;

//     Arr({
//         required this.exch,
//         required this.token,
//         required this.scripname,
//         required this.tsym,
//         required this.pp,
//         required this.ls,
//         required this.ti,
//         required this.instname,
//         required this.qty,
//         required this.ltp,
//         required this.daychg,
//         required this.daychgper,
//         required this.openchg,
//         required this.openchgper,
//         required this.c,
//         required this.openprice,
//         required this.positonno,
//         required this.nontrd,
//         required this.weekly,
//         required this.cname,
//         required this.isin,
//         required this.symbol,
//         required this.indexid,
//     });

//     factory Arr.fromJson(Map<String, dynamic> json) => Arr(
//         exch: exchValues.map[json["exch"]]!,
//         token: json["token"],
//         scripname: json["scripname"],
//         tsym: json["tsym"],
//         pp: json["pp"],
//         ls: json["ls"],
//         ti: tiValues.map[json["ti"]]!,
//         instname: json["instname"],
//         qty: json["qty"],
//         ltp: json["ltp"],
//         daychg: json["daychg"],
//         daychgper: json["daychgper"],
//         openchg: json["openchg"],
//         openchgper: json["openchgper"],
//         c: json["c"],
//         openprice: json["openprice"],
//         positonno: json["positonno"],
//         nontrd: json["nontrd"],
//         weekly: weeklyValues.map[json["weekly"]]!,
//         cname: json["cname"],
//         isin: json["isin"],
//         symbol: json["symbol"],
//         indexid: json["indexid"],
//     );

//     Map<String, dynamic> toJson() => {
//         "exch": exchValues.reverse[exch],
//         "token": token,
//         "scripname": scripname,
//         "tsym": tsym,
//         "pp": pp,
//         "ls": ls,
//         "ti": tiValues.reverse[ti],
//         "instname": instname,
//         "qty": qty,
//         "ltp": ltp,
//         "daychg": daychg,
//         "daychgper": daychgper,
//         "openchg": openchg,
//         "openchgper": openchgper,
//         "c": c,
//         "openprice": openprice,
//         "positonno": positonno,
//         "nontrd": nontrd,
//         "weekly": weeklyValues.reverse[weekly],
//         "cname": cname,
//         "isin": isin,
//         "symbol": symbol,
//         "indexid": indexid,
//     };
// }

// enum Exch {
//     BFO,
//     BSE,
//     MCX,
//     NSE
// }

// final exchValues = EnumValues({
//     "BFO": Exch.BFO,
//     "BSE": Exch.BSE,
//     "MCX": Exch.MCX,
//     "NSE": Exch.NSE
// });

// enum Ti {
//     EMPTY,
//     THE_001,
//     THE_005,
//     THE_100
// }

// final tiValues = EnumValues({
//     "": Ti.EMPTY,
//     "0.01": Ti.THE_001,
//     "0.05": Ti.THE_005,
//     "1.00": Ti.THE_100
// });

// enum Weekly {
//     EMPTY,
//     W4
// }

// final weeklyValues = EnumValues({
//     "": Weekly.EMPTY,
//     "W4": Weekly.W4
// });

// class Marketwatcharr {
//     String tab;
//     List<Arr> scripsarr;
//     String tabtype;

//     Marketwatcharr({
//         required this.tab,
//         required this.scripsarr,
//         required this.tabtype,
//     });

//     factory Marketwatcharr.fromJson(Map<String, dynamic> json) => Marketwatcharr(
//         tab: json["tab"],
//         scripsarr: List<Arr>.from(json["scripsarr"].map((x) => Arr.fromJson(x))),
//         tabtype: json["tabtype"],
//     );

//     Map<String, dynamic> toJson() => {
//         "tab": tab,
//         "scripsarr": List<dynamic>.from(scripsarr.map((x) => x.toJson())),
//         "tabtype": tabtype,
//     };
// }

// class EnumValues<T> {
//     Map<String, T> map;
//     late Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         reverseMap = map.map((k, v) => MapEntry(v, k));
//         return reverseMap;
//     }
// }






/// To parse this JSON data, do
//
//     final marketwatch = marketwatchFromJson(jsonString);

import 'dart:convert';

Marketwatch marketwatchFromJson(String str) => Marketwatch.fromJson(json.decode(str));

String marketwatchToJson(Marketwatch data) => json.encode(data.toJson());

class Marketwatch {
    List<Marketwatcharr> marketwatcharr;
    List<Indexlistarr> indexlistarr;
    String status;
    String errMsg;

    Marketwatch({
        required this.marketwatcharr,
        required this.indexlistarr,
        required this.status,
        required this.errMsg,
    });

    factory Marketwatch.fromJson(Map<String, dynamic> json) => Marketwatch(
        marketwatcharr: List<Marketwatcharr>.from(json["marketwatcharr"].map((x) => Marketwatcharr.fromJson(x))),
        indexlistarr: List<Indexlistarr>.from(json["indexlistarr"].map((x) => Indexlistarr.fromJson(x))),
        status: json["status"],
        errMsg: json["errMsg"],
    );

    Map<String, dynamic> toJson() => {
        "marketwatcharr": List<dynamic>.from(marketwatcharr.map((x) => x.toJson())),
        "indexlistarr": List<dynamic>.from(indexlistarr.map((x) => x.toJson())),
        "status": status,
        "errMsg": errMsg,
    };
}

class Indexlistarr {
    int indexid;
    List<Arr> indexlistarr;

    Indexlistarr({
        required this.indexid,
        required this.indexlistarr,
    });

    factory Indexlistarr.fromJson(Map<String, dynamic> json) => Indexlistarr(
        indexid: json["indexid"],
        indexlistarr: List<Arr>.from(json["indexlistarr"].map((x) => Arr.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "indexid": indexid,
        "indexlistarr": List<dynamic>.from(indexlistarr.map((x) => x.toJson())),
    };
}

class Arr {
    String exch;
    String token;
    String scripname;
    String tsym;
    String pp;
    String ls;
    String ti;
    String instname;
    String qty;
    String ltp;
    String daychg;
    String daychgper;
    String openchg;
    String openchgper;
    String c;
    String openprice;
    String positonno;
    String nontrd;
    String weekly;
    String cname;
    String isin;
    String symbol;
    int indexid;

    Arr({
        required this.exch,
        required this.token,
        required this.scripname,
        required this.tsym,
        required this.pp,
        required this.ls,
        required this.ti,
        required this.instname,
        required this.qty,
        required this.ltp,
        required this.daychg,
        required this.daychgper,
        required this.openchg,
        required this.openchgper,
        required this.c,
        required this.openprice,
        required this.positonno,
        required this.nontrd,
        required this.weekly,
        required this.cname,
        required this.isin,
        required this.symbol,
        required this.indexid,
    });

    factory Arr.fromJson(Map<String, dynamic> json) => Arr(
        exch:json["exch"],
        token: json["token"],
        scripname: json["scripname"],
        tsym: json["tsym"],
        pp: json["pp"],
        ls: json["ls"],
        ti:json["ti"],
        instname: json["instname"],
        qty: json["qty"],
        ltp: json["ltp"],
        daychg: json["daychg"],
        daychgper: json["daychgper"],
        openchg: json["openchg"],
        openchgper: json["openchgper"],
        c: json["c"],
        openprice: json["openprice"],
        positonno: json["positonno"],
        nontrd: json["nontrd"],
        weekly:json[ "weekly"],
        cname: json["cname"],
        isin: json["isin"],
        symbol: json["symbol"],
        indexid: json["indexid"],
    );

    Map<String, dynamic> toJson() => {
        "exch":exch,
        "token": token,
        "scripname": scripname,
        "tsym": tsym,
        "pp": pp,
        "ls": ls,
        "ti":ti,
        "instname": instname,
        "qty": qty,
        "ltp": ltp,
        "daychg": daychg,
        "daychgper": daychgper,
        "openchg": openchg,
        "openchgper": openchgper,
        "c": c,
        "openprice": openprice,
        "positonno": positonno,
        "nontrd": nontrd,
        "weekly": weekly,
        "cname": cname,
        "isin": isin,
        "symbol": symbol,
        "indexid": indexid,
    };
}



class Marketwatcharr {
    String tab;
    List<Arr> scripsarr;
    String tabtype;

    Marketwatcharr({
        required this.tab,
        required this.scripsarr,
        required this.tabtype,
    });

    factory Marketwatcharr.fromJson(Map<String, dynamic> json) => Marketwatcharr(
        tab: json["tab"],
        scripsarr: List<Arr>.from(json["scripsarr"].map((x) => Arr.fromJson(x))),
        tabtype: json["tabtype"],
    );

    Map<String, dynamic> toJson() => {
        "tab": tab,
        "scripsarr": List<dynamic>.from(scripsarr.map((x) => x.toJson())),
        "tabtype": tabtype,
    };
}


