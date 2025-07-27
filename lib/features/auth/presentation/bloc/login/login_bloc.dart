import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../profile/data/datasources/user_local_storage.dart';
import '../../../../profile/data/models/user_profile_model.dart';
import '../../../data/models.dart';
import '../../../domain/usecases.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LogicUserCase loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final user = await loginUseCase(event.email, event.password);
        final profile = UserProfileModel.fromUserModel(user as UserModel);

        print("👌👌👌👌👌👌👌👌👌👌👌👌👌");
        print(profile.token);
        await UserLocalStorage.saveUser(profile);
        emit(LoginSuccess());
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
  }
}
