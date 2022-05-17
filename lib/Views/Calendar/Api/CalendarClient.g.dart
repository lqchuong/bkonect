// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CalendarClient.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CalendarClient implements CalendarClient {
  _CalendarClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://connect.worldsoft.com.vn';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<ContentOnCalendarModel>> getListProgram() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>(
        '/sys_event_program.ctr/getListEventProgram',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) =>
            ContentOnCalendarModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }
}
