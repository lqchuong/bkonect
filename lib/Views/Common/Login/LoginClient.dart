//Dynamic headers

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:worldsoft_maintain/Common/Config.dart';
import 'package:worldsoft_maintain/Model/LoginAccessToken.dart';
part 'LoginClient.g.dart';

@RestApi(baseUrl: BaseURL)
abstract class LoginClient {
  factory LoginClient(Dio dio, {String baseUrl}) = _LoginClient;
  @POST("/users/authenticate")
  Future<LoginAccessToken> authenticate(
    @Field() String username,
    @Field() String password,
  );

  @POST("/sys_user.ctr/forgot_pass")
  Future<dynamic> forgetPassword(
    @Field() String email,
  );
}
