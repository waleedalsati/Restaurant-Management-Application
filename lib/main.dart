import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:projectweather/presentation/FavoriteCubit.dart';
import 'package:projectweather/presentation/add/AddFavoriteCubit.dart';
import 'package:projectweather/presentation/delete/Cubitdelete.dart';
import 'package:projectweather/profile/Blocs/Bloc-editprofile/cubit-editprofile.dart';
import 'package:projectweather/profile/getprofile/bloc/getprofileCubit.dart';
import 'package:projectweather/tabels/Blocs/Bloc-show-table/cubit-show-table.dart';
import 'package:projectweather/tabels/Blocs/Bloc-tabel/cubit-table.dart';
import 'package:projectweather/tabels/Blocs/Bloc-update/cubit-update.dart';
import 'package:projectweather/tabels/Blocs/Boc-delet-table/cubite-delete-table.dart';
import 'package:projectweather/tabels/presentation/BookingListScreen.dart';
import 'package:projectweather/tabels/presentation/EditBookingScreen.dart';
import 'package:projectweather/tabels/presentation/table.dart';


import 'Auth/login/Bloc/Sigin-cubit.dart';
import 'Auth/login/presentation/login.dart';
import 'Auth/logout/logoutCubit.dart';
import 'Auth/password/forgot-password.dart';
import 'Auth/register/Bloc/register-cubit.dart';
import 'Auth/register/presntation/register.dart';
import 'Auth/widgets/homepage-delivery.dart';
import 'Helper/api.dart';
import 'Home/Blocs/Bloc-categroy/categroy-cubit.dart';
import 'Home/food/foodcubit.dart';
import 'Home/presentation/home.dart';
import 'Home/searshall/SearshAllCubit.dart';


import 'cart (2)/dart/Blocs/Bloc-add-cart/addcart-cubit.dart';
import 'cart (2)/dart/Blocs/Bloc-delete-cart/delete-cart-cubit.dart';
import 'cart (2)/dart/Blocs/Bloc-show-all-cart/show-all-cart-cubit.dart';
import 'cart (2)/dart/Blocs/Bloc-update/update-cart-cubit.dart';
import 'cart (2)/dart/presentation.dart';
import 'drawer/mydrawer.dart';
import 'on-Boarding/presentation/Screen-Splash.dart';
import 'order-confri3/presntation/Bloc-confirm/confrim-cubit.dart';
import 'order-confri3/presntation/Bloc-myorder/cubit-myorder.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(

      EasyLocalization(
          supportedLocales: [Locale('en'), Locale('ar')],
          path:'assets/assets/translation',
          fallbackLocale: const Locale('en'),
          saveLocale: true,
          child: Sopping()
      ),
      );
}

class Sopping extends StatefulWidget {
  @override
  State<Sopping> createState() => _SoppingState();
}

class _SoppingState extends State<Sopping> {


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SiginCubit(api())),
        BlocProvider(create: (context) => DeleteFavouriteCubit(api())),
        BlocProvider(create: (context) => confrimcubit()),
        BlocProvider(create: (context) =>
        ConfirmedOrdersCubit()
          ..fetchConfirmedOrders()),
        BlocProvider(create: (context) => ShowFavoriteCubit(api())),
        BlocProvider(create: (context) => registercubit(api())),
        BlocProvider(create: (context) => myprofilecubit()),
        BlocProvider(create: (context) => AddFavoriteCubit(api())),
        BlocProvider(create: (context) => logoutCubit(api())),
        BlocProvider(create: (context) => getuserCubit(api())),
        BlocProvider(create: (context) => SearshAllcubit(api())),
        BlocProvider(create: (context) => AddCartCubit(api())),
        BlocProvider(create: (context) =>
        ShowCartCubit(api())
          ..showcart()),
        BlocProvider(create: (context) => UpdateCartCubit(api())),
        BlocProvider(create: (context) => deletecartcubit()),
        BlocProvider(create: (context) => foodcubit(api())),
        BlocProvider(create: (context) => cubittable()),
        BlocProvider(create: (context) => ReservationCubit()),
        BlocProvider(create: (context) => deletetablecubit()),
        BlocProvider(create: (context) => EditReservationCubit()),
        BlocProvider(create: (context) =>
        categroycubit(api())
          ..categroy()),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,

        routes: {
          Login.id: (context) => Login(),
          Register.id: (context) => Register(),
          home.id: (context) => home(),
          Mydrawer.id: (context) => Mydrawer(),
          cart.id: (context) => cart(),
          homepagedel.id: (context) => homepagedel(),
          TableBookingScreen.id: (context) => TableBookingScreen(),
          BookingListScreen.id: (context) => BookingListScreen(),
          EditBookingScreen.id: (context) => EditBookingScreen(),
        },
        home: ScreenSplash(),
      ),
    );
  }
}
