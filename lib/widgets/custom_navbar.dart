import 'package:block_eccomerce_app/constants.dart';
import 'package:block_eccomerce_app/screens/checkout/checkout_screen.dart';
import 'package:block_eccomerce_app/screens/order_confirmation/order_confirmation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import '../blocs/blocs.dart';
import '../models/models.dart';
import '../screens/screens.dart';

class CustomNavBar extends StatelessWidget {
  final String screen;
  final Product? product;

  const CustomNavBar({required this.screen, this.product});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: SizedBox(
          height: 70.h,
          child: (screen == '/checkOut')
              ? const OrderNowNavBar()
              : (screen == '/Products')
                  ? AddToCartNavBar(
                      product: product!,
                    )
                  : (screen == '/Cart_screen')
                      ? const GoToCheckOutNavBar()
                      : const HomeNavBar()),
    );
  }
}

class HomeNavBar extends StatelessWidget {
  const HomeNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, HomeScreen.routeName);
            },
            icon: const Icon(
              Icons.home_filled,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            },
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            )),
      ],
    );
  }
}

class AddToCartNavBar extends StatelessWidget {
  final Product product;

  const AddToCartNavBar({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
              color: Colors.white,
            )),
        BlocBuilder<WishlistBloc, WishlistState>(
          builder: (context, state) {
            return IconButton(
                onPressed: () {
                  context
                      .read<WishlistBloc>()
                      .add(AddProductToWishList(product));
                  const snackBar = SnackBar(
                    content: Text('Added to your Wishlist'),
                    duration: Duration(milliseconds: 300),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                ));
          },
        ),
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            return ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                onPressed: () {
                  context.read<CartBloc>().add(AddProduct(product));
                  Navigator.pushNamed(context, CartScreen.routeName);
                },
                child: Text(
                  'Add To Cart',
                  style: Theme.of(context).textTheme.headline3,
                ));
          },
        )
      ],
    );
  }
}

class GoToCheckOutNavBar extends StatelessWidget {
  const GoToCheckOutNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, CheckOutScreen.routeName);
            },
            child: Text(
              'GO TO CHECKOUT',
              style: Theme.of(context).textTheme.headline3,
            ))
      ],
    );
  }
}

class OrderNowNavBar extends StatelessWidget {
  const OrderNowNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        if (state is CheckoutLoading) {
          return loading();
        }
        if (state is CheckoutLoaded) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  onPressed: () {
                    context.read<CheckoutBloc>().add(ConfirmCheckout(checkout: state.checkout));
                    Navigator.pushNamed(context, OrderConfirmation.routeName);

                  },
                  child: Text(
                    'ORDER NOW',
                    style: Theme.of(context).textTheme.headline3,
                  ))
            ],
          );
        } else {
          return error();
        }
      },
    );
  }
}
