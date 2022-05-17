import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseWidgetAuthentication.dart';

class TestPage extends BaseWidgetAuthentication {
  @override
  State<StatefulWidget> createState() => new _TestPageState();
}

class _TestPageState extends BaseWidgetAuthenticationState<TestPage> {
  Size deviceSize;

  @override
  functionfirstLoad() {
    // loading = true;
  }

  @override
  initState() {
    super.initState();
  }

  @override
  buildwidget(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Scaffold();
  }
}
