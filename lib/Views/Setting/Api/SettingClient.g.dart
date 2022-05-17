// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SettingClient.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _SettingClient implements SettingClient {
  _SettingClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://connect.worldsoft.com.vn';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<RegisterPostApiModel> getUserInfo() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/sys_user.ctr/getUserInfo',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = RegisterPostApiModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<RegisterPostApiModel> updateInfo(model) async {
    ArgumentError.checkNotNull(model, 'model');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(model?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        '/sys_user.ctr/updateUserInApp',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = RegisterPostApiModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<dynamic> changePassword(old_password, new_password) async {
    ArgumentError.checkNotNull(old_password, 'old_password');
    ArgumentError.checkNotNull(new_password, 'new_password');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'old_password': old_password, 'new_password': new_password};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request('/sys_user.ctr/changePassword',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
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
}
