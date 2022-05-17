import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:localstorage/localstorage.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseModelApi.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseWidgetAuthentication.dart';
import 'package:worldsoft_maintain/Common/BaseClass/DioClientInit.dart';
import 'package:worldsoft_maintain/Common/Config.dart';
import 'package:intl/intl.dart';
import 'package:worldsoft_maintain/Common/HandleWebApi/ServerError.dart';
import 'package:worldsoft_maintain/Common/tiengviet.dart';
import 'package:worldsoft_maintain/Model/ApiResult/EventResultModel.dart';
import 'package:worldsoft_maintain/Model/ApiResult/ImageIntroResultModel.dart';
import 'package:worldsoft_maintain/Views/Common/ViewMultiPhotoPage.dart';
import '../../LocalStoreKey.dart';
import '../../routes.dart';
import 'Api/EventClient.dart';
import 'package:dio/dio.dart';

class EventDetailPage extends BaseWidgetAuthentication {
  @override
  State<StatefulWidget> createState() => new _EventDetailPageState();
}

class _EventDetailPageState
    extends BaseWidgetAuthenticationState<EventDetailPage> {
  Size deviceSize;
  EventResultModel eventResultModel;
  String event_id;

  final formatDate = new DateFormat(formatTimeDateString);

  List<ImageIntroResultModel> listIamgeResult = [];

  List<ViewMultiPhotoItem> listImage = [];

  final LocalStorage storage = new LocalStorage(LocalStoreKey.keyStore);
  Dio dio;
  ProgressDialog pr;
  EventClient apiClient;
  // int index; // index của sự kiện trong list của trang trước

  _EventDetailPageState() {
    dio = createDioClientAuthentication(storage);
    dio.options.headers["Content-Type"] = "application/json";
    apiClient = new EventClient(dio);
  }

  @override
  functionfirstLoad() async {
    await super.functionfirstLoad();
    // await insertToken();
    // var postToken = await homeapi.getListCompanyRecommend();
    if (user != null) {}
    loading = true;
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      dynamic arg = ModalRoute.of(context).settings.arguments;
      event_id = arg["event_id"];
      // index = arg["index"].toInt();
      getDetailEvent(event_id);
    });
  }

  launchurl(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {}
  }

  Future<BaseModel<EventResultModel>> getDetailEvent(String event_id) async {
    EventResultModel response;
    try {
      response = await apiClient.getDetailEvent(event_id);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()
        ..setException(ServerError.withError(error, context, pr));
    }
    eventResultModel = response;
    getListImage(event_id);
    return BaseModel()..data = response;
  }

  Future<BaseModel<List<ImageIntroResultModel>>> getListImage(
      String event_id) async {
    List<ImageIntroResultModel> response;
    try {
      response = await apiClient.getImagesIntro(event_id);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()
        ..setException(ServerError.withError(error, context, pr));
    }
    listIamgeResult = response;
    for (ImageIntroResultModel temp in listIamgeResult) {
      ViewMultiPhotoItem viewMultiPhotoItem = new ViewMultiPhotoItem();
      viewMultiPhotoItem.photoUrl = BaseURL + temp.db.file_path;
      viewMultiPhotoItem.desc = '';
      listImage.add(viewMultiPhotoItem);
    }
    loading = false;
    setState(() {});
    return BaseModel()..data = response;
  }

  Future updateStatusEvent(String id, int status) async {
    try {
      eventResultModel.check_in_status = status;
      if (status == 3) {
        showSuccess("SỰ KIỆN", "Tham gia sự kiện thành công");
      } else {
        showSuccess("SỰ KIỆN", "Từ chối tham gia sự kiện thành công");
      }
      setState(() {});
      await apiClient.updateStatusEvent(id, status);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()
        ..setException(ServerError.withError(error, context, pr));
    }
    loading = false;
    setState(() {});
  }

  @override
  buildwidget(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    final List<Widget> imageSliders = listImage
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    child: Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            openMultiImg(listImage, 0, false);
                          },
                          child: Container(
                            // height: ,
                            width: deviceSize.width - 20,
                            height: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        generateUrl(item.photoUrl) ?? noImgUrl),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Color.fromARGB(200, 0, 0, 0),
                                    Color.fromARGB(0, 0, 0, 0)
                                  ]),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(''),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text("CHI TIẾT SỰ KIỆN"),
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
        child: Container(
          width: deviceSize.width,
          height: deviceSize.height * 0.9 - kToolbarHeight,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: deviceSize.height * 0.1,
                    width: deviceSize.width,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.ContentEventPage,
                                arguments: eventResultModel.db);
                          },
                          child: Container(
                            width: (deviceSize.width - 50) / 4,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/chuongtrinh.png',
                                    color: Color(0xff515150),
                                    width: 40,
                                  ),
                                  Text(
                                    "Chương trình",
                                    style: TextStyle(
                                      fontSize: deviceSize.width * 0.025,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.CompanyEventPage,
                                arguments: eventResultModel.db);
                          },
                          child: Container(
                            width: (deviceSize.width - 50) / 4,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/congty.png',
                                    color: Color(0xff515150),
                                    width: 40,
                                  ),
                                  Text(
                                    "Liên hệ",
                                    style: TextStyle(
                                        fontSize: deviceSize.width * 0.025),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.QAndAPage,
                                arguments: eventResultModel);
                          },
                          child: Container(
                            width: (deviceSize.width - 50) / 4,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/q&a.png',
                                    color: Color(0xff515150),
                                    width: 40,
                                  ),
                                  Text(
                                    "Q & A",
                                    style: TextStyle(
                                        fontSize: deviceSize.width * 0.025),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.ReviewPage,
                                arguments: eventResultModel);
                          },
                          child: Container(
                            width: (deviceSize.width - 50) / 4,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/danhgia.png',
                                    color: Color(0xff515150),
                                    width: 40,
                                  ),
                                  Text(
                                    "Đánh giá",
                                    style: TextStyle(
                                        fontSize: deviceSize.width * 0.025),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  (imageSliders.isNotEmpty)
                      ? Container(
                          width: deviceSize.width,
                          // height: deviceSize.height * 0.28,
                          child: CarouselSlider(
                            options: CarouselOptions(
                                autoPlay: false,
                                enlargeCenterPage: true,
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.height,
                                enableInfiniteScroll: false),
                            items: imageSliders,
                          ),
                        )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: (eventResultModel.check_in_status == 1 &&
                                eventResultModel.trang_thai == 1 ||
                            eventResultModel.check_in_status == 1 &&
                                eventResultModel.trang_thai == 4)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: deviceSize.width * 0.5 - 35,
                                height: deviceSize.height * 0.05,
                                child: RaisedButton(
                                  onPressed: () {
                                    Alert(
                                            context: context,
                                            type: AlertType.info,
                                            buttons: [
                                              DialogButton(
                                                color: hexToColor("#005A24"),
                                                child: Text(
                                                  "Đồng ý",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  updateStatusEvent(
                                                      eventResultModel.db.id,
                                                      2);
                                                },
                                                width: 120,
                                              ),
                                              DialogButton(
                                                color: hexToColor("#0062B1"),
                                                child: Text(
                                                  "Đóng",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                width: 120,
                                              )
                                            ],
                                            title: "Sự kiện",
                                            desc:
                                                "Bạn chắc chắn muốn từ chối " +
                                                    eventResultModel.db.title)
                                        .show();
                                  },
                                  color: hexToColor("#CB0000"),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Từ chối",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: deviceSize.width * 0.5 - 35,
                                height: deviceSize.height * 0.05,
                                child: RaisedButton(
                                  onPressed: () {
                                    Alert(
                                            context: context,
                                            type: AlertType.info,
                                            buttons: [
                                              DialogButton(
                                                color: hexToColor("#005A24"),
                                                child: Text(
                                                  "Đồng ý",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  updateStatusEvent(
                                                      eventResultModel.db.id,
                                                      3);
                                                },
                                                width: 120,
                                              ),
                                              DialogButton(
                                                color: hexToColor("#0062B1"),
                                                child: Text(
                                                  "Đóng",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                width: 120,
                                              )
                                            ],
                                            title: "Sự kiện",
                                            desc:
                                                "Bạn chắc chắn muốn tham gia " +
                                                    eventResultModel.db.title)
                                        .show();
                                  },
                                  color: hexToColor("#005A24"),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Tham gia",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : (eventResultModel.check_in_status == 3 ||
                                eventResultModel.check_in_status == 4)
                            ? Container(
                                width: deviceSize.width,
                                height: deviceSize.height * 0.05,
                                child: RaisedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, Routes.TicketPage,
                                        arguments: eventResultModel);
                                  },
                                  color: Color(0xff0062B1),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Vé mời",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              )
                            : Container(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: deviceSize.width,
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
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
                                            .format(eventResultModel
                                                .db.time_start
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
                                      (eventResultModel.db.location != null)
                                          ? "Địa điểm: " +
                                              eventResultModel.db.location
                                          : "Địa điểm: ",
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
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/noidung.png',
                                          width: 30,
                                          height: 30,
                                        ),
                                        Container(
                                            width: deviceSize.width - 80,
                                            child: Text(
                                              " Nội dung: ",
                                              style: TextStyle(
                                                height: 1.5,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                      ],
                                    ),
                                    Container(
                                      width: deviceSize.width - 40,
                                      child: Html(
                                        data: eventResultModel.db.mo_ta,
                                        style: {
                                          "body": Style(
                                            fontSize: FontSize(20),
                                          ),
                                        },
                                        onLinkTap: (url) {
                                          launchurl(url);
                                          // open url in a webview
                                        },
                                        onImageTap: (src) {
                                          openImg(src);
                                          // Display the image in large form.
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
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
