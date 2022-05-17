//Dynamic headers

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:worldsoft_maintain/Common/Config.dart';
import 'package:worldsoft_maintain/Model/ApiResult/CompanyInRegister.dart';
import 'package:worldsoft_maintain/Model/ApiResult/CompanyResultModel.dart';
import 'package:worldsoft_maintain/Model/ApiResult/CountryInRegister.dart';
import 'package:worldsoft_maintain/Model/ApiResult/FacultyModel.dart';
import 'package:worldsoft_maintain/Model/ApiResult/RegisterPostApiModel.dart';
import 'package:worldsoft_maintain/Model/ApiResult/RegisterResultModel.dart';
part 'RegisterClient.g.dart';

@RestApi(baseUrl: BaseURL)
abstract class RegisterClient {
  factory RegisterClient(Dio dio, {String baseUrl}) = _RegisterClient;

  @POST("/sys_danhmuc_congty.ctr/getListUse")
  Future<List<CompanyInRegister>> getListCompany();

  @POST("/sys_user.ctr/registerInApp")
  Future<RegisterResultModel> registerAccount(
      @Body() RegisterPostApiModel registerPostApiModel);

  @POST("/sys_user.ctr/getListCountry")
  Future<List<CountryInRegister>> getListCountry();

  @POST("/sys_faculty.ctr/getListUse")
  Future<List<FacultyModel>> getListFaculty();

  @POST("/sys_danhmuc_congty.ctr/registerInApp")
  Future<CompanyResultModel> registerCompany(
      @Body() CompanyResultModel companyResultModel);
}
