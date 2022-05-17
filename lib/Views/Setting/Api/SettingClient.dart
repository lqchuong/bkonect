import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:worldsoft_maintain/Common/Config.dart';
import 'package:worldsoft_maintain/Model/ApiResult/CompanyInRegister.dart';
import 'package:worldsoft_maintain/Model/ApiResult/FacultyModel.dart';
import 'package:worldsoft_maintain/Model/ApiResult/RegisterPostApiModel.dart';
part 'SettingClient.g.dart';

@RestApi(baseUrl: BaseURL)
abstract class SettingClient {
  factory SettingClient(Dio dio, {String baseUrl}) = _SettingClient;

  @POST("/sys_user.ctr/getUserInfo")
  Future<RegisterPostApiModel> getUserInfo();

  @POST("/sys_user.ctr/updateUserInApp")
  Future<RegisterPostApiModel> updateInfo(@Body() RegisterPostApiModel model);

  @POST("/sys_user.ctr/changePassword")
  Future<dynamic> changePassword(
    @Field() String old_password,
    @Field() String new_password,
  );

  @POST("/sys_faculty.ctr/getListUse")
  Future<List<FacultyModel>> getListFaculty();

  @POST("/sys_danhmuc_congty.ctr/getListUse")
  Future<List<CompanyInRegister>> getListCompany();
}
