import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseModelApi.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseWidgetAuthentication.dart';
import 'package:worldsoft_maintain/Common/BaseClass/DioClientInit.dart';
import 'package:worldsoft_maintain/Common/Config.dart';
import 'package:worldsoft_maintain/Common/HandleWebApi/ServerError.dart';
import 'package:worldsoft_maintain/Common/tiengviet.dart';
import 'package:worldsoft_maintain/Model/ApiResult/RegisterPostApiModel.dart';
import 'package:worldsoft_maintain/Views/Common/Login/LoginPage.dart';
import 'package:dio/dio.dart';
import '../../LocalStoreKey.dart';
import '../../routes.dart';
import 'Api/SettingClient.dart';

class SettingPage extends BaseWidgetAuthentication {
  @override
  State<StatefulWidget> createState() => new _SettingPageState();
}

class _SettingPageState extends BaseWidgetAuthenticationState<SettingPage> {
  Size deviceSize;
  RegisterPostApiModel userInfoModel;

  Dio dio;
  ProgressDialog pr;
  SettingClient apiClient;
  bool loading = false;
  _SettingPageState() {
    dio = createDioClientAuthentication(storage);
    dio.options.headers["Content-Type"] = "application/json";
    apiClient = new SettingClient(dio);
  }

  @override
  functionfirstLoad() async {
    await super.functionfirstLoad();

    if (user != null) {}

    // loading = false;
    // setState(() {});
  }

  _launchURL() async {
    const url = 'https://worldsoft.com.vn/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  initState() {
    super.initState();
    loading = true;
    setState(() {});
    getUserInfo();
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

  Future<BaseModel<RegisterPostApiModel>> getUserInfo() async {
    RegisterPostApiModel response;

    try {
      response = await apiClient.getUserInfo();
      userInfoModel = response;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()
        ..setException(ServerError.withError(error, context, pr));
    }
    loading = false;
    setState(() {});
    return BaseModel()..data = response;
  }

  @override
  buildwidget(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text(
            "CÀI ĐẶT",
            style: TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Container(
                width: deviceSize.width,
                child: GestureDetector(
                  onTap: _launchURL,
                  child: Column(
                    children: [
                      Text(
                        "Version " + app_version,
                        textAlign: TextAlign.center,
                      ),
                      GestureDetector(
                        onTap: () {
                          launch('https://worldsoft.com.vn/');
                        },
                        child: Text(
                          "Powered by Worldsoft Corporation",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
        body: Container(
          color: Colors.white,
          width: deviceSize.width,
          height: deviceSize.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: deviceSize.width,
                  height: deviceSize.height * 0.2,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                        Color(0xff3867B4),
                        Color(0xff0F94B4)
                      ])),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: Container(
                              height: deviceSize.width * 0.25,
                              width: deviceSize.width * 0.25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          generateUrl(user.avatar_link) ??
                                              noImgUrl),
                                      fit: BoxFit.cover)),
                              //margin: EdgeInsets.only(left: 16.0),
                            )),
                        SizedBox(width: 15),
                        Container(
                          height: deviceSize.height * 0.13,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                userInfoModel.db.FullName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.white),
                              ),
                              SizedBox(height: 10),
                              Text(
                                userInfoModel.db.email,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              SizedBox(height: 10),
                              Text(
                                (userInfoModel.db.dienthoai) ?? "",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.ChangePasswordPage);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.security_rounded,
                              color: Colors.orange,
                              size: 24,
                            ),
                            SizedBox(width: 15),
                            Container(
                              width: deviceSize.width - 60,
                              child: Text(
                                "Đổi mật khẩu",
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                          ],
                        ),
                        Divider(color: Colors.black),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.EditUserInfo)
                        .then((value) => getUserInfo());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.edit,
                              color: Colors.blue,
                              size: 24,
                            ),
                            SizedBox(width: 15),
                            Container(
                              width: deviceSize.width - 60,
                              child: Text(
                                "Chỉnh sửa thông tin",
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                          ],
                        ),
                        Divider(color: Colors.black),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.people,
                              color: Colors.green,
                              size: 24,
                            ),
                            SizedBox(width: 15),
                            Container(
                              width: deviceSize.width - 60,
                              child: Text(
                                "Về chúng tôi",
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                          ],
                        ),
                        Divider(color: Colors.black),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showAcceptCustomButton("Đăng xuất", "ĐĂNG XUẤT",
                        "Bạn chắc chắn muốn đăng xuất khỏi ứng dụng?", logout);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.power_settings_new,
                              color: Colors.red,
                              size: 24,
                            ),
                            SizedBox(width: 15),
                            Text(
                              "Đăng xuất",
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                        Divider(color: Colors.black),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
