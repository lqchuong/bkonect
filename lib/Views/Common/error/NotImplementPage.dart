import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:worldsoft_maintain/Common/LanguageInit.dart';
import 'package:worldsoft_maintain/LocalStoreKey.dart';

class NotImplementPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _NotImplementPageState();
}

class _NotImplementPageState extends State<NotImplementPage> {
  final LocalStorage storage = new LocalStorage(LocalStoreKey.keyStore);
  bool showInfo = false;

  ProgressDialog pr;

  _NotImplementPageState() {}
  _onTapkiemtra() {
    setState(() {
      this.showInfo = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    return FutureBuilder(
      future: storage.ready,
      builder: (BuildContext context, snapshot) {
        if (snapshot.data == true) {
          return Scaffold(
              appBar: AppBar(
                title:
                    Text(Translations.of(context).text('menu.not_implement')),
              ),
              body: Material(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(),
                  child: Column(
                    //mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          Translations.of(context)
                              .text('menu.not_implement_desc'),
                          textAlign: TextAlign.left,
                          style:
                              TextStyle(fontSize: 30.0, color: Colors.black54)),
                      RaisedButton(
                        color: Colors.blue[800],
                        textColor: Colors.white,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(Translations.of(context).text('menu.back')),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ));
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
