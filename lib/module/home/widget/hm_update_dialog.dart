// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fic_bloc_re_learn/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HmUpdateDialog extends StatefulWidget {
  final Widget child;
  final ProductResponseModel product;
  final TextEditingController? titleController;
  final TextEditingController? priceController;
  final TextEditingController? descriptionController;
  const HmUpdateDialog({
    Key? key,
    required this.child,
    required this.product,
    this.titleController,
    this.priceController,
    this.descriptionController,
  }) : super(key: key);

  @override
  State<HmUpdateDialog> createState() => _HmUpdateDialogState();
}

class _HmUpdateDialogState extends State<HmUpdateDialog> {
  late TextEditingController _titleController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = widget.titleController ?? TextEditingController();
    _priceController = widget.priceController ?? TextEditingController();
    _descriptionController =
        widget.descriptionController ?? TextEditingController();

    //set initial text
    _titleController.text = widget.product.title ?? 'title';
    _priceController.text = widget.product.price.toString();
    _descriptionController.text = widget.product.description ?? 'description';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UpdateProductBloc>();
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return BlocConsumer<UpdateProductBloc, UpdateProductState>(
              builder: (context, state) {
                if (state is UpdateProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return AlertDialog(
                  title: const Text(
                    'Update Product',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextInput(
                        label: 'Title',
                        controller: _titleController,
                      ),
                      TextInput(
                        label: 'Price',
                        controller: _priceController,
                      ),
                      TextInput(
                        label: 'Description',
                        controller: _descriptionController,
                        maxLines: 3,
                      ),
                    ],
                  ),
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  actions: [
                    DialogButton(
                      label: 'Cancel',
                      onTap: () => Get.back(),
                    ),
                    DialogButton(
                      label: 'Update',
                      onTap: () {
                        final updateModel = ProductRequestModel(
                          title: _titleController.text,
                          price: int.parse(_priceController.text),
                          description: _descriptionController.text,
                        );

                        bloc.add(DoUpdateProductEvent(
                            productId: widget.product.id!, model: updateModel));
                      },
                    ),
                  ],
                );
              },
              listener: (context, state) {
                if (state is UpdateProductLoaded) {
                  //display success dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Update Product Success'),
                      backgroundColor: Colors.indigoAccent,
                    ),
                  );
                  context.read<GetProductBloc>().add(DoGetProductEvent());
                  Get.back();
                }

                if (state is UpdateProductError) {
                  //display failed dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.indigoAccent,
                    ),
                  );
                  Get.back();
                }
              },
            );
          },
        );
      },
      child: widget.child,
    );
  }
}
