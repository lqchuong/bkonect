// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NotificationClient.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _NotificationClient implements NotificationClient {
  _NotificationClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://connect.worldsoft.com.vn';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<NotificationResultModel>> getListNotification() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>(
        '/sys_home.ctr/getNotification',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) =>
            NotificationResultModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<dynamic> updateStatusRead(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'id': id};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request(
        '/sys_home.ctr/update_status_notification',
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
}
