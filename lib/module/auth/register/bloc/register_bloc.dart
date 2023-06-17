import 'package:equatable/equatable.dart';
import 'package:fic_bloc_re_learn/data/data_sources/auth_data_sources.dart';
import 'package:fic_bloc_re_learn/data/model/register/request/register_request_model.dart';
import 'package:fic_bloc_re_learn/data/model/register/response/register_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthDataSources dataSources;
  RegisterBloc(this.dataSources) : super(RegisterInitial()) {
    on<DoRegisterEvent>(_doRegister);
  }

  Future<void> _doRegister(
    DoRegisterEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    final result = await dataSources.register(event.model);
    result.fold(
      (error) => emit(RegisterError(message: error)),
      (data) => emit(RegisterLoaded(model: data)),
    );
  }
}
