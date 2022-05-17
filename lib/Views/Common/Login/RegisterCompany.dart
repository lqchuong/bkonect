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
import 'package:worldsoft_maintain/Model/ApiResult/CompanyResultModel.dart';
import 'package:worldsoft_maintain/Model/ApiResult/CountryInRegister.dart';
import 'package:worldsoft_maintain/Model/CompanyModel.dart';
import 'package:worldsoft_maintain/Model/Error/ErrorModel.dart';
import '../../../LocalStoreKey.dart';
import '../LoadingPage.dart';
import 'RegisterClient.dart';

class RegisterCompany extends StatefulWidget {
  @override
  _RegisterCompanyState createState() => _RegisterCompanyState();
}

class _RegisterCompanyState extends State<RegisterCompany> {
  final LocalStorage storage = new LocalStorage(LocalStoreKey.keyStore);
  Dio dio;
  ProgressDialog pr;
  RegisterClient apiClient;
  bool loading = false;
  _RegisterCompanyState() {
    dio = createDioClientNoAuthentication(storage);
    dio.options.headers["Content-Type"] = "application/json";
    apiClient = new RegisterClient(dio);
  }

  List<CountryInRegister> listCountry = [];
  CountryInRegister countryChosen;

  CompanyResultModel companyResultModel = new CompanyResultModel();
  CompanyModel companyModel = new CompanyModel();

  List<ErrorModel> listError = [];

  final nameController = TextEditingController();
  final shortNameController = TextEditingController();
  final noteYearController = TextEditingController();
  final locationController = TextEditingController();
  final fieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loading = true;
    setState(() {});
    getListCountry();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    shortNameController.dispose();
    noteYearController.dispose();
    locationController.dispose();
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
      loading = false;
      setState(() {});
      showWarning("Chưa có logo công ty", "");
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
                companyModel.logo_link = response.data["path"],
                companyModel.name = nameController.text,
                companyModel.short_name = shortNameController.text,
                companyModel.id_country = countryChosen.id,
                companyModel.country_name = countryChosen.name,
                companyModel.field = fieldController.text,
                companyModel.location = locationController.text,
                companyResultModel.db = companyModel,

                registerCompany(companyResultModel)
                // registerAccount(registerPostApiModel)
              })
          .catchError((error) => print(error));
    } catch (e) {
      print(e.toString());
      loading = false;
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

  Future<BaseModel<CompanyResultModel>> registerCompany(
      CompanyResultModel checkModel) async {
    dio.options.headers["Content-Type"] = "application/json";

    CompanyResultModel response;
    try {
      response = await apiClient.registerCompany(checkModel);
      // companyResultModel = response;
    } catch (error, stacktrace) {
      List<dynamic> myListError = error.response.data;
      listError = myListError.map((e) => ErrorModel.fromJson(e)).toList();

      var isInfoExisted = false;
      if (listError.where((e) => e.Key == "db.name").length > 0) {
        isInfoExisted = true;
        showWarning("Không hợp lệ", "Đã tồn tại hoặc để trống");
      }

      if (listError.where((e) => e.Key == "db.short_name").length > 0 &&
          isInfoExisted == false) {
        isInfoExisted = true;
        showWarning("Không hợp lệ", "Đã tồn tại hoặc để trống");
      }

      if (listError.where((e) => e.Key == "db.logo_link").length > 0 &&
          isInfoExisted == false) {
        isInfoExisted = true;
        showWarning("Không hợp lệ", "Chưa có logo");
      }
      if (listError.where((e) => e.Key == "db.id_country").length > 0 &&
          isInfoExisted == false) {
        isInfoExisted = true;
        showWarning("Không hợp lệ", "Chưa chọn quốc gia");
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
    loading = false;
    setState(() {});
    if (listError.length == 0) {
      // showSuccess();
      Navigator.pop(context);
    }

    return BaseModel()..data = response;
  }

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
                onPressed: () => Navigator.pop(context),
                width: 120,
              )
            ],
            title: "ĐĂNG KÝ CÔNG TY",
            desc: "Thành công!!")
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
                    loading = true;
                    setState(() {});

                    getMultiPartFile(_image);
                  },
                  label: Text("ĐĂNG KÝ"),
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
                              "ĐĂNG KÝ THÔNG TIN CÔNG TY",
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
                            "Tên công ty",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                            controller: nameController,
                            style: new TextStyle(
                                color: Colors.white, fontSize: 14),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.black),
                              contentPadding: const EdgeInsets.all(16.0),
                              hintText: "Nhập tên",
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
                            "Tên viết tắt",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                            controller: shortNameController,
                            style: new TextStyle(
                                color: Colors.white, fontSize: 14),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.black),
                              contentPadding: const EdgeInsets.all(16.0),
                              hintText: "Nhập tên",
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
                            "Quốc gia",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
                            value: countryChosen,
                            searchHint: "Chọn quốc gia ...",
                            onChanged: (value) {
                              countryChosen = value;
                            },
                            dialogBox: true,
                            isExpanded: true,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Lĩnh vực",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
                            "Địa điểm",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                            controller: locationController,
                            style: new TextStyle(
                                color: Colors.white, fontSize: 14),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.black),
                              contentPadding: const EdgeInsets.all(16.0),
                              hintText: "Điền địa chỉ",
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
                            "Logo",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
