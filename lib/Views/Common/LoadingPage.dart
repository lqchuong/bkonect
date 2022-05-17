import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  LoadingPage();

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
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
                      Text('Đang xử lý ...',
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0)),
                      Text('Vui lòng đợi!',
                          style: new TextStyle(fontSize: 20.0)),
                      new Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                      ),
                      CircularProgressIndicator()
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
