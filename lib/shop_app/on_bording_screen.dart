import 'package:flutter/material.dart';
import 'package:new_project1/shared/components/components.dart';
import 'package:new_project1/shared/network/shared.network.local/cache_helper.dart';
import 'package:new_project1/shared/style/colors.dart';
import 'package:new_project1/shop_app/login_screen/Login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel
{
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });

}
class OnBordingScreen extends StatefulWidget
{
  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  var boardController =PageController();

  List<BoardingModel> boarding =[
    BoardingModel(
      image: 'assets/images/onboarding1.jpg',
      title: 'On Board 1 Title',
      body: 'On Board 1 Body',
    ),
    BoardingModel(
      image: 'assets/images/onboarding1.jpg',
      title: 'On Board 2 Title',
      body: 'On Board 2 Body',
    ),
    BoardingModel(
      image: 'assets/images/onboarding1.jpg',
      title: 'On Board 3 Title',
      body: 'On Board 3 Body',
    ),
  ];
  bool isLast =false;

  void submit ()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true,).then((value) {
      if (value){
        navegateAndFinish(context, ShopLoginScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            text:'Skip' ,
            function:()=>submit (),
          ),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index)
                {
                  if (index==boarding.length-1)
                  {
                    setState(() {
                      isLast=true;
                    });
                    print('Last',);
                  }else
                  {
                    print('Not Last',);
                    setState(() {
                      isLast=false;
                    });
                  }
                },
                itemBuilder: (context,index)=>buildBoardingItem(boarding[index],),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller:boardController,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                    activeDotColor: defualtColor,
                  ),
                  count: boarding.length,),
                Spacer(),
                FloatingActionButton(
                    onPressed: ()
                    {

                      if(isLast)
                      {
                        submit ();
                      }else
                      {
                        boardController.nextPage(duration:
                        Duration(
                          milliseconds: 750,
                        ),
                          curve: Curves.fastLinearToSlowEaseIn,);
                      }
                    },
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                    )),
              ],
            ),
          ],
        ),
      ),
    );

  }

  Widget buildBoardingItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // PageView.builder(itemBuilder: (context,index)=>),
      Expanded(
        child: Image(
          image: AssetImage('${model.image}',
          ),
        ),
      ),
      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 15,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 15,
      ),


    ],
  );
}
