import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseModelApi.dart';
import 'package:worldsoft_maintain/Common/BaseClass/BaseWidgetAuthentication.dart';
import 'package:worldsoft_maintain/Common/BaseClass/DioClientInit.dart';
import 'package:worldsoft_maintain/Common/Config.dart';
import 'package:worldsoft_maintain/Common/HandleWebApi/ServerError.dart';
import 'package:worldsoft_maintain/Common/tiengviet.dart';

import 'package:dio/dio.dart';
import 'package:worldsoft_maintain/Model/ApiResult/CompanyInRegister.dart';
import 'package:worldsoft_maintain/Model/ApiResult/FacultyModel.dart';
import 'package:worldsoft_maintain/Model/ApiResult/RegisterPostApiModel.dart';
import 'package:worldsoft_maintain/Model/Error/ErrorModel.dart';
import 'package:worldsoft_maintain/Views/Setting/Api/SettingClient.dart';

import '../../routes.dart';

class EditUserInfo extends BaseWidgetAuthentication {
  @override
  State<StatefulWidget> createState() => new _EditUserInfoState();
}

class _EditUserInfoState extends BaseWidgetAuthenticationState<EditUserInfo> {
  Size deviceSize;
  File _image; // avatar
  bool checkValidSdt = false;
  RegisterPostApiModel registerPostApiModel;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final fieldController = TextEditingController();
  final schoolYearController = TextEditingController();
  final positionController = TextEditingController();

  bool isEnable = true;
  List<ErrorModel> listError = [];
  bool isInfoExisted = false;

  List<CompanyInRegister> listCompany = [];
  CompanyInRegister companyChosen;
  CompanyInRegister initialCompany;

  List<FacultyModel> listFaculty = [];
  FacultyModel facultyChosen;
  FacultyModel initialFalcuty;

  Dio dio;
  ProgressDialog pr;
  SettingClient apiClient;
  bool loading = false;
  _EditUserInfoState() {
    dio = createDioClientAuthentication(storage);
    dio.options.headers["Content-Type"] = "application/json";
    apiClient = new SettingClient(dio);
  }

  DateTime selectedDate = DateTime.now();
  final formatDate = new DateFormat(formatDateString);
  String dateChosen = "";

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateChosen = formatDate.format(selectedDate);
      });
  }

  @override
  functionfirstLoad() async {
    await super.functionfirstLoad();
  }

  @override
  initState() {
    super.initState();
    loading = true;
    setState(() {});
    phoneController.addListener(() {
      checkValidPhone();
    });
    getUserInfo();
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
                registerPostApiModel.db.avatar_link = response.data["path"],
                updateUserInfo(registerPostApiModel)
              })
          .catchError((error) => print(error));
    } catch (e) {
      print(e.toString());
      isEnable = true;
      setState(() {});
    }
  }

  Future<BaseModel<RegisterPostApiModel>> getUserInfo() async {
    RegisterPostApiModel response;

    try {
      response = await apiClient.getUserInfo();
      registerPostApiModel = response;
      firstNameController.text = registerPostApiModel.db.FirstName;
      lastNameController.text = registerPostApiModel.db.LastName;
      emailController.text = registerPostApiModel.db.email;
      phoneController.text = registerPostApiModel.db.dienthoai;
      fieldController.text = registerPostApiModel.db.field;
      selectedDate = registerPostApiModel.db.day_of_birth;
      dateChosen = formatDate.format(selectedDate);
      schoolYearController.text = registerPostApiModel.db.school_year;
      positionController.text = registerPostApiModel.db.position;

      if (registerPostApiModel.db.id_faculty != null) {
        initialFalcuty = new FacultyModel();
        initialFalcuty.id = registerPostApiModel.db.id_faculty;
        initialFalcuty.name = registerPostApiModel.ten_khoa;
      }
      if (registerPostApiModel.db.id_company != null) {
        initialCompany = new CompanyInRegister();
        initialCompany.id = registerPostApiModel.db.id_company;
        initialCompany.name = registerPostApiModel.ten_cong_ty;
      }

      setState(() {});
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()
        ..setException(ServerError.withError(error, context, pr));
    }
    getListCompany();
    return BaseModel()..data = response;
  }

  Future<BaseModel<RegisterPostApiModel>> updateUserInfo(
      RegisterPostApiModel model) async {
    dio.options.headers["Content-Type"] = "application/json";

    loading = true;
    setState(() {});
    RegisterPostApiModel response;
    model.db.FirstName = firstNameController.text;
    model.db.LastName = lastNameController.text;
    model.db.email = emailController.text;
    model.db.dienthoai = phoneController.text;
    model.db.field = fieldController.text;
    model.db.day_of_birth = selectedDate;
    if (positionController.text != null)
      model.db.position = positionController.text;
    if (schoolYearController.text != null)
      model.db.school_year = schoolYearController.text;
    if (facultyChosen != null) model.db.id_faculty = facultyChosen.id;
    if (companyChosen != null) model.db.id_company = companyChosen.id;
    try {
      response = await apiClient.updateInfo(model);
      showSuccess("THÔNG TIN CÁ NHÂN", "Cập nhật thành công!");
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      isEnable = true;
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

      return BaseModel()
        ..setException(ServerError.withError(error, context, pr));
    }
    loading = false;
    isEnable = true;
    setState(() {});
    return BaseModel()..data = response;
  }

  Future<BaseModel<List<CompanyInRegister>>> getListCompany() async {
    List<CompanyInRegister> response;
    try {
      response = await apiClient.getListCompany();
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()
        ..setException(ServerError.withError(error, context, pr));
    }
    listCompany = response;
    // companyChosen = listCompany[0];
    // registerModel.id_company = "0";
    // listProgram = listContentApiResult.map((e) => e.db).toList();
    getListCFaculty();
    return BaseModel()..data = response;
  }

  Future<BaseModel<List<FacultyModel>>> getListCFaculty() async {
    List<FacultyModel> response;
    try {
      response = await apiClient.getListFaculty();
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()
        ..setException(ServerError.withError(error, context, pr));
    }
    listFaculty = response;
    // facultyChosen = listFaculty[0];
    // registerModel.id_faculty = "0";
    // listProgram = listContentApiResult.map((e) => e.db).toList();
    loading = false;
    setState(() {});
    return BaseModel()..data = response;
  }

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

  Future<File> compressFile(File file) async {
    var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, file.absolute.path + "123" + "." + ".png",
        quality: 88, format: CompressFormat.png);
    return result;
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
                      title: new Text('Thư viện'),
                      onTap: () {
                        getImage('galery');
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Chụp hình'),
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

  void checkValidPhone() {
    checkValidSdt =
        RegExp(r"^(?:[+0]9)?[0-9]{10}$").hasMatch(phoneController.text.trim());
    setState(() {});
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    fieldController.dispose();
    schoolYearController.dispose();
    positionController.dispose();
    super.dispose();
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
            "CHỈNH SỬA THÔNG TIN",
            style: TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: FloatingActionButton.extended(
              backgroundColor: Colors.red,
              onPressed: () {
                if (isEnable == true) {
                  isEnable = false;
                  setState(() {});
                  if (_image != null) {
                    getMultiPartFile(_image);
                  } else {
                    updateUserInfo(registerPostApiModel);
                  }
                }
              },
              label: Text("LƯU LẠI"),
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
            color: Colors.transparent,
            width: deviceSize.width,
            height: deviceSize.height - 220,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Ảnh đại diện",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        (_image != null)
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    deviceSize.width * 0.25),
                                child: Image.file(
                                  _image,
                                  width: deviceSize.width * 0.25,
                                  height: deviceSize.width * 0.25,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: Container(
                                  height: deviceSize.width * 0.25,
                                  width: deviceSize.width * 0.25,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          deviceSize.width * 0.25),
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              generateUrl(registerPostApiModel
                                                      .db.avatar_link) ??
                                                  noImgUrl),
                                          fit: BoxFit.cover)),
                                  //margin: EdgeInsets.only(left: 16.0),
                                )),
                        SizedBox(
                          width: 10,
                        ),
                        FlatButton.icon(
                            onPressed: () {
                              _showPicker(context);
                            },
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                            color: Colors.red,
                            label: Text(
                              "THAY ĐỔI",
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          width: deviceSize.width * 0.3 - 12.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Họ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextField(
                                controller: firstNameController,
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 14),
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.black),
                                  contentPadding: const EdgeInsets.all(16.0),
                                  hintStyle: TextStyle(color: Colors.white38),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide.none),
                                  filled: true,
                                  fillColor: Colors.blue.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: deviceSize.width * 0.7 - 12.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tên đệm và tên",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextField(
                                controller: lastNameController,
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 14),
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.black),
                                  contentPadding: const EdgeInsets.all(16.0),
                                  hintStyle: TextStyle(color: Colors.white38),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide.none),
                                  filled: true,
                                  fillColor: Colors.blue.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Email",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: emailController,
                      style: new TextStyle(color: Colors.black, fontSize: 14),
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.black),
                        contentPadding: const EdgeInsets.all(16.0),
                        hintStyle: TextStyle(color: Colors.white38),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Colors.blue.withOpacity(0.5),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Số điện thoại",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: phoneController,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
                            color:
                                checkValidSdt ? Colors.green : Colors.black26,
                          ),
                          suffixIcon: Icon(
                            Icons.check_circle,
                            color:
                                checkValidSdt ? Colors.green : Colors.black26,
                          ),
                          hintText: "Nhập số",
                          filled: true,
                          fillColor: Colors.blue.withOpacity(0.5),
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
                    Text("Lĩnh vực",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: fieldController,
                      style: new TextStyle(color: Colors.black, fontSize: 14),
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.black),
                        contentPadding: const EdgeInsets.all(16.0),
                        hintStyle: TextStyle(color: Colors.white38),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Colors.blue.withOpacity(0.5),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Ngày sinh",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Container(
                        width: deviceSize.width - 20,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            dateChosen,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Niên khóa",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: schoolYearController,
                      style: new TextStyle(color: Colors.black, fontSize: 14),
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.black),
                        contentPadding: const EdgeInsets.all(16.0),
                        hintStyle: TextStyle(color: Colors.white38),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Colors.blue.withOpacity(0.5),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Khoa",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SearchableDropdown.single(
                      items: listFaculty.map((FacultyModel value) {
                        return DropdownMenuItem<FacultyModel>(
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
                          ret = Iterable<int>.generate(items.length).toList();
                        }
                        return (ret);
                      },
                      hint: Text(
                        (initialFalcuty != null)
                            ? initialFalcuty.name
                            : "Chưa chọn",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      value: facultyChosen,
                      searchHint: "Chọn khoa ...",
                      onChanged: (value) {
                        setState(() {
                          facultyChosen = value;
                        });
                      },
                      dialogBox: true,
                      isExpanded: true,
                      menuBackgroundColor: Colors.blue[50],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Công ty",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SearchableDropdown.single(
                      items: listCompany.map((CompanyInRegister value) {
                        return DropdownMenuItem<CompanyInRegister>(
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
                          ret = Iterable<int>.generate(items.length).toList();
                        }
                        return (ret);
                      },
                      value: companyChosen,
                      searchHint: "Chọn công ty ...",
                      hint: Text(
                        (initialCompany != null)
                            ? initialCompany.name
                            : "Chưa chọn",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          companyChosen = newValue;
                        });
                      },
                      dialogBox: true,
                      isExpanded: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.RegisterCompany)
                            .then((value) => getListCompany());
                      },
                      child: Container(
                        width: deviceSize.width,
                        height: 30,
                        child: Center(
                          child: Text(
                            "Không tim thấy doanh nghiệp của bạn? Đăng ký TẠI ĐÂY",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Chức vụ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: positionController,
                      style: new TextStyle(color: Colors.black, fontSize: 14),
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.black),
                        contentPadding: const EdgeInsets.all(16.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Colors.blue.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
