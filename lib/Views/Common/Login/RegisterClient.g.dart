// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RegisterClient.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RegisterClient implements RegisterClient {
  _RegisterClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://connect.worldsoft.com.vn';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<CompanyInRegister>> getListCompany() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>(
        '/sys_danhmuc_congty.ctr/getListUse',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) =>
            CompanyInRegister.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<RegisterResultModel> registerAccount(registerPostApiModel) async {
    ArgumentError.checkNotNull(registerPostApiModel, 'registerPostApiModel');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(registerPostApiModel?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        '/sys_user.ctr/registerInApp',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = RegisterResultModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<List<CountryInRegister>> getListCountry() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>(
        '/sys_user.ctr/getListCountry',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) =>
            CountryInRegister.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<FacultyModel>> getListFaculty() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>(
        '/sys_faculty.ctr/getListUse',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => FacultyModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<CompanyResultModel> registerCompany(companyResultModel) async {
    ArgumentError.checkNotNull(companyResultModel, 'companyResultModel');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(companyResultModel?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        '/sys_danhmuc_congty.ctr/registerInApp',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CompanyResultModel.fromJson(_result.data);
    return value;
  }
}
