import 'dart:developer';

import 'package:fic_bloc_re_learn/module/home/bloc/get_product/get_product_bloc.dart';
import 'package:fic_bloc_re_learn/module/home/widget/hm_add_button.dart';
import 'package:fic_bloc_re_learn/module/home/widget/hm_list_product.dart';
import 'package:fic_bloc_re_learn/module/home/widget/hm_logout_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController? titleController;
  TextEditingController? priceController;
  TextEditingController? descriptionController;

  @override
  void initState() {
    titleController = TextEditingController();
    priceController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
    context.read<GetProductBloc>().add(DoGetProductEvent());
  }

  @override
  void dispose() {
    titleController!.dispose();
    priceController!.dispose();
    descriptionController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final bloc = context.read<GetProductBloc>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('All Product'),
        actions: const [HmLogoutButton()],
      ),
      body: BlocBuilder<GetProductBloc, GetProductState>(
        builder: (context, state) {
          if (state is GetProductLoading) {
            log("Loading State");
            return const Center(child: CircularProgressIndicator());
          }
          if (state is GetProductLoaded) {
            log("Loaded State: ${state.dataList.length} Data");
            //initialize list data in descending order
            final products = state.dataList.reversed.toList();

            //initialize list data in ascending order
            // final products = state.dataList;
            return RefreshIndicator(
              onRefresh: () async {
                context.read<GetProductBloc>().add(DoGetProductEvent());
              },
              child: HmListProduct(products: products),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: HmAddButton(
        titleController: titleController,
        priceController: priceController,
        descriptionController: descriptionController,
      ),
    );
  }
}
