import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:localstorage/localstorage.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseModelApi.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseWidgetAuthentication.dart';
import 'package:dio/dio.dart';
import 'package:worldsoft_maintain/Common/BaseClass/DioClientInit.dart';
import 'package:worldsoft_maintain/Common/HandleWebApi/ServerError.dart';
import 'package:worldsoft_maintain/Model/ApiResult/EventResultModel.dart';
import '../../LocalStoreKey.dart';
import 'Api/EventClient.dart';

class PostReview extends BaseWidgetAuthentication {
  @override
  State<StatefulWidget> createState() => new _PostReviewState();
}

class _PostReviewState extends BaseWidgetAuthenticationState<PostReview> {
  Size deviceSize;

  final LocalStorage storage = new LocalStorage(LocalStoreKey.keyStore);
  Dio dio;
  ProgressDialog pr;
  EventClient apiClient;
  EventResultModel eventResultModel;

  int mark = 3;
  TextEditingController reviewNoteController = new TextEditingController();

  _PostReviewState() {
    dio = createDioClientAuthentication(storage);
    dio.options.headers["Content-Type"] = "application/json";
    apiClient = new EventClient(dio);
  }

  Future<dynamic> postReview(String id_event, String comment, int rate) async {
    var response;
    try {
      response = await apiClient.postReview(id_event, rate, comment);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()
        ..setException(ServerError.withError(error, context, pr));
    }
    loading = false;
    setState(() {});
    showAcceptCustomButton("Xác nhận", "ĐÁNH GIÁ", "Bạn đã đánh giá thành công",
        () {
      Navigator.pop(context);
    });

    return BaseModel()..data = response;
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
      setState(() {});
    });
  }

  @override
  buildwidget(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("GỬI ĐÁNH GIÁ"),
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: FloatingActionButton.extended(
            backgroundColor: Colors.red,
            onPressed: () {
              loading = true;
              setState(() {});
              postReview(
                  eventResultModel.db.id, reviewNoteController.text, mark);
            },
            label: Text("GỬI LÊN"),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild.unfocus();
          }
        },
        child: Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Đánh giá sự kiện",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: RatingBar.builder(
                    initialRating: mark.toDouble(),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      mark = rating.toInt();
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: deviceSize.width,
                  child: TextField(
                    controller: reviewNoteController,
                    decoration: InputDecoration(
                        hoverColor: Colors.red,
                        fillColor: Colors.blue[100],
                        filled: true,
                        labelText: "Bình luận",
                        labelStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        hintText: "Nhập đánh giá của bạn ...",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
