// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_product_bloc.dart';

abstract class GetProductEvent extends Equatable {
  const GetProductEvent();

  @override
  List<Object> get props => [];
}

class DoGetProductEvent extends GetProductEvent {}

class AddSingleProductEvent extends GetProductEvent {
  final ProductResponseModel model;
  const AddSingleProductEvent({
    required this.model,
  });
}
