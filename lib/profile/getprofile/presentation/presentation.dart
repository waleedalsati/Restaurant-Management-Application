import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presntation/edit-profile.dart';
import '../bloc/getprofileCubit.dart';
import '../bloc/getprofilestate.dart';

class ProfilePage extends StatelessWidget {
  static String id = 'profile_page';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<getuserCubit, getprofilestate>(
      listener: (context, state) {
        if (state is successgetprofile) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: const TextStyle(color: Colors.green),
              ),
            ),
          );
        } else if (state is faileurgetprofile) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is loadinggetprofile) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('My Profile', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (state is faileurgetprofile) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('My Profile', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: Center(child: Text("خطأ: ${state.message}")),
          );
        } else if (state is successgetprofile) {
          final user = state.user;

          String? photoUrl;
          if (user.photo != null && user.photo!.isNotEmpty) {
        print(user.photo);
            photoUrl = "https://striking-sailfish-severely.ngrok-free.app/${user.photo}";
            print("PHOTO URL: $photoUrl"); // Debug
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('My Profile', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green,
              iconTheme: const IconThemeData(color: Colors.white),
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  onPressed: () {
                    print(photoUrl);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => EditProfilePage()),
                    );
                  },
                )
              ],
            ),
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SizedBox(height: 30),
                Center(
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: user.photo != null
                        ? NetworkImage(user.photo!)
                        : const AssetImage('assets/images/default_user.png') as ImageProvider,
                  )
                ),

                const SizedBox(height: 30),
                _buildInfoTile(
                  icon: Icons.person,
                  label: 'الاسم الأول',
                  value: user.first_name,
                ),
                const SizedBox(height: 20),
                _buildInfoTile(
                  icon: Icons.person,
                  label: 'الاسم الأخير',
                  value: user.last_name ?? 'لا يوجد اسم',
                ),
                const SizedBox(height: 20),
                _buildInfoTile(
                  icon: Icons.email,
                  label: 'البريد الإلكتروني',
                  value: user.email,
                ),
                const SizedBox(height: 20),
                _buildInfoTile(
                  icon: Icons.location_on,
                  label: user.location == null ? 'يرجى إدخال الموقع' : 'الموقع',
                  value: user.location ?? 'لا يوجد موقع',
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('My Profile', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: const Center(child: Text("حدث خطأ أو لا توجد بيانات.")),
          );
        }
      },
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 13,
                    )),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
