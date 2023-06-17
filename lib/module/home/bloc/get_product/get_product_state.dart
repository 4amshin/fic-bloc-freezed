// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_product_bloc.dart';

abstract class GetProductState extends Equatable {
  const GetProductState();

  @override
  List<Object> get props => [];
}

class GetProductInitial extends GetProductState {}

class GetProductLoading extends GetProductState {}

class GetProductLoaded extends GetProductState {
  final List<ProductResponseModel> dataList;
  const GetProductLoaded({
    required this.dataList,
  });
}

class GetProductError extends GetProductState {
  final String message;
  const GetProductError({
    required this.message,
  });
}
