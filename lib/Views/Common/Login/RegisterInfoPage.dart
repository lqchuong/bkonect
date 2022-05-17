import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localstorage/localstorage.dart';
import 'package:dio/dio.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseModelApi.dart';
import 'package:worldsoft_maintain/Common/BaseClass/DioClientInit.dart';
import 'package:worldsoft_maintain/Common/Config.dart';
import 'package:worldsoft_maintain/Common/HandleWebApi/ServerError.dart';
import 'package:worldsoft_maintain/Model/ApiResult/CountryInRegister.dart';
import 'package:worldsoft_maintain/Model/ApiResult/RegisterPostApiModel.dart';
import 'package:worldsoft_maintain/Model/ApiResult/RegisterResultModel.dart';
import 'package:worldsoft_maintain/Model/Error/ErrorModel.dart';
import 'package:worldsoft_maintain/Model/RegisterModel.dart';
import '../../../LocalStoreKey.dart';
import '../../../routes.dart';
import '../LoadingPage.dart';
import 'RegisterClient.dart';

class RegisterInfoPage extends StatefulWidget {
  @override
  _RegisterInfoPageState createState() => _RegisterInfoPageState();
}

class _RegisterInfoPageState extends State<RegisterInfoPage> {
  final LocalStorage storage = new LocalStorage(LocalStoreKey.keyStore);
  Dio dio;
  ProgressDialog pr;
  RegisterClient apiClient;
  bool loading = false;
  _RegisterInfoPageState() {
    dio = createDioClientNoAuthentication(storage);
    dio.options.headers["Content-Type"] = "application/json";
    apiClient = new RegisterClient(dio);
  }

  RegisterPostApiModel registerPostApiModel;
  RegisterModel registerModel = new RegisterModel();

  // List<CompanyInRegister> listCompany = [];
  // CompanyInRegister companyChosen;

  List<CountryInRegister> listCountry = [];
  CountryInRegister countryChosen;

  // List<FacultyModel> listFaculty = [];
  // FacultyModel facultyChosen;

  List<ErrorModel> listError = [];
  bool isEnable = true;

  String sex;
  var _currencies = [
    "Ông",
    "Bà",
  ];

  final fullNameController = TextEditingController();
  // final schoolYearController = TextEditingController();
  // final positionController = TextEditingController();
  final fieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      registerPostApiModel = ModalRoute.of(context).settings.arguments;
      registerModel = registerPostApiModel.db;

      getListCountry();
      loading = true;
      setState(() {});
    });
    // getListCompany();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    fullNameController.dispose();
    // schoolYearController.dispose();
    // positionController.dispose();
    fieldController.dispose();
    super.dispose();
  }

  Future<File> compressFile(File file) async {
    var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, file.absolute.path + "123" + "." + ".png",
        quality: 88, format: CompressFormat.png);
    return result;
  }

  File _image; // avatar

  Future getImage(String source) async {
    var image = null;
    if (source == 'camera') {
      image = await ImagePicker.pickImage(
          source: ImageSource.camera, maxHeight: 1000, maxWidth: 1000);
    } else {
      image = await ImagePicker.pickImage(
          source: ImageSource.gallery, maxHeight: 1000, maxWidth: 1000);
    }
    if (image != null) {
      _image = await compressFile(image);
      setState(() {});
    }
  }

  getMultiPartFile(File image) async {
    if (image == null) {
      showWarning("Phải chọn hình ảnh đại diện", "");
      return;
    }
    try {
      String fileName = image.path.split('/').last;

      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(image.path, filename: fileName),
      });
      dio.options.headers.clear();

      dio
          .post(BaseURL + '/sys_user.ctr/upload_file',
              data: formData,
              options: Options(
                  method: 'POST',
                  responseType: ResponseType.json // or ResponseType.JSON
                  ))
          .then((response) => {
                registerModel.avatar_link = response.data["path"],
                registerModel.id_company = "0",
                registerModel.id_faculty = "0",
                registerAccount(registerPostApiModel)
              })
          .catchError((error) => print(error));
    } catch (e) {
      print(e.toString());
      isEnable = true;
      setState(() {});
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        getImage('galery');
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      getImage('camera');
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  // Future<BaseModel<List<CompanyInRegister>>> getListCompany() async {
  //   List<CompanyInRegister> response;
  //   try {
  //     response = await apiClient.getListCompany();
  //   } catch (error, stacktrace) {
  //     print("Exception occured: $error stackTrace: $stacktrace");
  //     return BaseModel()
  //       ..setException(ServerError.withError(error, context, pr));
  //   }
  //   listCompany = response;
  // companyChosen = listCompany[0];
  // registerModel.id_company = "0";
  //   // listProgram = listContentApiResult.map((e) => e.db).toList();
  //   getListCountry();
  //   return BaseModel()..data = response;
  // }

  Future<BaseModel<List<CountryInRegister>>> getListCountry() async {
    List<CountryInRegister> response;
    try {
      response = await apiClient.getListCountry();
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()
        ..setException(ServerError.withError(error, context, pr));
    }
    listCountry = response;

    loading = false;
    setState(() {});
    return BaseModel()..data = response;
  }

  // Future<BaseModel<List<FacultyModel>>> getListCFaculty() async {
  //   List<FacultyModel> response;
  //   try {
  //     response = await apiClient.getListFaculty();
  //   } catch (error, stacktrace) {
  //     print("Exception occured: $error stackTrace: $stacktrace");
  //     return BaseModel()
  //       ..setException(ServerError.withError(error, context, pr));
  //   }
  //   listFaculty = response;
  //   facultyChosen = listFaculty[0];
  //   registerModel.id_faculty = "0";
  //   // listProgram = listContentApiResult.map((e) => e.db).toList();
  //   loading = false;
  //   setState(() {});
  //   return BaseModel()..data = response;
  // }

  showSuccess() async {
    Alert(
            context: context,
            type: AlertType.success,
            buttons: [
              DialogButton(
                color: Colors.black,
                child: Text(
                  "Đóng",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, Routes.home, (Route<dynamic> route) => false),
                width: 120,
              )
            ],
            title: "Bạn đã đăng ký thành công",
            desc: "Tài khoản đang chờ duyệt")
        .show();
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

  Future<BaseModel<RegisterResultModel>> registerAccount(
      RegisterPostApiModel checkModel) async {
    dio.options.headers["Content-Type"] = "application/json";

    RegisterResultModel response;
    try {
      response = await apiClient.registerAccount(checkModel);
    } catch (error, stacktrace) {
      List<dynamic> myListError = error.response.data;
      listError = myListError.map((e) => ErrorModel.fromJson(e)).toList();

      var isInfoExisted = false;
      if (listError.where((e) => e.Key == "db.id_country").length > 0) {
        isInfoExisted = true;
        showWarning("Không hợp lệ", "Phải chọn quốc gia");
      }
      if (listError.where((e) => e.Key == "db.id_company").length > 0 &&
          isInfoExisted == false) {
        isInfoExisted = true;
        showWarning("Không hợp lệ", "Phải chọn công ty");
      }
      if (listError.where((e) => e.Key == "db.id_faculty").length > 0 &&
          isInfoExisted == false) {
        isInfoExisted = true;
        showWarning("Không hợp lệ", "Phải chọn khoa");
      }
      if (listError.where((e) => e.Key == "db.LastName").length > 0 &&
          isInfoExisted == false) {
        isInfoExisted = true;
        showWarning("Không hợp lệ", "Phải nhập tên");
      }

      if (listError.where((e) => e.Key == "db.sex").length > 0 &&
          isInfoExisted == false) {
        isInfoExisted = true;
        showWarning("Không hợp lệ", "Phải chọn danh xưng");
      }
      if (listError.where((e) => e.Key == "db.position").length > 0 &&
          isInfoExisted == false) {
        isInfoExisted = true;
        showWarning("Không hợp lệ", "Phải nhập chức vụ");
      }

      if (isInfoExisted) {
        loading = false;
        setState(() {});
      } else {
        if (listError.length > 0) {
          showWarning("Không hợp lệ", "Vui lòng kiểm tra lại");
        }
      }

      return BaseModel()..data = response;
    }
    isEnable = true;
    setState(() {});
    if (listError.length == 0) {
      showSuccess();
    } else {
      loading = false;
      setState(() {});
    }

    return BaseModel()..data = response;
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
            resizeToAvoidBottomPadding: true,
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.blue,
                  onPressed: () {
                    // loading = true;
                    // setState(() {});
                    if (isEnable = true) {
                      isEnable = false;
                      setState(() {});
                      // registerModel.FirstName = firstNameController.text;
                      // registerModel.LastName = lastNameController.text;
                      registerModel.LastName = fullNameController.text;
                      registerModel.field = fieldController.text;
                      // if (countryChosen != null)
                      registerModel.id_country = countryChosen.id;
                      // registerModel.position = positionController.text;
                      // registerModel.school_year = schoolYearController.text;
                      // if (facultyChosen != null)
                      //   registerModel.id_faculty = facultyChosen.id;
                      if (sex == "Ông") {
                        registerModel.sex = 1;
                      } else if (sex == "Bà") {
                        registerModel.sex = 2;
                      }
                      // registerModel.day_of_birth = selectedDate;
                      // if (companyChosen != null)
                      //   registerModel.id_company = companyChosen.id;

                      getMultiPartFile(_image);
                    }
                  },
                  label: Text("ĐĂNG KÝ TÀI KHOẢN"),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
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
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 80),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 30,
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
                            height: 30,
                          ),
                          Container(
                            width: deviceSize.width,
                            child: Text(
                              "ĐĂNG KÝ THÔNG TIN CÁ NHÂN",
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
                            "Danh xưng",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          FormField<String>(
                            builder: (FormFieldState<String> state) {
                              return InputDecorator(
                                decoration: InputDecoration(
                                  hintText: "Chọn danh xưng ...",
                                  hintStyle: TextStyle(color: Colors.white38),
                                  fillColor: Colors.grey.withOpacity(0.5),
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                ),
                                isEmpty: sex == null,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: sex,
                                    isDense: true,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        sex = newValue;
                                        state.didChange(newValue);
                                      });
                                    },
                                    items: _currencies.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Họ và tên",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                            controller: fullNameController,
                            style: new TextStyle(
                                color: Colors.white, fontSize: 14),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.black),
                              contentPadding: const EdgeInsets.all(16.0),
                              hintText: "Nguyễn Văn A",
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
                          // Text(
                          //   "Ngày sinh",
                          //   style: TextStyle(color: Colors.white),
                          // ),
                          // SizedBox(
                          //   height: 5,
                          // ),
                          // GestureDetector(
                          //   onTap: () {
                          //     _selectDate(context);
                          //   },
                          //   child: Container(
                          //     width: deviceSize.width - 20,
                          //     height: 50,
                          //     decoration: BoxDecoration(
                          //       color: Colors.grey.withOpacity(0.5),
                          //       borderRadius: BorderRadius.circular(
                          //         10.0,
                          //       ),
                          //     ),
                          //     child: Center(
                          //       child: Text(
                          //         dateChosen,
                          //         style: TextStyle(
                          //             color: Colors.white,
                          //             fontWeight: FontWeight.bold),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 15,
                          // ),
                          // Text(
                          //   "Niên khóa",
                          //   style: TextStyle(color: Colors.white),
                          // ),
                          // SizedBox(
                          //   height: 5,
                          // ),
                          // TextField(
                          //   controller: schoolYearController,
                          //   style: new TextStyle(
                          //       color: Colors.white, fontSize: 14),
                          //   decoration: InputDecoration(
                          //     labelStyle: TextStyle(color: Colors.black),
                          //     contentPadding: const EdgeInsets.all(16.0),
                          //     hintText: "Niên khóa ...",
                          //     hintStyle: TextStyle(color: Colors.white38),
                          //     border: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(10.0),
                          //         borderSide: BorderSide.none),
                          //     filled: true,
                          //     fillColor: Colors.grey.withOpacity(0.5),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 15,
                          // ),
                          // Text(
                          //   "Khoa",
                          //   style: TextStyle(color: Colors.white),
                          // ),
                          // SizedBox(
                          //   height: 5,
                          // ),
                          // SearchableDropdown.single(
                          //   items: listFaculty.map((FacultyModel value) {
                          //     return DropdownMenuItem<FacultyModel>(
                          //       value: value,
                          //       child: Container(
                          //         width: deviceSize.width - 70,
                          //         child: Text(
                          //           value.name,
                          //           maxLines: 1,
                          //           overflow: TextOverflow.ellipsis,
                          //           style: TextStyle(
                          //               color: Colors.blue,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //     );
                          //   }).toList(),
                          //   searchFn: (String keyword, items) {
                          //     List<int> ret = List<int>();
                          //     if (keyword != null &&
                          //         items != null &&
                          //         keyword.isNotEmpty) {
                          //       int i = 0;
                          //       items.forEach((item) {
                          //         if (keyword.isNotEmpty &&
                          //             (item.value.name
                          //                 .toString()
                          //                 .toLowerCase()
                          //                 .contains(keyword.toLowerCase()))) {
                          //           ret.add(i);
                          //         }
                          //         i++;
                          //       });
                          //     }
                          //     if (keyword.isEmpty) {
                          //       ret = Iterable<int>.generate(items.length)
                          //           .toList();
                          //     }
                          //     return (ret);
                          //   },
                          //   value: facultyChosen,
                          //   searchHint: "Chọn khoa ...",
                          //   onChanged: (value) {
                          //     setState(() {
                          //       facultyChosen = value;
                          //     });
                          //   },
                          //   dialogBox: true,
                          //   isExpanded: true,
                          // ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Quốc gia",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SearchableDropdown.single(
                            items: listCountry.map((CountryInRegister value) {
                              return DropdownMenuItem<CountryInRegister>(
                                value: value,
                                child: Container(
                                  width: deviceSize.width - 70,
                                  child: Text(
                                    value.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              );
                            }).toList(),
                            searchFn: (String keyword, items) {
                              List<int> ret = List<int>();
                              if (keyword != null &&
                                  items != null &&
                                  keyword.isNotEmpty) {
                                int i = 0;
                                items.forEach((item) {
                                  if (keyword.isNotEmpty &&
                                      (item.value.name
                                          .toString()
                                          .toLowerCase()
                                          .contains(keyword.toLowerCase()))) {
                                    ret.add(i);
                                  }
                                  i++;
                                });
                              }
                              if (keyword.isEmpty) {
                                ret = Iterable<int>.generate(items.length)
                                    .toList();
                              }
                              return (ret);
                            },
                            // value: countryChosen,
                            searchHint: "Chọn quốc gia ...",
                            onChanged: (newValue) {
                              setState(() {
                                countryChosen = newValue;
                              });
                            },
                            dialogBox: true,
                            isExpanded: true,
                          ),
                          // SizedBox(
                          //   height: 15,
                          // ),
                          // Text(
                          //   "Công ty",
                          //   style: TextStyle(color: Colors.white),
                          // ),
                          // SizedBox(
                          //   height: 5,
                          // ),
                          // SearchableDropdown.single(
                          //   items: listCompany.map((CompanyInRegister value) {
                          //     return DropdownMenuItem<CompanyInRegister>(
                          //       value: value,
                          //       child: Container(
                          //         width: deviceSize.width - 70,
                          //         child: Text(
                          //           value.name,
                          //           maxLines: 1,
                          //           overflow: TextOverflow.ellipsis,
                          //           style: TextStyle(
                          //               color: Colors.blue,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //     );
                          //   }).toList(),
                          //   searchFn: (String keyword, items) {
                          //     List<int> ret = List<int>();
                          //     if (keyword != null &&
                          //         items != null &&
                          //         keyword.isNotEmpty) {
                          //       int i = 0;
                          //       items.forEach((item) {
                          //         if (keyword.isNotEmpty &&
                          //             (item.value.name
                          //                 .toString()
                          //                 .toLowerCase()
                          //                 .contains(keyword.toLowerCase()))) {
                          //           ret.add(i);
                          //         }
                          //         i++;
                          //       });
                          //     }
                          //     if (keyword.isEmpty) {
                          //       ret = Iterable<int>.generate(items.length)
                          //           .toList();
                          //     }
                          //     return (ret);
                          //   },
                          //   value: companyChosen,
                          //   searchHint: "Chọn công ty ...",
                          //   onChanged: (newValue) {
                          //     setState(() {
                          //       companyChosen = newValue;
                          //     });
                          //   },
                          //   dialogBox: true,
                          //   isExpanded: true,
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // GestureDetector(
                          //   onTap: () {
                          //     Navigator.pushNamed(
                          //             context, Routes.RegisterCompany)
                          //         .then((value) => getListCompany());
                          //   },
                          //   child: Container(
                          //     width: deviceSize.width,
                          //     height: 30,
                          //     child: Center(
                          //       child: Text(
                          //         "Không tim thấy doanh nghiệp của bạn? Đăng ký TẠI ĐÂY",
                          //         textAlign: TextAlign.center,
                          //         style: TextStyle(
                          //             color: Colors.white,
                          //             fontWeight: FontWeight.bold),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 15,
                          // ),
                          // Text(
                          //   "Chức vụ",
                          //   style: TextStyle(color: Colors.white),
                          // ),
                          // SizedBox(
                          //   height: 5,
                          // ),
                          // TextField(
                          //   controller: positionController,
                          //   style: new TextStyle(
                          //       color: Colors.white, fontSize: 14),
                          //   decoration: InputDecoration(
                          //     labelStyle: TextStyle(color: Colors.black),
                          //     contentPadding: const EdgeInsets.all(16.0),
                          //     hintText: "Chức vụ trong công ty",
                          //     hintStyle: TextStyle(color: Colors.white38),
                          //     border: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(10.0),
                          //         borderSide: BorderSide.none),
                          //     filled: true,
                          //     fillColor: Colors.grey.withOpacity(0.5),
                          //   ),
                          // ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Lĩnh vực",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                            controller: fieldController,
                            style: new TextStyle(
                                color: Colors.white, fontSize: 14),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.black),
                              contentPadding: const EdgeInsets.all(16.0),
                              hintText: "Lĩnh vực",
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
                            "Hình đại diện",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              _showPicker(context);
                            },
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.blue,
                              child: _image != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.file(
                                        _image,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      width: 120,
                                      height: 120,
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
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
}
