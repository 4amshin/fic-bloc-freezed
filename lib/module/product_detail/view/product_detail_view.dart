// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:fic_bloc_re_learn/core.dart';

class ProductDetailView extends StatelessWidget {
  final ProductResponseModel product;
  const ProductDetailView({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title ?? 'title'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                radius: 76,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                  radius: 75,
                  backgroundImage: NetworkImage(product.images![0]),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              product.title!,
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              product.category!.name!,
              style: const TextStyle(
                fontSize: 13.0,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
