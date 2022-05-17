import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:worldsoft_maintain/Common/Config.dart';
import 'package:worldsoft_maintain/Model/ApiResult/ContentOnCalendarModel.dart';
part 'CalendarClient.g.dart';

@RestApi(baseUrl: BaseURL)
abstract class CalendarClient {
  factory CalendarClient(Dio dio, {String baseUrl}) = _CalendarClient;

  @POST("/sys_event_program.ctr/getListEventProgram")
  Future<List<ContentOnCalendarModel>> getListProgram();
}
