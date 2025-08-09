import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../../../core/utils/constants/api_endpoint.dart';
import '../models.dart';

part 'auth_api_client.g.dart';

@RestApi(baseUrl: ApiEndPionts.baseUrl)
abstract class AuthApiClient {
  factory AuthApiClient(Dio dio, {String baseUrl}) = _AuthApiClient;

  @POST(ApiEndPionts.signinEndPoint)
  Future<UserModel> login(@Body() Map<String, dynamic> body);

  @POST(ApiEndPionts.signupEndPoint)
  Future<UserModel> signup(@Body() Map<String, dynamic> body);

  @POST(ApiEndPionts.forgetpasswordEndPoint)
  Future<void> forgetpassword(@Body() Map<String, dynamic> body);

  @POST(ApiEndPionts.verifyresetcodeEndPoint)
  Future<void> verifyResetCode(@Body() Map<String, dynamic> body);
  
  @POST( ApiEndPionts.resetpasswordEndPoint)
  Future<void> resetPassword(@Body() Map<String, dynamic> body);

  @POST(ApiEndPionts.profiledataEndPoint)
  Future<void> profileData(@Body() Map<String, dynamic> body);

  @POST(ApiEndPionts.editprofileEndPoint)
  Future<void> editProfile(
      @Body() Map<String, dynamic> body,
      @Header("Authorization") String token,
      );


}
