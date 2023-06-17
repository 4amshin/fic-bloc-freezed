import 'package:equatable/equatable.dart';
import 'package:fic_bloc_re_learn/data/data_sources/product_data_sources.dart';
import 'package:fic_bloc_re_learn/data/model/product/get_product/product_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_product_event.dart';
part 'get_product_state.dart';

class GetProductBloc extends Bloc<GetProductEvent, GetProductState> {
  final ProductDataSources dataSources;
  GetProductBloc(this.dataSources) : super(GetProductInitial()) {
    on<DoGetProductEvent>(_getAllProduct);
    on<AddSingleProductEvent>(_addSingleProduct);
  }

  Future<void> _getAllProduct(
    DoGetProductEvent event,
    Emitter<GetProductState> emit,
  ) async {
    emit(GetProductLoading());
    final result = await dataSources.getAllProduct();
    result.fold(
      (error) => emit(GetProductError(message: error)),
      (data) => emit(GetProductLoaded(dataList: data)),
    );
  }

  Future<void> _addSingleProduct(
    AddSingleProductEvent event,
    Emitter<GetProductState> emit,
  ) async {
    final currentState = state as GetProductLoaded;
    emit(GetProductLoaded(dataList: [
      ...currentState.dataList,
      event.model,
    ]));
  }
}
