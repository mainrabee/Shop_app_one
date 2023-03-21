import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_project1/Layout/Shop_app/cubit/cubit.dart';
import 'package:new_project1/models/shop_app/Favorites_model.dart';
import 'package:new_project1/shared/style/colors.dart';


Widget defaultButton({

  double width=double.infinity,
  Color background=Colors.blue,
  bool isUppercase=true,
  double radius=10,
  required Function function,
  required String text,
})=>Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: background,
  ),
  width: width,
  height: 40,
  child: MaterialButton(
    onPressed:(){function();} ,
    child:
    Text(
      isUppercase? text.toUpperCase(): text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),

  ),
);

Widget defaultTextButton ({
  required String text,
  required Function function,
})=> TextButton(
  onPressed: ()
  {
    function();
  },
  child: Text(
    text.toUpperCase(),
  ),);


Widget defaultFotmField({
  required TextEditingController controller,
  required TextInputType type,
  Function (String)? onSubmit,
  // Function? onChange,
  GestureTapCallback ? onTap,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData ?suffix,
  bool isPassword=false,
  Function ? suffixPreesed,
  bool isClicable=true,

})=>TextFormField(
  controller:controller,
  keyboardType: type,
  validator:(s){validate(s);} ,
  // onChanged: (s){
  //   onChange!(s);
  // },
  onTap: onTap,
  obscureText: isPassword,
  enabled:isClicable ,
  onFieldSubmitted: onSubmit,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: suffix !=null?IconButton(
        onPressed: ()
        {
          suffixPreesed;
        },
        icon: Icon(suffix)):null,

    border:OutlineInputBorder(),
  ),
);


Widget buildTasksItem(Map model,context)=> Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        CircleAvatar(

          radius: 40,

          child: Text(

            "${model['time']}",

          ),

        ),

        SizedBox(

          width: 20,

        ),

        Expanded(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            children: [

              Text(

                "${model['title']}",

                style: TextStyle(

                  fontWeight: FontWeight.bold,

                  fontSize: 18,

                ),

              ),

              Text(

                "${model['date']}",

                style: TextStyle(

                  color: Colors.grey,

                ),

              ),

            ],

          ),

        ),

        SizedBox(

          width: 20,

        ),

        IconButton(

          onPressed: ()

          {

            AppCubit.get(context).updateData(

              status: 'done',

              id:model['id'] ,);

          },

          icon:Icon( Icons.check_box,

            color: Colors.red,

          ),

        ),

        IconButton(

          onPressed: ()

          {

            AppCubit.get(context).updateData(

              status: 'archive',

              id:model['id'] ,);

          },

          icon:Icon( Icons.archive,

            color: Colors.black45,

          ),

        ),





      ],

    ),

  ),
  onDismissed:(directional)
  {
    AppCubit.get(context).deleteData( id: model['id'],);
  } ,
);


class AppCubit {
  static get(context) {}
}

Widget buildArticleItem(article , context )=>InkWell(
  onTap: ()
  {
    navegateTo(context, WebViewScreen(article['url']),);
  },
  child: Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        Container(

          width: 120,

          height: 120,

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(10.0),

            image: DecorationImage(

              image: NetworkImage(

                  '${article['urlToImage']}'

              ),

              fit: BoxFit.cover,

            ),

          ),

        ),

        SizedBox(

          width: 20,

        ),

        Expanded(

          child: Container(

            height: 120,

            child: Column(

              // mainAxisSize: MainAxisSize.min,

              crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisAlignment: MainAxisAlignment.start,

              children: [

                Expanded(

                  child: Text('${article['title']}',

                    style:Theme.of(context).textTheme.bodyMedium,

                    maxLines: 3,

                    overflow: TextOverflow.ellipsis,),

                ),

                Text('${article['publishedAt']}',

                  style: TextStyle(

                    color: Colors.grey,

                    // fontSize:18 ,

                    // fontWeight: FontWeight.w600,



                  ),),

              ],



            ),

          ),

        ),



      ],

    ),

  ),
);

WebViewScreen(article) {
}

Widget articleBiulder (list,context)=>ConditionalBuilder(
  condition: list.length > 0,
  builder: (context)=>ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) => buildArticleItem(list[index], context),
    separatorBuilder: (context, index) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Divider(
        height: 1,
        color: Colors.grey,


      ),
    ),

    itemCount: 10,),
  fallback: (context)=>Center(child: CircularProgressIndicator()),
);

void  navegateTo(context ,widget )=>Navigator.push(
  context,
  MaterialPageRoute(
    builder:(context)=> widget,
  ),
);

void  navegateAndFinish(
    context ,widget
    )=>Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder:(context)=> widget,
  ),
      (route) =>false ,
);


dynamic alertDialog({
 required BuildContext context,
  required String nameAlert,
  required  String title,
  required String nameButtonOne,
  required Function functionOne,
  required Color backgroundColor,
   String ? nameButtonTwo,
   Function ? functionTwo,
})=>
    showDialog(

    context: context,
    builder: (context)=>
        AlertDialog(
          shadowColor: Colors.cyan,
          backgroundColor:backgroundColor,
          title: Text(nameAlert) ,
          content:  Text(title),

          actions: [
            TextButton(onPressed: (){functionOne();}, child: Text(nameButtonOne),
            ),
            TextButton(onPressed: (){functionTwo!();}, child: Text(nameButtonTwo!),)
          ],),
    );


Widget buildListProduct( model,context, {
  bool isOldPrise=true})=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,

    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage( model.image!),
              width: 120.0,
              height: 120.0,
            ),
            if (model.discount != 0 && isOldPrise)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(
                  horizontal: 5,),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 8.0,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.3,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: defualtColor,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  if (model.discount != 0 && isOldPrise)
                    Text(
                      '${ model.oldPrice} ',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: ()
                    {
                      ShopCubit.get(context).changeFavorites(model.id!);
                    },
                    icon:CircleAvatar(
                      radius: 15,
                      backgroundColor: ShopCubit.get(context).favorites[model.id] != null && ShopCubit.get(context).favorites[model.id]! ? defualtColor: Colors.grey,
                      child: Icon(
                        Icons.favorite_border,
                        size: 17,
                        color: Colors.white,
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);