// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_product_bloc.dart';

abstract class AddProductEvent extends Equatable {
  const AddProductEvent();

  @override
  List<Object> get props => [];
}

class DoAddProductEvent extends AddProductEvent {
  final ProductRequestModel model;
  const DoAddProductEvent({
    required this.model,
  });
}
