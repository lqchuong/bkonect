import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseModelApi.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseWidgetAuthentication.dart';
import 'package:worldsoft_maintain/Common/BaseClass/DioClientInit.dart';
import 'package:worldsoft_maintain/Common/Config.dart';
import 'package:worldsoft_maintain/Common/HandleWebApi/ServerError.dart';
import 'package:worldsoft_maintain/Common/tiengviet.dart';
import 'package:worldsoft_maintain/Model/ApiResult/CountNotificationModel.dart';
import 'package:worldsoft_maintain/Model/ApiResult/EventResultModel.dart';
import 'package:worldsoft_maintain/Model/ApiResult/NotifyNumberModel.dart';
import 'package:worldsoft_maintain/Model/ApiResult/RegisterPostApiModel.dart';
import 'package:worldsoft_maintain/Model/MainPage/NotificationModel.dart';
import 'package:worldsoft_maintain/Views/Calendar/CalendarPage.dart';
import 'package:worldsoft_maintain/Views/Common/Home/HomeClient.dart';
import 'package:dio/dio.dart';
import 'package:worldsoft_maintain/Views/Find/FindPartner.dart';
import 'package:worldsoft_maintain/Views/Setting/SettingPage.dart';
import '../../../LocalStoreKey.dart';
import '../../../routes.dart';
import 'WaitingConfirm.dart';

class HomePage extends BaseWidgetAuthentication {
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}

class _HomePageState extends BaseWidgetAuthenticationState<HomePage> {
  Size deviceSize;
  NotifyNumberModel notifyNumber = new NotifyNumberModel();
  CountNotificationModel countNotificationModel = new CountNotificationModel();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final LocalStorage storage = new LocalStorage(LocalStoreKey.keyStore);
  Dio dio;
  ProgressDialog pr;
  HomeClient apiClient;
  RegisterPostApiModel userInfoModel;

  List<EventResultModel> listEventShowInView = [];
  List<EventResultModel> listApiResultTotal = [];
  List<EventResultModel> listApiResultJoined = [];
  List<EventResultModel> listApiResultInvited = [];

  String dropdownValue = "Tất cả sự kiện";

  final formatDate = new DateFormat(formatDateString);
  List<Widget> _widgetOptions;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    getListEvent();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  initState() {
    super.initState();
    notifyNumber.tong_su_kien = 0;
    notifyNumber.su_kien_duoc_moi = 0;
    notifyNumber.su_kien_tham_gia = 0;
    loading = true;
    setState(() {});
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      await checkInternet();
      // Got a new connectivity status!
    });
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> msg) async {
        showAcceptCustomButton(
            "Xem",
            "Bạn có 1 thông báo: " + msg["notification"]["title"],
            msg["notification"]["body"],
            nextPage);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> msg) async {
        nextPage(msg);
      },
      onResume: (Map<String, dynamic> msg) async {
        nextPage(msg);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    _firebaseMessaging.subscribeToTopic("matchscore");
  }

  nextPage(msg) async {
    try {
      var data = msg["data"]["id"];

      var noti = (await getnotification(data)).data;
      await Navigator.pushNamed(context, noti.menu,
              arguments: json.decode(noti.param))
          .then((value) => {});
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  functionfirstLoad() async {
    await super.functionfirstLoad();
    // await insertToken();
    // var postToken = await homeapi.getListCompanyRecommend();
    if (user != null) {
      dio = createDioClientAuthentication(storage);
      dio.options.headers["Content-Type"] = "application/json";
      apiClient = new HomeClient(dio);
      getUserInfo();
    }
    var token = await _firebaseMessaging.getToken();
    await apiClient.registertokennoti(token);
    // loading = false;
    // setState(() {});
  }

  Future<BaseModel<NotificationModel>> getnotification(String id) async {
    NotificationModel response;
    try {
      response = await apiClient.getnotification(id);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()
        ..setException(ServerError.withError(error, context, pr));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<NotifyNumberModel>> getListNotifyEvent() async {
    NotifyNumberModel response;
    try {
      response = await apiClient.getListNotifyEvent();
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()
        ..setException(ServerError.withError(error, context, pr));
    }
    notifyNumber = response;
    // listProgram = listContentApiResult.map((e) => e.db).toList();
    countNotification();
    return BaseModel()..data = response;
  }

  Future<BaseModel<CountNotificationModel>> countNotification() async {
    CountNotificationModel response;
    try {
      response = await apiClient.countNotification();
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()
        ..setException(ServerError.withError(error, context, pr));
    }
    countNotificationModel = response;
    // listProgram = listContentApiResult.map((e) => e.db).toList();
    getListEvent();

    return BaseModel()..data = response;
  }

  Future<BaseModel<RegisterPostApiModel>> getUserInfo() async {
    RegisterPostApiModel response;

    try {
      response = await apiClient.getUserInformation();
      userInfoModel = response;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()
        ..setException(ServerError.withError(error, context, pr));
    }
    if (userInfoModel.db.status == 1) {
      getListNotifyEvent();
    } else {
      // Navigator.pushNamed(context, Routes.WaitingConfirm);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => WaitingConfirm()),
        (Route<dynamic> route) => true,
      );
    }

    return BaseModel()..data = response;
  }

  Future<BaseModel<List<EventResultModel>>> getListEvent() async {
    List<EventResultModel> responseTotal;
    List<EventResultModel> responseInvited;
    List<EventResultModel> responseJoined;

    try {
      responseTotal = await apiClient.getListEvent("0");
      responseInvited = await apiClient.getListEvent("1");
      responseJoined = await apiClient.getListEvent("3");

      listApiResultTotal = responseTotal;
      listApiResultInvited = responseInvited;
      listApiResultJoined = responseJoined;
      if (dropdownValue == "Tất cả sự kiện") {
        listEventShowInView = listApiResultTotal;
      }
      if (dropdownValue == "Sự kiện được mời") {
        listEventShowInView = responseInvited;
      }
      if (dropdownValue == "Sự kiện đã tham gia") {
        listEventShowInView = responseJoined;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()
        ..setException(ServerError.withError(error, context, pr));
    }
    loading = false;
    setState(() {});
    return BaseModel()..data = responseTotal;
  }

  Future updateStatusEvent(String id, int status, int index) async {
    try {
      if (status == 3) {
        showSuccess("SỰ KIỆN", "Tham gia sự kiện thành công");
      } else {
        showSuccess("SỰ KIỆN", "Từ chối tham gia sự kiện thành công");
      }
      listApiResultTotal[index].check_in_status = status;
      setState(() {});
      await apiClient.updateStatusEvent(id, status);
      getListEvent();
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()
        ..setException(ServerError.withError(error, context, pr));
    }
  }

  @override
  buildwidget(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    _widgetOptions = <Widget>[
      fragmentEvent(),
      CalendarPage(),
      FindPartner(),
      SettingPage(),
    ];
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Event',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Partner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget fragmentEvent() {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Routes.NotificationIndexPage)
                .then((value) => {countNotification()});
          },
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.NotificationIndexPage);
                  },
                  icon: Icon(Icons.notifications),
                ),
              ),
              (countNotificationModel.tong_thong_bao > 0)
                  ? Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(
                            20.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            (countNotificationModel.tong_thong_bao > 99)
                                ? "99+"
                                : countNotificationModel.tong_thong_bao
                                    .toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ))
                  : Container()
            ],
          ),
        ),
        title: Text("BKA Connect"),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.pushNamed(context, Routes.EventIndexPage)
                    .then((value) => {setState(() {})});
              }),
          PopupMenuButton<String>(
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return <String>[
                "Tất cả sự kiện",
                "Sự kiện được mời",
                "Sự kiện đã tham gia"
              ].map((String choice) {
                return PopupMenuItem<String>(
                    value: choice, child: Text(choice));
              }).toList();
            },
          ),
        ],
        backgroundColor: Colors.blue,
      ),
      body: Container(
        width: deviceSize.width,
        height: deviceSize.height,
        color: Colors.grey[200],
        child: (listEventShowInView.isEmpty)
            ? Center(child: Text("Chưa có sự kiện nào"))
            : SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                header: WaterDropHeader(),
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: ListView.builder(
                    itemCount: listEventShowInView.length,
                    itemBuilder: (context, index) {
                      return cardViewEvent(listEventShowInView[index], index);
                    }),
              ),
      ),
    );
  }

  void _select(String choice) {
    setState(() {
      dropdownValue = choice;
      if (choice == "Tất cả sự kiện") {
        listEventShowInView = listApiResultTotal;
      }
      if (choice == "Sự kiện được mời") {
        listEventShowInView = listApiResultInvited;
      }
      if (choice == "Sự kiện đã tham gia") {
        listEventShowInView = listApiResultJoined;
      }
    });
  }

  cardViewEvent(EventResultModel eventResultModel, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.EventDetailPage, arguments: {
          "event_id": eventResultModel.db.id,
          // "index": index
        }).then((value) => {getListEvent()});
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 7, 10, 10),
        child: Container(
          width: deviceSize.width - 20,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              10.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Container(
                    width: deviceSize.width - 20,
                    height: 150,
                    decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(20.0),
                        // color: Colors.red,
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                (eventResultModel.db.logo != null)
                                    ? generateUrl(eventResultModel.db.logo)
                                    : noImgUrl),
                            fit: BoxFit.cover)),
                    //margin: EdgeInsets.only(left: 16.0),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  eventResultModel.db.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[900],
                      fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/diadiem.png',
                      width: 25,
                      height: 25,
                    ),
                    // Text(
                    //   " Địa điểm: ",
                    //   style: TextStyle(fontWeight: FontWeight.w900),
                    // ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        width: deviceSize.width - 80,
                        child: Text(
                          (eventResultModel.db.location != null)
                              ? eventResultModel.db.location
                              : "Chưa có địa điểm",
                          style: TextStyle(
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    Container(),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/thoigian.png',
                      width: 25,
                      height: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: deviceSize.width - 80,
                      child: Text(
                        formatDate
                                .format(
                                    eventResultModel.db.time_start.toLocal())
                                .toString() +
                            " - " +
                            formatDate
                                .format(eventResultModel.db.time_end.toLocal())
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
                  children: [
                    Icon(Icons.arrow_right),
                    Text(
                      "Xem chi tiết",
                      style: TextStyle(color: Colors.blue),
                    ),
                    Spacer(),
                    (eventResultModel.trang_thai == 1)
                        ? Text(
                            "Đang diễn ra",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          )
                        : (eventResultModel.trang_thai == 2)
                            ? Text(
                                "Đã bị hủy",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              )
                            : (eventResultModel.trang_thai == 3)
                                ? Text(
                                    "Đã kết thúc",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    "Sắp tới",
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold),
                                  ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                (eventResultModel.check_in_status == 1 &&
                            eventResultModel.trang_thai == 1 ||
                        eventResultModel.check_in_status == 1 &&
                            eventResultModel.trang_thai == 4)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: deviceSize.width * 0.33,
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
                                                  2,
                                                  index);
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
                                        desc: "Bạn chắc chắn muốn từ chối " +
                                            eventResultModel.db.title)
                                    .show();
                              },
                              color: hexToColor("#CB0000"),
                              textColor: Colors.white,
                              child: Text(
                                "Từ chối",
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                            width: deviceSize.width * 0.33,
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
                                                  3,
                                                  index);
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
                                        desc: "Bạn chắc chắn muốn tham gia " +
                                            eventResultModel.db.title)
                                    .show();
                              },
                              color: hexToColor("#005A24"),
                              textColor: Colors.white,
                              child: Text(
                                "Tham gia",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ],
                      )
                    : (eventResultModel.check_in_status == 3)
                        ? Row(
                            children: [
                              Spacer(),
                              Text(
                                "ĐÃ ĐĂNG KÝ THAM DỰ",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              )
                            ],
                          )
                        : (eventResultModel.check_in_status == 4)
                            ? Container(
                                child: Row(
                                children: [
                                  Spacer(),
                                  Text(
                                    "ĐÃ THAM DỰ",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  )
                                ],
                              ))
                            : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
