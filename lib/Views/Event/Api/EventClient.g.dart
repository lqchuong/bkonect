// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EventClient.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _EventClient implements EventClient {
  _EventClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://connect.worldsoft.com.vn';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<EventParticipateResultModel>> getListCompany(
      event_id, role) async {
    ArgumentError.checkNotNull(event_id, 'event_id');
    ArgumentError.checkNotNull(role, 'role');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'event_id': event_id, 'role': role};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<List<dynamic>>(
        '/sys_event.ctr/get_list_tham_du',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) =>
            EventParticipateResultModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<ContentResultModel>> getListProgram(event_id) async {
    ArgumentError.checkNotNull(event_id, 'event_id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'event_id': event_id};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<List<dynamic>>(
        '/sys_event.ctr/get_list_event_program',
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
  Future<List<FileResultModel>> getListFile(event_id) async {
    ArgumentError.checkNotNull(event_id, 'event_id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'event_id': event_id};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<List<dynamic>>(
        '/sys_event.ctr/get_list_file',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => FileResultModel.fromJson(i as Map<String, dynamic>))
        .toList();
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
  Future<List<EventQaResulModel>> getListQandA(event_id) async {
    ArgumentError.checkNotNull(event_id, 'event_id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'event_id': event_id};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<List<dynamic>>(
        '/sys_event.ctr/getQAEvent',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) =>
            EventQaResulModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<ReviewResultModel>> getListReview(event_id) async {
    ArgumentError.checkNotNull(event_id, 'event_id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'event_id': event_id};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<List<dynamic>>(
        '/sys_event_participate.ctr/get_list_danh_gia',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) =>
            ReviewResultModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<ImageIntroResultModel>> getImagesIntro(event_id) async {
    ArgumentError.checkNotNull(event_id, 'event_id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'event_id': event_id};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<List<dynamic>>(
        '/sys_event.ctr/get_list_image',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) =>
            ImageIntroResultModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<EventResultModel> getDetailEvent(event_id) async {
    ArgumentError.checkNotNull(event_id, 'event_id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'event_id': event_id};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        '/sys_event.ctr/getDetailEvent',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = EventResultModel.fromJson(_result.data);
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

  @override
  Future<dynamic> postReview(event_id, review_rate, review_note) async {
    ArgumentError.checkNotNull(event_id, 'event_id');
    ArgumentError.checkNotNull(review_rate, 'review_rate');
    ArgumentError.checkNotNull(review_note, 'review_note');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'event_id': event_id,
      'review_rate': review_rate,
      'review_note': review_note
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request('/sys_event_participate.ctr/danh_gia',
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
