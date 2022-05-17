import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseWidgetAuthentication.dart';
import 'package:worldsoft_maintain/Model/UserCompanyModel.dart';

class CompanyEventDetailPage extends BaseWidgetAuthentication {
  @override
  State<StatefulWidget> createState() => new _CompanyEventDetailPageState();
}

class _CompanyEventDetailPageState
    extends BaseWidgetAuthenticationState<CompanyEventDetailPage> {
  Size deviceSize;
  UserCompanyModel userCompanyModel;

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
    Future.delayed(Duration.zero, () {
      userCompanyModel = ModalRoute.of(context).settings.arguments;
      setState(() {});
    });
  }

  @override
  buildwidget(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("NGƯỜI ĐẠI DIỆN"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        width: deviceSize.width,
        height: deviceSize.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_home.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: deviceSize.width,
                color: Color(0xff3184c6).withOpacity(0.5),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Image.asset(
                          userCompanyModel.avatar,
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: deviceSize.width - 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              userCompanyModel.name,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              userCompanyModel.position,
                              style: TextStyle(color: Colors.red),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              userCompanyModel.company_name,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            RaisedButton(
                              onPressed: () {},
                              color: Color(0xffcc6202),
                              child: Text(
                                "Liên hệ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: deviceSize.width,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: deviceSize.width - 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: deviceSize.width - 20,
                              child: Text(
                                "CÔNG TY CỔ PHẦN Ô TÔ TRƯỜNG HẢI (THACO)",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/diadiem.png',
                                  width: 30,
                                  height: 30,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: deviceSize.width - 80,
                                  child: Text(
                                    "Địa chỉ: Tầng 18 Tòa nhà Sofic, số 10 Mai Chí Thọ, phường Thủ Thiêm, Quận 2, TPHCM",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        height: 1.5),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/dienthoai.png',
                                  width: 30,
                                  height: 30,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Điện thoại: ",
                                  style: TextStyle(fontWeight: FontWeight.w900),
                                ),
                                Text("+84-(0)8-39977.824")
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/email.png',
                                  width: 30,
                                  height: 30,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Email: ",
                                  style: TextStyle(fontWeight: FontWeight.w900),
                                ),
                                Text("rep-office@thaco.com.vn")
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/congty.png',
                                  width: 30,
                                  height: 30,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Website: ",
                                  style: TextStyle(fontWeight: FontWeight.w900),
                                ),
                                Text("www.thacogroup.vn")
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: deviceSize.width,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: deviceSize.width - 20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                10.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: deviceSize.width - 20,
                                    child: Text(
                                      "LĨNH VỰC HOẠT ĐỘNG",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "- Ô tô và cơ khí",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "- Nông - lâm nghiệp",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "- Đầu tư - Xây dựng",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "- Thương mại",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "- Logistics",
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
