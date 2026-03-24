
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../on-Boarding/widgets/custom-Button.dart';
import '../../on-Boarding/widgets/custom-textfiled.dart';

import '../Blocs/Bloc-editprofile/cubit-editprofile.dart';
import '../Blocs/Bloc-editprofile/state-editprofile.dart';
import '../getprofile/bloc/getprofileCubit.dart';
import '../getprofile/presentation/presentation.dart';

class EditProfilePage extends StatefulWidget {
  static String id = 'edit_profile';

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String? firstName;
  String? lastName;
  String? location;
  String? phone;
  File? selectedImage;
  bool isLoading = false;

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<myprofilecubit, myprofilestate>(
      listener: (context, state) {
        if (state is loadingmyprofile) {
          setState(() {
            isLoading = true;
          });
        } else if (state is successmyprofile) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: TextStyle(color: Colors.green),
              ),
            ),
          );
        } else if (state is failurmyprofile) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: TextStyle(color: Colors.red),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Edit Profile',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
                iconTheme: const IconThemeData(color: Colors.white),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.account_circle, color: Colors.white),
                    onPressed: () {
                      BlocProvider.of<getuserCubit>(context).getuser();
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfilePage()),


                      );
                    },
                  ),
                ],
              ),
              body: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.green[100],
                          backgroundImage: selectedImage != null
                              ? FileImage(selectedImage!) as ImageProvider
                              : const AssetImage('assets/default_profile.png'),
                        ),
                        GestureDetector(
                          onTap: pickImage,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.blueAccent,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    labelText: 'First Name',
                    hintText: 'Enter your first name',
                    suffixIcon: const Icon(Icons.person, color: Colors.blueAccent),
                    inputetype: TextInputType.text,


                    onChanged: (data) => firstName =data,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    labelText: 'Last Name',
                    hintText: 'Enter your last name',
                    suffixIcon: const Icon(Icons.person, color: Colors.blueAccent),
                    inputetype: TextInputType.text,
                    onChanged: (data) => lastName = data,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    labelText: 'Location',
                    hintText: 'Enter your location',
                    suffixIcon: const Icon(Icons.location_on, color: Colors.blueAccent),
                    inputetype: TextInputType.text,
                    onChanged: (data) => location = data,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    labelText: 'phone',
                    hintText: 'Enter your phone',
                    suffixIcon: const Icon(Icons.location_on, color: Colors.blueAccent),
                    inputetype: TextInputType.text,
                    onChanged: (data) => phone=data  ,

                  ),
                  const SizedBox(height: 40),
                  Custombutten(
                    text: 'Save',
                    ontap: (){
                      print("jkjjjjjjjjjjjjj///////////////////////////");
                      if (firstName == null || lastName == null || location == null || selectedImage == null||phone==null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'يرجى ملء جميع الحقول واختيار صورة',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        );
                        return;
                      }


                      BlocProvider.of<myprofilecubit>(context).editprofile(
                      first_name: firstName!,
                      last_name: lastName!,
                      location: location!,
                      photo: selectedImage!,
                      phone:phone!,
                      );
                    },
                  ),
                ],
              ),
            ),
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.green),
                ),
              ),
          ],
        );
      },
    );
  }
}