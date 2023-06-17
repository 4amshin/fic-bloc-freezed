// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'update_product_bloc.dart';

abstract class UpdateProductEvent extends Equatable {
  const UpdateProductEvent();

  @override
  List<Object> get props => [];
}

class DoUpdateProductEvent extends UpdateProductEvent {
  final int productId;
  final ProductRequestModel model;
  const DoUpdateProductEvent({
    required this.productId,
    required this.model,
  });
}
