import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project1/Layout/Shop_app/Shop_layout.dart';
import 'package:new_project1/Layout/Shop_app/cubit/cubit.dart';
import 'package:new_project1/shared/components/components.dart';
import 'package:new_project1/shared/components/constants.dart';
import 'package:new_project1/shared/network/shared.network.local/cache_helper.dart';
import 'package:new_project1/shop_app/login_screen/Cubit/Cubit.dart';
import 'package:new_project1/shop_app/login_screen/Cubit/States.dart';
import 'package:new_project1/shop_app/register_screen/Cubit_register/Cubit.dart';
import 'package:new_project1/shop_app/register_screen/Cubit_register/States.dart';

class ShopRegisterScreen extends StatelessWidget {
  ShopRegisterScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ShopRegisterCubit(),
        child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
            listener: (context, state)
            {
              if (state is ShopRegisterSuccessState)
              {
                if( state.loginModels.status!)
                {
                  print(state.loginModels.message);
                  print(state.loginModels.data?.token );

                  CacheHelper.saveData(
                    key: 'token',
                    value: state.loginModels.data!.token,
                  ).then((value){
                    token = state.loginModels.data!.token;
                    navegateAndFinish(
                        context,
                        ShopLayout());
                  });
                  showToast(
                    backgroundColor:Colors.green ,
                    context: context,
                    message: state.loginModels.message,
                  );
                }else
                {
                  showToast(
                    backgroundColor:Colors.red ,
                    context: context,
                    message: state.loginModels.message,
                  );
                }
              }
            },
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(),
                body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Register now to browse our hot offers',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 25,
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            defaultFotmField(
                              controller: nameController,
                              type: TextInputType.name,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'name must not be empty';
                                }
                              },
                              label: 'name',
                              prefix: Icons.person,
                            ),
                            SizedBox(
                              height: 15,
                            ),

                            defaultFotmField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Email address must not be empty';
                                }
                              },
                              label: 'Email Address',
                              prefix: Icons.email_outlined,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            defaultFotmField(
                              controller: passwordController,
                              onSubmit: (value) {
                              },
                              isPassword:
                                  ShopRegisterCubit.get(context).isPassword,
                              suffixPreesed: () {
                                ShopRegisterCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              type: TextInputType.visiblePassword,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'Password is too short';
                                }
                              },
                              label: 'Password',
                              prefix: Icons.lock_open_outlined,
                              suffix: ShopRegisterCubit.get(context).suffix,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            defaultFotmField(
                              controller: phoneController,
                              type: TextInputType.phone,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'phone address must not be empty';
                                }
                              },
                              label: 'Phone Number',
                              prefix: Icons.phone,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 30,
                            ),

                            ConditionalBuilder(
                              condition: state is! ShopRegisterloadingState,
                              builder: (BuildContext context) => defaultButton(
                                isUppercase: true,
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopRegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                },
                                text: 'REGISTER',
                              ),
                              fallback: (BuildContext context) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}
