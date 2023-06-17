// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_product_bloc.dart';

abstract class AddProductState extends Equatable {
  const AddProductState();

  @override
  List<Object> get props => [];
}

class AddProductInitial extends AddProductState {}

class AddProductLoading extends AddProductState {}

class AddProductLoaded extends AddProductState {
  final ProductResponseModel model;
  const AddProductLoaded({
    required this.model,
  });
}

class AddProductError extends AddProductState {
  final String message;
  const AddProductError({
    required this.message,
  });
}
