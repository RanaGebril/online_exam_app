import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models.dart';

part 'auth_api_client.g.dart';

@RestApi(baseUrl: 'https://exam.elevateegy.com/api/v1')
abstract class AuthApiClient {
  factory AuthApiClient(Dio dio, {String baseUrl}) = _AuthApiClient;

  @POST('/auth/signin')
  Future<UserModel> login(@Body() Map<String, dynamic> body);

  @POST('/auth/signup')
  Future<UserModel> signup(@Body() Map<String, dynamic> body);
  
  @POST("/auth/forgotPassword")
  Future<void> forgetpassword(@Body() Map<String, dynamic> body);

  @POST("/auth/verifyResetCode")
  Future<void> verifyResetCode(@Body() Map<String, dynamic> body);
  
  @POST("/auth/resetPassword")
  Future<void> resetPassword(@Body() Map<String, dynamic> body);

  @POST("/auth/profileData")
  Future<void> profileData(@Body() Map<String, dynamic> body);

  @POST("/auth/editProfile")
  Future<void> editProfile(
      @Body() Map<String, dynamic> body,
      @Header("Authorization") String token,
      );


}
