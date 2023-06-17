// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fic_bloc_re_learn/module/home/widget/hm_update_dialog.dart';
import 'package:fic_bloc_re_learn/module/product_detail/view/product_detail_view.dart';
import 'package:flutter/material.dart';

import 'package:fic_bloc_re_learn/data/model/product/get_product/product_response_model.dart';

import '../../../shared/state_util.dart';

class HmListProduct extends StatelessWidget {
  final List<ProductResponseModel> products;
  const HmListProduct({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 20),
            color: Colors.deepPurple[50],
            child: HmUpdateDialog(
              product: product,
              child: ListTile(
                title: Text(
                  product.title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  product.price!.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(product.images![0]),
                ),
                trailing: IconButton(
                  onPressed: () => Get.to(ProductDetailView(product: product)),
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
