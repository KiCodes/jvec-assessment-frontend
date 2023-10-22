import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jvec_assessment_frontend/src/config/router_config.dart';
import 'package:jvec_assessment_frontend/src/constants/assets.dart';
import 'package:jvec_assessment_frontend/src/constants/color.dart';
import 'package:jvec_assessment_frontend/src/constants/routes_path.dart';
import 'package:jvec_assessment_frontend/src/controller/home_controller.dart';
import 'package:jvec_assessment_frontend/src/screens/alphabet_list_view.dart';
import 'package:jvec_assessment_frontend/src/reusables/custom_focus_background.dart';
import 'package:jvec_assessment_frontend/src/reusables/custom_text.dart';
import 'package:jvec_assessment_frontend/src/reusables/dimension.dart';
import 'package:jvec_assessment_frontend/src/screens/left_drawer.dart';
import 'package:jvec_assessment_frontend/src/reusables/loading_widget.dart';
import 'package:jvec_assessment_frontend/src/reusables/search_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
    context.read<HomeController>().convertDynamicDataToContactList(context);
  }


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final homeController = context.watch<HomeController>();
    final homeControllerRead = context.read<HomeController>();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: MyColor.bgColor,
      body: ListView.builder(
        itemBuilder: (context, snapshot) {
          if (!homeController.hasLoaded) {
            return _buildLoadingUI(mediaQuery);
          } else {
            return SingleChildScrollView(
              child: Container(
                width: mediaQuery.width,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Column(
                  children: [
                    //contact
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //menu
                        Builder(
                            builder: (context) {
                              return GestureDetector(
                                onTap: ()=> Scaffold.of(context).openDrawer(),
                                child: Container(
                                    decoration: ShapeDecoration(
                                      shape: const CircleBorder(),
                                      color: Colors.white,
                                      shadows: [
                                        buildBoxShadow(),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        Asset.fourDots,
                                        width: 25,
                                        color: MyColor.textColor.withOpacity(0.8),
                                      ),
                                    )),
                              );
                            }
                        ),
                        CustomText(
                          requiredText: 'Contact',
                          fontSize: MyDimension.dim35,
                          color: MyColor.textColor.withOpacity(0.8),
                          fontWeight: FontWeight.bold,
                        ),
                        //plus
                        GestureDetector(
                          onTap: (){
                            routerConfig.push(RoutesPath.addContactsScreen);
                          },
                          child: Container(
                            decoration: ShapeDecoration(
                              shape: const CircleBorder(
                                  side: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  )),
                              color: Colors.white,
                              shadows: [
                                buildBoxShadow(),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                CupertinoIcons.plus,
                                size: 25,
                                weight: 50.0,
                                color: MyColor.textColor.withOpacity(0.8),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    10.verticalSpace,
                    //search
                    Container(
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    30.verticalSpace,
                    AlphabetListView(items: homeControllerRead.items),
                  ],
                ),
              ),
            );
          }
        },
      ),
      drawer: const LeftDrawerWidget(),
    );
  }
  Widget _buildLoadingUI(Size mediaQuery) {
    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomFocusBackground(mediaQuery: mediaQuery),
          const Align(
              alignment: Alignment(0, 0), child: LoadingWidget(color: Colors.white, size: 70,)),
        ],
      ),
    );
  }

  Widget _buildErrorUI(Size mediaQuery, String error) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            // Your error content
          ),
        ),
        Align(
          alignment: const Alignment(0, 0),
          child: Text('Error: $error'),
        ),
      ],
    );
  }

  BoxShadow buildBoxShadow() {
    return BoxShadow(
      color: Colors.grey.withOpacity(0.5), // Shadow color
      offset: const Offset(0, 3), // Offset (x, y)
      blurRadius: 4, // Blur radius
      spreadRadius: 1, // Spread radius
    );
  }
}
