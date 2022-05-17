import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseWidgetAuthentication.dart';
import 'SearchPartner.dart';

class FindPartner extends BaseWidgetAuthentication {
  @override
  State<StatefulWidget> createState() => new _FindPartnerState();
}

class Option {
  String title;
  Icon icon;
}

class _FindPartnerState extends BaseWidgetAuthenticationState<FindPartner> {
  Size deviceSize;
  String dropdownValue = "";

  Option one = new Option();
  Option two = new Option();
  Option three = new Option();
  Option four = new Option();

  List<Option> popupMenuButton = [];

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
    one.icon = Icon(
      Icons.group_work,
      color: Colors.grey,
    );
    one.title = "Tạo nhóm";

    two.icon = Icon(
      Icons.person_add,
      color: Colors.grey,
    );
    two.title = "Thêm bạn";

    three.icon = Icon(
      Icons.qr_code,
      color: Colors.grey,
    );
    three.title = "Quét mã QR";

    four.icon = Icon(
      Icons.settings,
      color: Colors.grey,
    );
    four.title = "Cài đặt";

    popupMenuButton = [one, two, three, four];
  }

  void _select(Option choice) {
    setState(() {
      dropdownValue = choice.title;
    });
  }

  @override
  buildwidget(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.search,
          size: 34,
        ),
        title: GestureDetector(
          onTap: () {
            // Navigator.pushNamed(context, Routes.SearchPartner);
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => SearchPartner(),
                transitionDuration: Duration(seconds: 0),
              ),
            );
          },
          child: Container(
            width: deviceSize.width,
            child: Text(
              "Tìm bạn bè, tin nhắn ...",
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white54, fontSize: 18),
            ),
          ),
        ),
        actions: [
          PopupMenuButton<Option>(
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return popupMenuButton.map((Option choice) {
                return PopupMenuItem<Option>(
                    value: choice,
                    child: Row(
                      children: [
                        choice.icon,
                        SizedBox(
                          width: 10,
                        ),
                        Text(choice.title),
                      ],
                    ));
              }).toList();
            },
          ),
        ],
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text("Tính năng đang trong quá trình phát triển"),
      ),
    );
  }
}
