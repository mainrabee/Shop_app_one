import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project1/Layout/Shop_app/Shop_layout.dart';
import 'package:new_project1/shared/components/constants.dart';
import 'package:new_project1/shared/network/shared.network.local/cache_helper.dart';
import 'package:new_project1/shared/style/colors.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_project1/shop_app/login_screen/Cubit/States.dart';

import '../../shared/components/components.dart';
import '../register_screen/Shop_register_screen.dart';
import 'Cubit/Cubit.dart';



class ShopLoginScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>ShopLoginCubit(),
        child:BlocConsumer<ShopLoginCubit,ShopLoginStates>(
          listener: (context,state)
          {
            if (state is ShopLoginSuccessState)
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
                    print(state.loginModels.message);
                    showToast(
                      backgroundColor:Colors.red ,
                      context: context,
                      message: state.loginModels.message,
                    );
                  }
              }
          },
          builder: (context,state)
          {
            return Scaffold(
              appBar: AppBar(
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Text(
                            'LOGIN',
                            style:TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'login now to browse our hot offers',
                            style:TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                            ),
                          ),

                          SizedBox(
                            height: 25,
                          ),



                        defaultFotmField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String value) {
                          if (value.isEmpty ) {
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
                          if (formKey.currentState!.validate()) {
                            ShopLoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        isPassword: ShopLoginCubit.get(context).isPassword,
                        suffixPreesed: () {
                          ShopLoginCubit.get(context).changePasswordVisibility();
                        },
                        type: TextInputType.visiblePassword,
                        validate: (value) {
                          if (value.isEmpty ) {
                            return 'Password is too short';
                          }
                        },
                        label: 'Password',
                        prefix: Icons.lock_open_outlined,
                        suffix: ShopLoginCubit.get(context).suffix,
                      ),
                          SizedBox(
                            height: 30,
                          ),

                          ConditionalBuilder(
                            condition: state is! ShopLoginloadingState,
                            builder: (BuildContext context) =>
                                defaultButton(
                              isUppercase: true,
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: 'LOGIN',
                            ),
                            fallback: (BuildContext context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),

                          SizedBox(
                            height: 15,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'You Don \'t Have An Account ?',
                              ),
                              defaultTextButton(
                                function: ()
                                {
                                  navegateAndFinish(context, ShopRegisterScreen());
                                },
                                text: 'Register Now',
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        )
    );
  }
}
