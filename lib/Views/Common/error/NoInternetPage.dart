import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:worldsoft_maintain/Common/Config.dart';

class NoInternetPage extends StatefulWidget {
  @override
  _NoInternetPageState createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage> {
  checkInternet() async {
    loading = true;
    setState(() {});
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(Duration(seconds: 1));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        noInternet = false;
      }
    } on Exception catch (_) {
      noInternet = true;
    }
    loading = false;
    setState(() {});
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new InkWell(
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  flex: 2,
                  child: new Container(
                      child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: new Container(
                            child: Image.asset('assets/images/logo.png')),
                        radius: 100,
                      ),
                      Text('Không có kết nối internet ...',
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0)),
                      Text('Vui lòng kiểm tra lại Internet!',
                          style: new TextStyle(fontSize: 20.0)),
                      new Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                      ),
                      loading == true
                          ? CircularProgressIndicator()
                          : RaisedButton(
                              onPressed: () {
                                checkInternet();
                              },
                              child: Text("Thử lại"),
                            )
                    ],
                  )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
