import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseWidgetAuthentication.dart';

class CooperatePage extends BaseWidgetAuthentication {
  @override
  State<StatefulWidget> createState() => new _CooperatePageState();
}

class _CooperatePageState extends BaseWidgetAuthenticationState<CooperatePage> {
  Size deviceSize;

  @override
  functionfirstLoad() async {
    await super.functionfirstLoad();

    if (user != null) {}

    loading = false;
    setState(() {});
  }

  @override
  initState() {
    super.initState();
  }

  @override
  buildwidget(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("HỢP TÁC"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text("Tính năng đang trong quá trình phát triển"),
      ),
    );
  }
}
