import 'package:equatable/equatable.dart';
import 'package:fic_bloc_re_learn/data/data_sources/auth_data_sources.dart';
import 'package:fic_bloc_re_learn/data/model/login/request/login_request_model.dart';
import 'package:fic_bloc_re_learn/data/model/login/response/login_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthDataSources dataSources;
  LoginBloc(this.dataSources) : super(LoginInitial()) {
    on<DoLoginEvent>(_doLogin);
  }

  Future<void> _doLogin(
    DoLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    final result = await dataSources.login(event.model);
    result.fold(
      (error) => emit(LoginError(message: error)),
      (data) => emit(LoginLoaded(model: data)),
    );
  }
}
