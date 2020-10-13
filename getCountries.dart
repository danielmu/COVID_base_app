
import 'dart:convert';

Countries countriesFromJson(String str) => Countries.fromJson(json.decode(str));
String countriesToJson(Countries data) => json.encode(data.toJson());

class Countries { //actually our Data
    Countries({
        this.data
    });

    Data data;

    factory Countries.fromJson(Map<String, dynamic> json) => Countries(
        data: Data.fromJson(json["data"])
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson()
    };
}

class Data { //contains Row - our Countries
    Data({
        this.rows,
    });

    List<Rows> rows;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        rows: List<Rows>.from(json["rows"].map((x) => Rows.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "rows": List<dynamic>.from(rows.map((x) => x.toJson())),
    };
}

class Rows { // Our countries
    Rows({
        this.country,
        this.totalCases,
        this.flag,
    });

    String country;
    String totalCases;
    String flag;

    factory Rows.fromJson(Map<String, dynamic> json) => Rows(
        country: json["country"],
        totalCases: json["total_cases"],
        flag: json["flag"],
    );

    Map<String, dynamic> toJson() => {
        "country": country,
        "total_cases": totalCases,
        "flag": flag,
    };
}