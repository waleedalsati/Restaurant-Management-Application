
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../Auth/login/presentation/login.dart';
import '../Auth/logout/logoutCubit.dart';
import '../Auth/token.dart';

import '../cart (2)/dart/presentation.dart';
import '../myorder/presentation/myorder.dart';
import '../order-confri3/presntation/my-order.dart';
import '../presentation/FavoriteCubit.dart';
import '../presentation/favorite.dart';
import '../profile/presntation/edit-profile.dart';
import '../tabels/presentation/BookingListScreen.dart';
import '../tabels/presentation/EditBookingScreen.dart';
import 'aboutApplacation.dart';

class Mydrawer extends StatelessWidget {
  static String id = 'Mydrawer';
  Mydrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<logoutCubit,logoutState>(listener:(context,state) async {
        if(state is successlogout)
          {
          final t=  await StorageHelper.clearToken();
          print(t);

            Navigator.pop(context);
            print("the token removed");
            Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=> Login()));

            ScaffoldMessenger.of(context).showSnackBar
            (

                SnackBar(
                    content:

                    Text(state.message,style: TextStyle(color: Colors.green),)
                )

            );
          }else if(state is faileur)
            {

              ScaffoldMessenger.of(context).showSnackBar
              (

                  SnackBar(
                      content:

                      Text(state.message,style: TextStyle(color: Colors.green),)
                  )
              );


                  }



      } , builder:(context,state){
        return

          Drawer(
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  accountName: const Text(
                    'waleed',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  accountEmail: Text(
                    'alsatiwaleed@gmail.com',
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 15,
                    ),
                  ),
                  currentAccountPicture: GestureDetector(
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),

                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [

                      InkWell(
                        onTap: () {},
                        child: ListTile(
                          leading: Icon(
                            Icons.home,
                            color: Colors.green,
                          ),
                          trailing: Icon(Icons.arrow_forward_ios, size: 15),
                          title: Text(
                            'home'.tr(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),

                      ExpansionTile(
                        title: Text(
                          'account'.tr(),
                          style: TextStyle(fontSize: 18),
                        ),
                        children: [
                          InkWell(
                            onTap: () {},
                            child: ListTile(
                              leading: Icon(
                                Icons.settings,
                                color: Colors.green,
                              ),
                              title: Text('edit password'.tr()),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfilePage(),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: Icon(
                                Icons.settings,
                                color: Colors.green,
                              ),
                              title: Text('edit personal settings'.tr()),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),

                      InkWell(
                        onTap: () {

                          BlocProvider.of<ShowFavoriteCubit>(context).loadFavorites();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>FavoriteCategory()));

                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.favorite,
                            color: Colors.green,
                          ),
                          title: Text(
                            'favorite'.tr(),
                            style: TextStyle(fontSize: 18),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {

                          Navigator.pushNamed(context, cart.id);
                        },
                        child:  ListTile(
                          leading: Icon(
                            Icons.shopping_cart,
                            color: Colors.green,
                          ),
                          title: Text(
                            'my cart'.tr(),
                            style: TextStyle(fontSize: 18),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ConfirmedOrdersPage()),
                          );
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.receipt_sharp,
                            color: Colors.lightGreen,
                          ),
                          title: Text(
                            'my order'.tr(),
                            style: TextStyle(fontSize: 18),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 15,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: ()
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BookingListScreen()),
                          );
                        },
                        child:  ListTile(
                          leading: Icon(
                            Icons.table_restaurant,
                            color: Colors.lightGreen,
                          ),
                          title: Text(
                            'my table'.tr(),
                            style: TextStyle(fontSize: 18),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 15,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AppInfoPage()),
                          );
                        },

                        child: ListTile(
                          leading: Icon(
                            Icons.receipt_sharp,
                            color: Colors.lightGreen,
                          ),
                          title: Text(
                            'about applacation'.tr(),
                            style: TextStyle(fontSize: 18),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 15,
                          ),
                        ),

                      ),

                    ],
                  ),
                ),

                Divider(),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.redAccent,
                    ),
                    title: Text(
                      'Logout'.tr(),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.redAccent,
                      ),
                    ),
                    onTap: () async {

                      final  token= await  StorageHelper.getToken();
                      print(token);
                      print("thoken find");
                      BlocProvider.of<logoutCubit>(context).logout(token: token);

                    },
                  ),
                ),
              ],
            ),
          );


      } );
;
  }
}
