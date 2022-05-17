import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseModelApi.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseWidgetAuthentication.dart';
import 'package:worldsoft_maintain/Common/BaseClass/DioClientInit.dart';
import 'package:worldsoft_maintain/Common/Config.dart';
import 'package:worldsoft_maintain/Common/HandleWebApi/ServerError.dart';
import 'package:worldsoft_maintain/Model/ApiResult/ContentResultModel.dart';
import 'package:worldsoft_maintain/Model/ApiResult/FileResultModel.dart';
import 'package:worldsoft_maintain/Model/EventFileModel.dart';
import 'package:worldsoft_maintain/Model/EventModel.dart';
import 'package:dio/dio.dart';
import 'package:worldsoft_maintain/Model/EventProgramModel.dart';
import 'package:worldsoft_maintain/Views/Event/Api/EventClient.dart';
import '../../../LocalStoreKey.dart';

class ContentEventPage extends BaseWidgetAuthentication {
  @override
  State<StatefulWidget> createState() => new _ContentEventPageState();
}

class _ContentEventPageState
    extends BaseWidgetAuthenticationState<ContentEventPage>
    with SingleTickerProviderStateMixin {
  Size deviceSize;
  EventModel eventModel;
  TabController _controller;

  final LocalStorage storage = new LocalStorage(LocalStoreKey.keyStore);
  Dio dio;
  ProgressDialog pr;
  EventClient apiClient;

  List<ContentResultModel> listContentApiResult = [];
  List<EventProgramModel> listProgram;

  List<FileResultModel> listFileApiResult = [];
  List<EventFileModel> listEventFile;
  final formatTime = new DateFormat(formatHourMinuteString);

  _ContentEventPageState() {
    dio = createDioClientAuthentication(storage);
    dio.options.headers["Content-Type"] = "application/json";
    apiClient = new EventClient(dio);
  }

  Future<BaseModel<List<ContentResultModel>>> getListContent(String id) async {
    List<ContentResultModel> response;
    try {
      response = await apiClient.getListProgram(id);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()
        ..setException(ServerError.withError(error, context, pr));
    }
    listContentApiResult = response;
    listProgram = listContentApiResult.map((e) => e.db).toList();

    getListFile(eventModel.id);

    return BaseModel()..data = response;
  }

  Future<BaseModel<List<FileResultModel>>> getListFile(String id) async {
    List<FileResultModel> response;
    try {
      response = await apiClient.getListFile(id);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()
        ..setException(ServerError.withError(error, context, pr));
    }
    listFileApiResult = response;
    listEventFile = listFileApiResult.map((e) => e.db).toList();
    loading = false;
    setState(() {});
    return BaseModel()..data = response;
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
    _controller = new TabController(length: 2, vsync: this);
    Future.delayed(Duration.zero, () {
      eventModel = ModalRoute.of(context).settings.arguments;
      loading = true;
      setState(() {});
      getListContent(eventModel.id);
    });
  }

  @override
  buildwidget(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
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
          height: deviceSize.height,
          child: Column(
            children: [
              Container(
                width: deviceSize.width,
                height: 40,
                color: Colors.white70,
                child: TabBar(
                  labelColor: Colors.black,
                  labelStyle: TextStyle(color: Colors.black),
                  unselectedLabelColor: Colors.grey[400],
                  indicatorColor: Colors.red,
                  controller: _controller,
                  tabs: [
                    new Tab(
                      // icon: const Icon(Icons.people),
                      text: 'Chương trình',
                    ),
                    new Tab(
                      // icon: const Icon(Icons.star),
                      text: 'File đính kèm',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Container(
                width: deviceSize.width,
                height: deviceSize.height - 150,
                child: TabBarView(
                  controller: _controller,
                  children: <Widget>[
                    ListView.builder(
                        itemCount: listProgram.length,
                        itemBuilder: (context, index) {
                          return cardViewStepContent(listProgram[index]);
                        }),
                    ListView.builder(
                        itemCount: listEventFile.length,
                        itemBuilder: (context, index) {
                          return cardViewFile(listEventFile[index]);
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  cardViewStepContent(EventProgramModel eventProgramModel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Column(
        children: [
          Container(
            width: deviceSize.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                20.0,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    eventProgramModel.stt.toString() +
                        ". " +
                        (eventProgramModel.name ?? ""),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ((eventProgramModel.presenter ?? '').trim() != '')
                      ? Text(
                          "Người trình bày: " + eventProgramModel.presenter,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        )
                      : Container(),
                  Row(
                    children: <Widget>[
                      Container(
                        width: deviceSize.width - 50,
                        child: Html(
                          data: (eventProgramModel.description ?? ""),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        (formatTime
                                .format(eventProgramModel.start_time.toLocal())
                                .toString() +
                            "   "),
                        style: TextStyle(color: Colors.blue),
                      ),
                      Text(
                        (formatTime
                                .format(eventProgramModel.start_time.toLocal())
                                .toString() +
                            " - "),
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                      Text(
                        formatTime
                            .format(eventProgramModel.end_time.toLocal())
                            .toString(),
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  cardViewFile(EventFileModel eventFile) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Column(
        children: [
          Container(
            width: deviceSize.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                20.0,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        eventFile.file_name,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      RaisedButton(
                        onPressed: () {},
                        color: Color(0xffcc6202),
                        child: Text(
                          "Download",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
