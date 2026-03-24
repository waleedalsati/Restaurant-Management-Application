
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../Home/presentation/home.dart';
import '../../../on-Boarding/widgets/custom-Button.dart';
import '../../../on-Boarding/widgets/custom-textfiled.dart';
import '../../login/presentation/login.dart';
import '../Bloc/register-cubit.dart';
import '../Bloc/register-state.dart';

class bodyregister extends StatelessWidget {
  static String id='register';
  bool isloding=false;
  String? email;
  String? password;
  String?fname;
  String?lname;
  String? passwordcon;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<registercubit,registerstate>(
      listener: (context,state)
      {
        if(state is loadingregister)
          {
            isloding=true;
          }
        else if(state is successregister)
          {

         Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
            ScaffoldMessenger.of(context).showSnackBar(

                SnackBar(

                    content: Text(state.massage,style: const TextStyle(color: Colors.green),))


            );
            isloding=false;

          }
        else if(state is failerregister)
            {
            //  Navigator.pushNamed(context, home.id);
              isloding =false;
              ScaffoldMessenger.of(context).showSnackBar(

                  SnackBar(

                      content: Text(state.massage,style: const TextStyle(color: Colors.green),))


              );
            }
      },
      builder: ( context,  state) {
        return  ModalProgressHUD(
          inAsyncCall: isloding,
          child: Scaffold(
            appBar: AppBar(
              title: Text(''),
              backgroundColor: Colors.green,
            ),
            body: ListView(
              children: [
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: LottieBuilder.asset
                    (
                      'lib/anamation/Animation - 1745336220461.json',
                      height: 170,width: 170),
                ),
                 Padding(
                  padding: EdgeInsets.only(left: 18),
                  child: Text('Create your account'.tr(),
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 30,
                    ),

                  ),
                ),
                const SizedBox(height: 20,),
                CustomTextField(
                  labelText: 'firstname'.tr(),

                  hintText: 'firstname'.tr(),
                  inputetype: TextInputType.text,
                  suffixIcon: const Icon(Icons.person,color: Colors.blueAccent,),
                  onChanged: (data )
                  {

                    fname=data;
                  },


                ),
                const SizedBox(height: 20,),
                CustomTextField(
                  labelText: 'lastname'.tr(),

                  hintText: 'lastname'.tr(),
                  inputetype: TextInputType.text,
                  suffixIcon: const Icon(Icons.person,color: Colors.blueAccent,),

                  onChanged: (data ) {
                    lname=data;

                  },


                ),
                const SizedBox(height: 20,),
                CustomTextField(
                  suffixIcon: const Icon(Icons.email,color: Colors.blueAccent,),
                  labelText:'email'.tr() ,
                  hintText: 'email'.tr(),
                  inputetype: TextInputType.text,
                  onChanged: (data ) {
                    email=data;
                  },

                ),
                const SizedBox(height: 20,),
                CustomTextField(
                  labelText: 'Password'.tr(),
                  suffixIcon: Icon(FontAwesomeIcons.lock,color: Colors.blueAccent,),
                  hintText: 'Password'.tr(),
                  inputetype: TextInputType.text,
                  onChanged: (data ) {
                    password=data;
                  },
                ),
                const SizedBox(height: 20,),
                CustomTextField(
                  labelText: 'Password confirmation'.tr(),
                  hintText: 'Enter your Password confirmation'.tr(),
                  suffixIcon: const Icon(FontAwesomeIcons.lock, color: Colors.blueAccent),
                  inputetype: TextInputType.text,
                  onChanged: (data) {
                    passwordcon = data;
                  },
                ),
                const SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0,right: 32.0),
                  child: Custombutten(text: 'register'.tr(), ontap: () {

                    BlocProvider.of<registercubit>(context).register(firstname: fname!,
                        lsatname: lname!, email: email!, password: password!, passwordcon: passwordcon!,tok: 'err');

                  },),
                ),
                const SizedBox(height: 90,),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text('Already an account?'.tr(),
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                        ),
                      ),
                      GestureDetector(
                        onTap: ()
                        {
                          Navigator.pushNamed(context, Login.id);
                        },
                        child:  Text('login'.tr(),
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

          ),
        );

    },

    );
  }
}
