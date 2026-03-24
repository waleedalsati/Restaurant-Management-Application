import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../drawer/mydrawer.dart';
import '../../profile/Blocs/Bloc-editprofile/cubit-editprofile.dart';
import '../../profile/getprofile/bloc/getprofileCubit.dart';
import '../../profile/getprofile/presentation/presentation.dart';
import '../../profile/presntation/edit-profile.dart';
import '../../tabels/presentation/table.dart';
import '../Blocs/Bloc-categroy/category-state.dart';
import '../Blocs/Bloc-categroy/categroy-cubit.dart';
import '../food/foodcubit.dart';
import '../searshall/SearshAllCubit.dart';
import '../searshall/searshallstate.dart';
import 'foodpage.dart';
import '../../Helper/api.dart';

class HomeWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SearshAllcubit(api())),
        BlocProvider(create: (context) => categroycubit(api())..categroy()),
      ],
      child: home(),
    );
  }
}

class home extends StatefulWidget {
  static String id = 'home';

  @override
  State<home> createState() => _HomeState();

}

class _HomeState extends State<home> {
  bool isoading=true;
  final GlobalKey<ScaffoldState> _keyDrawer = GlobalKey<ScaffoldState>();
  int x = 0;

  void ontabe(int y) {
    setState(() {
      x = y;
    });
    if (y == 3) {
      Navigator.pushNamed(context, TableBookingScreen.id);
    }
    if (y == 2) {
      BlocProvider.of<getuserCubit>(context).getuser();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => EditProfilePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _keyDrawer,
      drawer: Mydrawer(),
      appBar: AppBar(
        title:  Text('Categories'.tr()),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _keyDrawer.currentState?.openDrawer();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // مربع البحث
            TextField(
              onChanged: (query) {
                if (query.isNotEmpty) {
                  context.read<SearshAllcubit>().Searshall(query);
                } else {
                  // لو المستخدم مسح البحث → رجّع التصنيفات
                  context.read<categroycubit>().categroy();
                }
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'ابحث عن التصنيفات...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              ),
            ),
            const SizedBox(height: 12),

            // BlocBuilder موحد
            Expanded(
              child: BlocBuilder<SearshAllcubit, SearshAllstate>(
                builder: (context, state) {
                 if (state is lodedSearsh) {
                    final categories = state.category;
                    if (categories.isEmpty) {
                      return const Center(child: Text('لا توجد نتائج بحث'));
                    }
                    return buildListView(categories, context);
                  } else if (state is failSearsh) {
                    return Center(child: Text(state.message));
                  }


                  return BlocBuilder<categroycubit, CategoryState>(
                    builder: (context, state) {
                      if (state is CategoryLoading) {
                        return const Center(
                            child: CircularProgressIndicator());
                      } else if (state is CategoryFailer) {
                        return Center(child: Text(state.message));
                      } else if (state is CategorySuccess) {
                        final categories = state.categories;
                        if (categories.isEmpty) {
                          return const Center(child: Text('لا توجد ماكولات'));
                        }
                        return buildListView(categories, context);
                      }
                      return Container();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: x,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: ontabe,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu), label: 'Menu'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.table_bar_sharp), label: 'Tables'),
        ],
      ),
    );
  }
}

// دالة تبني الليست
Widget buildListView(List categories, BuildContext context) {
  return ListView.separated(
    itemCount: categories.length,
    separatorBuilder: (context, index) => const SizedBox(height: 12),
    itemBuilder: (context, index) {
      final category = categories[index];
      return GestureDetector(
        onTap: () {
          final categoryId = int.parse(category.id.toString());
          BlocProvider.of<foodcubit>(context).food(categoryId);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FoodDisplayPage()),
          );
        },
        child: CategoryCard(
          name: category.name,
          description: category.des,
          imageUrl: category.photo,
        ),
      );
    },
  );
}

class CategoryCard extends StatelessWidget {
  final String? name;
  final String? description;
  final String? imageUrl;

  final String baseUrl = "https://finer-needlessly-sawfish.ngrok-free.app";

  CategoryCard({super.key, this.name, this.description, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    String? fullImageUrl;
    if (imageUrl != null && imageUrl!.startsWith("/")) {
      fullImageUrl = baseUrl + imageUrl!;
    } else {
      fullImageUrl = imageUrl;
    }

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: fullImageUrl != null && fullImageUrl.isNotEmpty
                  ? Image.network(
                fullImageUrl,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image,
                    size: 90, color: Colors.grey),
              )
                  : Container(
                width: 90,
                height: 90,
                color: Colors.grey[300],
                child:
                const Icon(Icons.image, size: 50, color: Colors.white),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name ?? "بدون اسم",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description ?? "لا يوجد وصف",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
