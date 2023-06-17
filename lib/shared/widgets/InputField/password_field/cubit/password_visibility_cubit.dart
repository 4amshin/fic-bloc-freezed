import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'password_visibility_state.dart';

class PasswordVisibilityCubit extends Cubit<bool> {
  PasswordVisibilityCubit() : super(true);

  void togglePasswordVisibility() {
    //when tap change state to the opposite of current state
    //its like setState(state = !state)
    emit(!state);
  }
}
