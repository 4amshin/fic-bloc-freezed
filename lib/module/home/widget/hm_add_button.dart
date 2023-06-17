// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fic_bloc_re_learn/data/model/product/add_product/product_request_model.dart';
import 'package:fic_bloc_re_learn/module/home/bloc/add_product/add_product_bloc.dart';
import 'package:fic_bloc_re_learn/module/home/bloc/get_product/get_product_bloc.dart';
import 'package:fic_bloc_re_learn/shared/widgets/Buttons/dialog_button.dart';
import 'package:flutter/material.dart';

import 'package:fic_bloc_re_learn/shared/widgets/InputField/text_input/text_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/state_util.dart';

class HmAddButton extends StatelessWidget {
  final TextEditingController? titleController;
  final TextEditingController? priceController;
  final TextEditingController? descriptionController;
  const HmAddButton({
    Key? key,
    this.titleController,
    this.priceController,
    this.descriptionController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AddProductBloc>();
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return BlocConsumer<AddProductBloc, AddProductState>(
              builder: (context, state) {
                if (state is AddProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return AlertDialog(
                  title: const Text(
                    'Add Product',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextInput(
                        label: 'Title',
                        controller: titleController,
                      ),
                      TextInput(
                        label: 'Price',
                        controller: priceController,
                      ),
                      TextInput(
                        label: 'Description',
                        controller: descriptionController,
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
                      label: 'Save',
                      onTap: () {
                        final productModel = ProductRequestModel(
                          title: titleController!.text,
                          description: descriptionController!.text,
                          price: int.parse(priceController!.text),
                        );

                        bloc.add(DoAddProductEvent(model: productModel));
                      },
                    ),
                  ],
                );
              },
              listener: (context, state) {
                //when success
                if (state is AddProductLoaded) {
                  //display success dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Add Product Success'),
                      backgroundColor: Colors.indigoAccent,
                    ),
                  );
                  //add the product into api and refresh the list
                  context
                      .read<GetProductBloc>()
                      .add(AddSingleProductEvent(model: state.model));
                  context.read<GetProductBloc>().add(DoGetProductEvent());
                  Get.back();
                }

                if (state is AddProductError) {
                  //display failed dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Add Product Failed'),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                  Get.back();
                }
              },
            );
          },
        );
      },
      backgroundColor: Colors.deepPurple,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
