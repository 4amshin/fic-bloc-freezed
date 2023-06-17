import 'package:equatable/equatable.dart';
import 'package:fic_bloc_re_learn/data/data_sources/product_data_sources.dart';
import 'package:fic_bloc_re_learn/data/model/product/add_product/product_request_model.dart';
import 'package:fic_bloc_re_learn/data/model/product/get_product/product_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final ProductDataSources dataSources;
  AddProductBloc(this.dataSources) : super(AddProductInitial()) {
    on<DoAddProductEvent>(_addProduct);
  }

  Future<void> _addProduct(
    DoAddProductEvent event,
    Emitter<AddProductState> emit,
  ) async {
    emit(AddProductLoading());
    final result = await dataSources.addProduct(event.model);
    result.fold(
      (error) => emit(AddProductError(message: error)),
      (data) => emit(AddProductLoaded(model: data)),
    );
  }
}
