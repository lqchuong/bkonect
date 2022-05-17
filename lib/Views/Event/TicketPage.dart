import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseModelApi.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseWidgetAuthentication.dart';
import 'package:worldsoft_maintain/Common/BaseClass/DioClientInit.dart';
import 'package:worldsoft_maintain/Common/Config.dart';
import 'package:worldsoft_maintain/Common/HandleWebApi/ServerError.dart';
import 'package:worldsoft_maintain/Common/Util/CrytorAES.dart';
import 'package:worldsoft_maintain/Model/ApiResult/EventResultModel.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:worldsoft_maintain/Model/ApiResult/RegisterPostApiModel.dart';
import 'package:worldsoft_maintain/Views/Setting/Api/SettingClient.dart';

class TicketPage extends BaseWidgetAuthentication {
  @override
  State<StatefulWidget> createState() => new _TicketPageState();
}

class _TicketPageState extends BaseWidgetAuthenticationState<TicketPage> {
  Size deviceSize;
  EventResultModel eventResultModel;
  final formatDate = new DateFormat(formatTimeDateString);
  Codec<String, String> stringToBase64 = utf8.fuse(base64);

  RegisterPostApiModel userInfoModel;

  Dio dio;
  ProgressDialog pr;
  SettingClient apiClient;
  bool loading = false;
  _TicketPageState() {
    dio = createDioClientAuthentication(storage);
    dio.options.headers["Content-Type"] = "application/json";
    apiClient = new SettingClient(dio);
  }

  @override
  functionfirstLoad() async {
    await super.functionfirstLoad();
    // await insertToken();
    // var postToken = await homeapi.getListCompanyRecommend();
    if (user != null) {}

    // loading = false;
    // setState(() {});
  }

  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      eventResultModel = ModalRoute.of(context).settings.arguments;
      loading = true;
      setState(() {});
      getUserInfo();
    });
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
        title: Text("VÉ MỜI"),
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
              SizedBox(
                height: 20,
              ),
              Text(
                "VUI LÒNG QUÉT MÃ QR DƯỚI ĐÂY ĐỂ THAM GIA SỰ KIỆN",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff515150)),
              ),
              SizedBox(
                height: 10,
              ),
              // Image.asset('assets/images/qr.png'),
              QrImage(
                data: Uri.encodeComponent(encryptAESCryptoJS(
                    "check_in" + eventResultModel.db.id + "@@" + user.id)),
                version: QrVersions.auto,
                size: 200.0,
              ),
              SizedBox(
                height: 10,
              ),
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
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: deviceSize.width - 20,
                        child: Text(
                          userInfoModel.db.FullName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xff3184c6)),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: deviceSize.width - 20,
                        child: Text(
                          (userInfoModel.db.position) ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: deviceSize.width - 20,
                        child: Text(
                          (userInfoModel.ten_cong_ty) ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/noidung.png',
                            width: 30,
                            height: 30,
                          ),
                          Container(
                            width: deviceSize.width - 80,
                            child: Text(
                              "Sự kiện: " + eventResultModel.db.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                height: 1.5,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/hinhthuc.png',
                            width: 30,
                            height: 30,
                          ),
                          Text(
                            " Hình thức: ",
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                          (eventResultModel.db.type == 1)
                              ? Text("Offline")
                              : Text("Online")
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/thoigian.png',
                            width: 30,
                            height: 30,
                          ),
                          Container(
                            width: deviceSize.width - 80,
                            child: Text(
                              "Thời gian tổ chức: Từ " +
                                  formatDate
                                      .format(eventResultModel.db.time_start
                                          .toLocal())
                                      .toString() +
                                  " Đến " +
                                  formatDate
                                      .format(eventResultModel.db.time_end
                                          .toLocal())
                                      .toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                height: 1.5,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/diadiem.png',
                            width: 30,
                            height: 30,
                          ),
                          Container(
                              width: deviceSize.width - 80,
                              child: Text(
                                "Địa điểm: " + eventResultModel.db.location,
                                style: TextStyle(
                                  height: 1.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          Container(),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/thoigiandangky.png',
                            width: 30,
                            height: 30,
                          ),
                          Text(
                            " Hạn đăng ký tới: ",
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                          Text(formatDate
                              .format(eventResultModel.db.time_start)
                              .toString())
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/noidung.png',
                            width: 30,
                            height: 30,
                          ),
                          Column(
                            children: [
                              Container(
                                  width: deviceSize.width - 80,
                                  child: Text(
                                    " Nội dung: ",
                                    style: TextStyle(
                                      height: 1.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                              Container(
                                width: deviceSize.width - 80,
                                child: Html(
                                  data: eventResultModel.db.mo_ta,
                                  style: {
                                    "table": Style(
                                      backgroundColor: Color.fromARGB(
                                          0x50, 0xee, 0xee, 0xee),
                                    ),
                                    "tr": Style(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: Colors.grey)),
                                    ),
                                    "th": Style(
                                      padding: EdgeInsets.all(6),
                                      backgroundColor: Colors.grey,
                                    ),
                                    "td": Style(
                                      padding: EdgeInsets.all(6),
                                    ),
                                    "var": Style(fontFamily: 'serif'),
                                  },
                                  customRender: {
                                    "flutter": (RenderContext context,
                                        Widget child, attributes, _) {
                                      return FlutterLogo(
                                        style:
                                            (attributes['horizontal'] != null)
                                                ? FlutterLogoStyle.horizontal
                                                : FlutterLogoStyle.markOnly,
                                        textColor: context.style.color,
                                        size: context.style.fontSize.size * 5,
                                      );
                                    },
                                  },
                                  onLinkTap: (url) {
                                    print("Opening $url...");
                                  },
                                  onImageTap: (src) {
                                    print(src);
                                  },
                                  onImageError: (exception, stackTrace) {
                                    print(exception);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
