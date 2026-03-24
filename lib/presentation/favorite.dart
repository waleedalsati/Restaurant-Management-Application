import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'FavoriteCubit.dart';
import 'FavoraiteState.dart';
import 'delete/Cubitdelete.dart';
import 'modelfavorate.dart';
import '../../Helper/api.dart';

class FavoriteCategoryPage extends StatelessWidget {
  const FavoriteCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShowFavoriteCubit(api())..loadFavorites(),
        ),
        BlocProvider(
          create: (context) => DeleteFavouriteCubit(api()),
        ),
      ],
      child: const FavoriteCategory(),
    );
  }
}

class FavoriteCategory extends StatelessWidget {
  const FavoriteCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShowFavoriteCubit, ShowFavoriteState>(
      listener: (context, state) {
        if (state is ShowFavoriteError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is ShowFavoriteLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is ShowFavoriteError) {
          return Scaffold(
            body: Center(child: Text("خطأ: ${state.message}")),
          );
        } else if (state is ShowFavoriteLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("My Favorite"),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            body: state.favorites.isEmpty
                ? const Center(child: Text("لا توجد عناصر في المفضلة"))
                : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                final FoodModel item = state.favorites[index];

                final photoPath = (item.foodPhoto ?? '');
                final imageUrl = photoPath.isNotEmpty
                    ? 'https://striking-sailfish-severely.ngrok-free.app$photoPath'
                    : '';

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: imageUrl.isNotEmpty
                            ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) =>
                          const Icon(Icons.broken_image,
                              size: 60),
                        )
                            : const Icon(Icons.image_not_supported,
                            size: 60),
                      ),
                    ),
                    title: Text(
                      item.foodName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "${item.foodPrice} \$",
                      style: const TextStyle(
                          fontSize: 16, color: Colors.grey),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        print(item.id);

                        print(item.id);
                        final deleteCubit = context.read<DeleteFavouriteCubit>();
                        final favCubit = context.read<ShowFavoriteCubit>();

                        try {
                          final message = await deleteCubit.deleteFavourite(item.id);

                          await favCubit.loadFavorites();

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("" ?? "تم الحذف بنجاح")),
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("حدث خطأ أثناء الحذف")),
                            );
                          }
                        }
                      },

                    ),
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
