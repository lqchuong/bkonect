// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HomeClient.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _HomeClient implements HomeClient {
  _HomeClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://connect.worldsoft.com.vn';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<userdbModel> getUserInfo() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/sys_home.ctr/getUserInfo',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = userdbModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<NotifyNumberModel> getListNotifyEvent() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/sys_event.ctr/count_notification_event',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = NotifyNumberModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<CountNotificationModel> countNotification() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/sys_home.ctr/count_notification',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CountNotificationModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<NotificationModel> getnotification(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'id': id};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        '/sys_home.ctr/getdetailnotification',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = NotificationModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<NotificationModel> registertokennoti(token) async {
    ArgumentError.checkNotNull(token, 'token');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'token': token};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        '/sys_home.ctr/registertokennoti',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = NotificationModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<RegisterPostApiModel> getUserInformation() async {
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
  Future<List<ContentResultModel>> updateStatusEvent(event_id, status) async {
    ArgumentError.checkNotNull(event_id, 'event_id');
    ArgumentError.checkNotNull(status, 'status');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'event_id': event_id, 'status': status};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<List<dynamic>>(
        '/sys_event.ctr/update_status_event',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) =>
            ContentResultModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<EventResultModel>> getListEvent(check_in_status) async {
    ArgumentError.checkNotNull(check_in_status, 'check_in_status');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'check_in_status': check_in_status};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<List<dynamic>>(
        '/sys_event.ctr/getEventParticipate',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map(
            (dynamic i) => EventResultModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }
}
