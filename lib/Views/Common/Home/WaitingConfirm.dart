import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseWidgetAuthentication.dart';
import 'package:worldsoft_maintain/Views/Common/Login/LoginPage.dart';

import '../../../LocalStoreKey.dart';

class WaitingConfirm extends BaseWidgetAuthentication {
  @override
  State<StatefulWidget> createState() => new _WaitingConfirmState();
}

class _WaitingConfirmState
    extends BaseWidgetAuthenticationState<WaitingConfirm> {
  Size deviceSize;

  @override
  functionfirstLoad() async {
    await super.functionfirstLoad();
    // await insertToken();
    // var postToken = await homeapi.getListCompanyRecommend();
    if (user != null) {}
    loading = false;
    setState(() {});
  }

  @override
  initState() {
    super.initState();
  }

  logout() {
    storage.deleteItem(LocalStoreKey.tokenUser);
    storage.deleteItem(LocalStoreKey.userInfo);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  buildwidget(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: FloatingActionButton.extended(
            backgroundColor: Colors.red,
            onPressed: logout,
            label: Text("QUAY LẠI ĐĂNG NHẬP"),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
          width: deviceSize.width,
          height: deviceSize.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background_home.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 80, 15, 0),
            child: Column(
              children: [
                Text(
                  "Tài khoản của bạn đang trong trạng thái chờ duyệt",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.red),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Chúng tôi sẽ gửi thông báo về email khi tài khoản của bạn được xác nhận",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          )),
    );
  }
}
