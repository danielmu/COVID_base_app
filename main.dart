
import 'package:flutter/material.dart';
import './getCountries.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

//https://corona-virus-stats.herokuapp.com/api/v1/cases/countries-search
//chinmay@futuralistech.com
//----------------------------------------
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.purple[900]),
        home: MyBaseApp());
  }
}
//----------------------  MODE CONTROLLER ----------------------------------------
//can be placed in its own class... but small enough to place here

class ModelController {
  static const String url =  'https://corona-virus-stats.herokuapp.com/api/v1/cases/countries-search';
 
  static Future<Countries> getRows() async { //Rows is our list of Countries, we get from main 'Data'
    try { 
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Countries countries = countriesFromJson(response.body);
        return countries;
      } else {
        return Countries();
      }
    } catch (e) {
      return Countries();
    }
  }
}
//---------------------------------------------------------------------------------

class MyBaseApp extends StatefulWidget {
  //Our app main
  MyBaseApp() : super();

  @override
  _MyBaseAppState createState() => _MyBaseAppState();
}
 
class _MyBaseAppState extends State<MyBaseApp> {
  //setup our countries and additional async display for 'loading' data
  Countries _countries;
  bool _loading;
 
  @override
  void initState() {
    super.initState();
    _loading = true;
    ModelController.getRows().then((countries) {
      setState(() {
        _countries = countries;
        _loading = false;
      });
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? '...Loading Data...' : 'COVID Cases Base App'),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: null == _countries ? 0 : _countries.data.rows.length,
          itemBuilder: (context, index) {
            List<Rows> rows = _countries.data.rows;
            final String countryName = rows[index].country;
            final String countryCases = rows[index].totalCases;
            final String countryImage = rows[index].flag;
            return ListTile(
              title: Text(countryName),//country.data.rows[index].country),
              subtitle: Text(countryCases),//country.data.rows[index].country),
              trailing: Image.network(countryImage)
            );
          },
        ),
      ),
    );
  }
}
