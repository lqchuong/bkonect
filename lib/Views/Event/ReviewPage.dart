import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseModelApi.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseWidgetAuthentication.dart';
import 'package:dio/dio.dart';
import 'package:worldsoft_maintain/Common/BaseClass/DioClientInit.dart';
import 'package:worldsoft_maintain/Common/HandleWebApi/ServerError.dart';
import 'package:worldsoft_maintain/Model/ApiResult/EventResultModel.dart';
import 'package:worldsoft_maintain/Model/ApiResult/ReviewResultModel.dart';
import '../../LocalStoreKey.dart';
import '../../routes.dart';
import 'Api/EventClient.dart';

class ReviewPage extends BaseWidgetAuthentication {
  @override
  State<StatefulWidget> createState() => new _ReviewPageState();
}

class _ReviewPageState extends BaseWidgetAuthenticationState<ReviewPage> {
  Size deviceSize;

  final LocalStorage storage = new LocalStorage(LocalStoreKey.keyStore);
  Dio dio;
  ProgressDialog pr;
  EventClient apiClient;
  EventResultModel eventResultModel;
  List<ReviewResultModel> listReview = [];

  _ReviewPageState() {
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

    loading = false;
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      eventResultModel = ModalRoute.of(context).settings.arguments;
      getListReview(eventResultModel.db.id);
      setState(() {});
    });
  }

  Future<BaseModel<List<ReviewResultModel>>> getListReview(
      String id_event) async {
    List<ReviewResultModel> response;

    try {
      response = await apiClient.getListReview(id_event);
      listReview = response;
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
        title: Text("ĐÁNH GIÁ"),
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: (eventResultModel.check_in_status == 4)
          ? Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.red,
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.PostReview,
                            arguments: eventResultModel)
                        .then(
                            (value) => {getListReview(eventResultModel.db.id)});
                  },
                  label: Text("GỬI ĐÁNH GIÁ"),
                ),
              ),
            )
          : Container(),
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
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
              itemCount: listReview.length,
              itemBuilder: (context, index) {
                return (listReview[index].db.review_note != null)
                    ? cardViewReview(listReview[index], index + 1)
                    : Container();
              }),
        ),
      ),
    );
  }

  cardViewReview(ReviewResultModel temp, int index) {
    return Container(
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
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              index.toString() + ". " + temp.db.review_note,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              temp.db.review_note,
              style: TextStyle(height: 1.5),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                for (int i = 1; i <= temp.db.review_rate; i++)
                  Icon(
                    Icons.star,
                    color: Colors.yellow[800],
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
