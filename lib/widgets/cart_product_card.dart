import 'package:block_eccomerce_app/blocs/cart/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/models.dart';

class CartProductCard extends StatelessWidget {
  const CartProductCard({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 8.0.h),
      child: Row(
        children: [
          Image.network(
            product.imageUrl,
            height: 80.h,
            width: 100.w,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  "\$${product.price}",
                  style: Theme.of(context).textTheme.headline6,
                )
              ],
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          BlocBuilder<CartBloc, CartState>(
  builder: (context, state) {
    return Row(
            children: [
              IconButton(onPressed: () {
                context.read<CartBloc>().add(RemoveProduct(product));
              }, icon: const Icon(Icons.remove_circle)),
              Text(
                '1',
                style: Theme.of(context).textTheme.headline5,
              ),
              IconButton(onPressed: () {
                context.read<CartBloc>().add(AddProduct(product));
              }, icon: const Icon(Icons.add_circle))
            ],
          );
  },
)
        ],
      ),
    );
  }
}