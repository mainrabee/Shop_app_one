import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project1/Layout/Shop_app/cubit/cubit.dart';
import 'package:new_project1/Layout/Shop_app/cubit/states.dart';
import 'package:new_project1/shared/components/components.dart';
import 'package:new_project1/shared/components/constants.dart';

class SettingScreen extends StatelessWidget {
   SettingScreen({Key? key}) : super(key: key);

   var formKey = GlobalKey<FormState>();

   var nameController=TextEditingController();
 var emailController=TextEditingController();
 var phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state) {},
      builder: (context,state)
      {
        var  model = ShopCubit.get(context).usermodel;

        nameController.text=model!.data!.name!;
        emailController.text=model.data!.email!;
        phoneController.text=model.data!.phone!;

        return  ConditionalBuilder(
          condition:ShopCubit.get(context).usermodel !=null,
          builder: (context)=> Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if(state is ShopLoadingUpdateDataState)
                    LinearProgressIndicator(),
                    SizedBox(
                      height: 10,),
                    defaultFotmField(
                      controller: nameController,
                      type: TextInputType.text,
                      validate: (String value)
                      {
                        if(value.isEmpty)
                        {
                          return 'name must not be empty';
                        }
                        return 'waw';
                      },
                      label: 'Name',
                      prefix: Icons.person,),

                    SizedBox(
                      height: 20,),

                    defaultFotmField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (String value)
                      {
                        if(value.isEmpty)
                        {
                          return 'email must not be empty';
                        }
                        return 'waw';
                      },
                      label: 'Email Address',
                      prefix: Icons.email_outlined,),

                    SizedBox(height: 20,),

                    defaultFotmField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String  value)
                      {
                        if(value.isEmpty)
                        {
                          return 'phone must not be empty';
                        }
                        return 'waw';
                      },
                      label: 'Phone number',
                      prefix: Icons.phone_android,),
                    SizedBox(
                      height: 20,),

                    defaultButton(
                      function: ()
                      {
                        if(formKey.currentState!.validate())
                        {
                          ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,);
                        }
                      },
                      text: 'UPDATE',),
                    SizedBox(
                      height: 15,
                    ),
                    defaultButton(
                        function: ()
                        {
                          showDialog(
                              context: context,
                              builder: (context)=>AlertDialog(
                                shadowColor: Colors.cyan,
                                backgroundColor: Colors.blue,
                                title:const Text("Log Out") ,
                                content: const Text("Are you sure to logout ?"),
                                actions: [
                                  TextButton(
                                    onPressed:()
                                    {
                                      Navigator.pop(context);
                                    } ,
                                    child: Text('cancle',
                                        style: TextStyle(
                                            color: Colors.black,
                                        ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: ()
                                    {
                                      signOut(context);
                                    },
                                    child: Text('yes',
                                      style: TextStyle(
                                          color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ));
                          },
                        text: 'logout',
                      isUppercase: true,
                    ),

                  ],
                ),
              ),
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),

        );
      },

    );
  }
}
