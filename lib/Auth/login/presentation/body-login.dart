
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Home/presentation/home.dart';
import '../../../on-Boarding/widgets/custom-Button.dart';
import '../../../on-Boarding/widgets/custom-textfiled.dart';
import '../../register/presntation/register.dart';
import '../Bloc/Sigin-cubit.dart';
import '../Bloc/sigin-State.dart';


class BodyLogin extends StatelessWidget {
  String? email;
  String? password;
  bool isLoading = false;

  Future<void> _setLang(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("lang", lang);


  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SiginCubit, siginstate>(
      listener: (context, state) {
        if (state is loading) {
          isLoading = true;
        } else if (state is success) {
          isLoading = false;
          Navigator.pushNamed(context, home.id);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.massage,
                style: const TextStyle(color: Colors.green),
              ),
            ),
          );
        } else if (state is failer) {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.massage,
                style: const TextStyle(color: Colors.green),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(''),
              backgroundColor: Colors.green,
              actions: [
                PopupMenuButton<String>(
                  icon: const Icon(Icons.language, color: Colors.white),
                  onSelected: (value) {
                    _setLang(value);
                  },
                  itemBuilder: (context) => [
                     PopupMenuItem(
                      value: "en",
                      child: Text("English"),
                      onTap:()
                      {
                        context.setLocale(Locale('en'));

                        Restart.restartApp();
                      },
                    ),
                     PopupMenuItem(
                      value: "ar",
                      child: Text("العربية"),
                      onTap:()
                      {
                        context.setLocale(Locale('ar'));

                        Restart.restartApp();
                      },
                    ),
                  ],
                ),
              ],
            ),
            body: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Lottie.asset(
                    'lib/anamation/Animation - 1745350287959.json',
                    height: 170,
                    width: 170,
                  ),
                ),
                const SizedBox(height: 10),
             Text( 'LOGIN'.tr(), style: TextStyle( color: Colors.green, fontSize: 30, ),),

                const SizedBox(height: 20),
                CustomTextField(
                  labelText: 'email'.tr(),
                  hintText: 'Enter your email'.tr(),
                  suffixIcon:
                  const Icon(Icons.email, color: Colors.blueAccent),
                  inputetype: TextInputType.text,
                  onChanged: (data) {
                    email = data;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  labelText: 'Password'.tr(),
                  hintText: 'Enter your password'.tr(),
                  suffixIcon:
                  const Icon(Icons.lock, color: Colors.blueAccent),
                  inputetype: TextInputType.text,
                  onChanged: (data) {
                    password = data;
                  },
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, forgotpassword.id);
                    },
                    child:  Text(
                      'FORGOT PASSWORD?'.tr(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Custombutten(
                  text: 'Login'.tr(),
                  ontap: () {
                    BlocProvider.of<SiginCubit>(context)
                        .signIn(email: email!, password: password!);
                  },
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                      'Don\'t have an account? '.tr(),
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Register.id);
                      },
                      child:  Text(
                        'Register'.tr(),
                        style:  TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
