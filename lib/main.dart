import 'package:block_eccomerce_app/config/routes.dart';
import 'package:block_eccomerce_app/config/theme.dart';
import 'package:block_eccomerce_app/screens/order_confirmation/order_confirmation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'blocs/blocs.dart';
import 'repositories/repoExpo.dart';
import 'screens/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //app initializing
  await Firebase.initializeApp(); //app initializing
  //Bloc.observer= SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: () => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => WishlistBloc()..add(LoadWishList())),
          BlocProvider(create: (_) => CartBloc()..add(LoadCart())),
          BlocProvider(
              create: (context) => CheckoutBloc(
                  cartBloc: context.read<CartBloc>(),
                  checkoutRepository: CheckoutRepository())),
          BlocProvider(
              create: (_) =>
                  CategoryBloc(categoryRepository: CategoryRepository())
                    ..add(LoadCategories())),
          BlocProvider(
              create: (_) => ProductBloc(productRepository: ProductRepository())
                ..add(LoadProduct())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: theme(),
          initialRoute: SplashScreen.routeName,
          routes: routes,
        ),
      ),
    );
  }
}
