import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fic_bloc_re_learn/data/data_sources/product_data_sources.dart';
import 'package:fic_bloc_re_learn/data/model/product/add_product/product_request_model.dart';
import 'package:fic_bloc_re_learn/data/model/product/get_product/product_response_model.dart';

part 'update_product_event.dart';
part 'update_product_state.dart';

class UpdateProductBloc extends Bloc<UpdateProductEvent, UpdateProductState> {
  final ProductDataSources dataSources;
  UpdateProductBloc(this.dataSources) : super(UpdateProductInitial()) {
    on<DoUpdateProductEvent>(_updateProduct);
  }

  Future<void> _updateProduct(
    DoUpdateProductEvent event,
    Emitter<UpdateProductState> emit,
  ) async {
    emit(UpdateProductLoading());
    final result =
        await dataSources.updateProduct(event.productId, event.model);
    result.fold(
      (error) => emit(UpdateProductError(message: error)),
      (data) => emit(UpdateProductLoaded(model: data)),
    );
  }
}
