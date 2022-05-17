import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:dio/dio.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseModelApi.dart';
import 'package:worldsoft_maintain/Common/BaseClass/DioClientInit.dart';
import 'package:worldsoft_maintain/Model/ApiResult/RegisterPostApiModel.dart';
import 'package:worldsoft_maintain/Model/ApiResult/RegisterResultModel.dart';
import 'package:worldsoft_maintain/Model/Error/ErrorModel.dart';
import 'package:worldsoft_maintain/Model/RegisterModel.dart';
import '../../../LocalStoreKey.dart';
import '../../../routes.dart';
import '../LoadingPage.dart';
import 'RegisterClient.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  final LocalStorage storage = new LocalStorage(LocalStoreKey.keyStore);
  bool loading = false;
  bool isInfoExisted = false;

  bool checkValidSdt = false;
  bool checkValidMail = false;
  final textPhoneController = TextEditingController();
  final textEmailController = TextEditingController();
  final textPasswordController = TextEditingController();
  final textConfirmPasswordController = TextEditingController();

  List<ErrorModel> listError = [];
  RegisterPostApiModel registerPostApiModel = new RegisterPostApiModel();
  RegisterModel registerModel = new RegisterModel();

  bool isEnable = true;

  Dio dio;
  ProgressDialog pr;
  RegisterClient apiClient;
  _RegisterState() {
    dio = createDioClientNoAuthentication(storage);
    dio.options.headers["Content-Type"] = "application/json";
    apiClient = new RegisterClient(dio);
  }

  @override
  void initState() {
    super.initState();
    textPhoneController.addListener(() {
      checkValidPhone();
    });
    textEmailController.addListener(() {
      checkValidEmail();
    });
    // getListCompany();
  }

  void checkValidPhone() {
    checkValidSdt = RegExp(r"^(?:[+0]9)?[0-9]{10}$")
        .hasMatch(textPhoneController.text.trim());
    setState(() {});
  }

  void checkValidEmail() {
    checkValidMail = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(textEmailController.text.trim());
    setState(() {});
  }

  Future<BaseModel<RegisterResultModel>> registerAccount(
      RegisterPostApiModel checkModel) async {
    RegisterResultModel response;
    try {
      response = await apiClient.registerAccount(checkModel);
    } catch (error, stacktrace) {
      loading = false;
      setState(() {});

      List<dynamic> myListError = error.response.data;
      listError = myListError.map((e) => ErrorModel.fromJson(e)).toList();
      isInfoExisted = false;
      if (listError.where((e) => e.Key == "db.dienthoai").length > 0) {
        isInfoExisted = true;
        showWarning(
            "THÔNG TIN TÀI KHOẢN", "Số điện thoại này đã có người sử dụng");
      }
      if (listError.where((e) => e.Key == "db.email").length > 0 &&
          isInfoExisted == false) {
        isInfoExisted = true;
        showWarning("THÔNG TIN TÀI KHOẢN", "Email này đã có người sử dụng");
      }
      if (listError.where((e) => e.Key == "db.password").length > 0 &&
          isInfoExisted == false) {
        isInfoExisted = true;
        showWarning("THÔNG TIN TÀI KHOẢN", "Mật khẩu không hợp lệ");
      }
      isEnable = true;

      if (!isInfoExisted) {
        Navigator.pushNamed(context, Routes.RegisterInfoPage,
            arguments: registerPostApiModel);
      }
    }

    loading = false;
    setState(() {});
    return BaseModel()..data = response;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textEmailController.dispose();
    textPasswordController.dispose();
    textConfirmPasswordController.dispose();
    textPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loading == true) {
      return LoadingPage();
    }
    var deviceSize = MediaQuery.of(context).size;
    return FutureBuilder(
      future: storage.ready,
      builder: (BuildContext context, snapshot) {
        if (snapshot.data == true) {
          return Scaffold(
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.blue,
                  onPressed: () {
                    if (isEnable == true) {
                      isEnable = false;
                      setState(() {});

                      if (!checkValidMail || !checkValidSdt) {
                        showWarning("THÔNG TIN TÀI KHOẢN",
                            "Số điện thoại hoặc Email không hợp lệ");
                      } else if (textPasswordController.text !=
                          textConfirmPasswordController.text) {
                        showWarning(
                            "THÔNG TIN TÀI KHOẢN", "Mật khẩu không trùng khớp");
                      } else {
                        loading = true;
                        setState(() {});
                        registerModel.email = textEmailController.text;
                        registerModel.dienthoai = textPhoneController.text;
                        registerPostApiModel.password =
                            textPasswordController.text;
                        registerPostApiModel.db = registerModel;

                        registerAccount(registerPostApiModel);
                      }
                    }
                  },
                  label: Text("TIẾP THEO"),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            resizeToAvoidBottomPadding: true,
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
                    image: AssetImage("assets/images/background.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 70,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Container(
                              width: deviceSize.width,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "QUAY LẠI",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          width: deviceSize.width,
                          child: Text(
                            "ĐĂNG KÝ THÔNG TIN TÀI KHOẢN",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Điện thoại",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: textPhoneController,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.phone,
                                color: checkValidSdt
                                    ? Colors.green
                                    : Colors.black26,
                              ),
                              suffixIcon: Icon(
                                Icons.check_circle,
                                color: checkValidSdt
                                    ? Colors.green
                                    : Colors.black26,
                              ),
                              hintText: "Nhập số",
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.5),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 16.0)),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Email",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: textEmailController,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: checkValidMail
                                    ? Colors.green
                                    : Colors.black26,
                              ),
                              suffixIcon: Icon(
                                Icons.check_circle,
                                color: checkValidMail
                                    ? Colors.green
                                    : Colors.black26,
                              ),
                              hintText: "Email",
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.5),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 16.0)),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Mật khẩu",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: textPasswordController,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                          obscureText: true,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.black),
                            contentPadding: const EdgeInsets.all(16.0),
                            hintText: "Mật khẩu",
                            hintStyle: TextStyle(color: Colors.white38),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Xác nhận mật khẩu",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: textConfirmPasswordController,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                          obscureText: true,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.black),
                            contentPadding: const EdgeInsets.all(16.0),
                            hintText: "Nhập lại mật khẩu",
                            hintStyle: TextStyle(color: Colors.white38),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: deviceSize.width,
                            child: Text(
                              "QUAY LẠI ĐĂNG NHẬP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  showWarning(title, msg) async {
    Alert(
            context: context,
            type: AlertType.warning,
            buttons: [
              DialogButton(
                color: Colors.red,
                child: Text(
                  "Đóng",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
              )
            ],
            title: title,
            desc: msg ?? "")
        .show();
  }
}
