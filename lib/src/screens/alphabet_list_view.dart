import 'package:azlistview/azlistview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jvec_assessment_frontend/src/config/router_config.dart';
import 'package:jvec_assessment_frontend/src/constants/color.dart';
import 'package:jvec_assessment_frontend/src/constants/routes_path.dart';
import 'package:jvec_assessment_frontend/src/controller/home_controller.dart';
import 'package:jvec_assessment_frontend/src/reusables/custom_text.dart';
import 'package:provider/provider.dart';

class ContactList extends ISuspensionBean{
  final String title;
  final String tag;

  ContactList(this.title, this.tag);

  @override
  String getSuspensionTag() => tag;
}

class AlphabetListView extends StatefulWidget {
  List<ContactList> items;
  AlphabetListView({super.key, required this.items});

  @override
  State<AlphabetListView> createState() => _AlphabetListViewState();
}

class _AlphabetListViewState extends State<AlphabetListView> {
  var characters = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
  ];

  @override
  void initState() {
    super.initState();
    initList(characters);
  }

  void initList(List<String> characters){
    characters.map((character) => ContactList(character, character[0])).toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final homeController = context.watch<HomeController>();

        return SizedBox(
          width: mediaQuery.width,
          height: mediaQuery.height * 0.7,
          child: AzListView(
              data: homeController.items,
              itemCount: homeController.items.length,
              indexBarOptions: const IndexBarOptions(
                  indexHintAlignment: Alignment.centerRight,
                  selectTextStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  selectItemDecoration: BoxDecoration(
                      shape: BoxShape.circle, color: MyColor.appColor, )),
              itemBuilder: (context, index) {
                String firstName = homeController.contacts[index]['firstName'];
                String lastName = homeController.contacts[index]['lastName'];
                String phone = '${homeController.contacts[index]['phoneNumber']} ';
                String id = '${homeController.contacts[index]['_id']} ';

                return homeController.items.isNotEmpty ? Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        routerConfig.push(RoutesPath.detailsScreen,
                          extra: {'id': id,'firstName': firstName,
                            'lastName': lastName, 'phone': phone}
                        );
                      },
                      child: Container(
                        width: mediaQuery.width,
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                            boxShadow: [
                              buildBoxShadow()
                            ]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      fit: FlexFit.loose,
                                      child: CustomText(requiredText: '$firstName $lastName', fontSize: 18, color: MyColor.textColor,
                                        fontWeight: FontWeight.bold, textAlign: TextAlign.left,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,

                                      ),
                                    ),
                                    5.verticalSpace,
                                    Flexible(
                                      fit: FlexFit.loose,
                                      child: CustomText(requiredText:
                                      phone, fontSize: 15, color: MyColor.textColor,
                                        fontWeight: FontWeight.w300, textAlign: TextAlign.left,

                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(CupertinoIcons.right_chevron),

                            ],
                          ),
                        ),
                      ),
                    ),
                    20.verticalSpace
                  ],
                ) : Container();
              }),
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
