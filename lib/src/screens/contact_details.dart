import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jvec_assessment_frontend/src/config/router_config.dart';
import 'package:jvec_assessment_frontend/src/constants/color.dart';
import 'package:jvec_assessment_frontend/src/controller/contact_details_controller.dart';
import 'package:jvec_assessment_frontend/src/reusables/button.dart';
import 'package:jvec_assessment_frontend/src/reusables/custom_text.dart';
import 'package:jvec_assessment_frontend/src/reusables/dimension.dart';
import 'package:jvec_assessment_frontend/src/reusables/textfield.dart';
import 'package:provider/provider.dart';

class ContactDetails extends StatefulWidget {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;

  const ContactDetails({Key? key, required this.firstName, required this.lastName,  required this.id, required this.phone})
      : super(key: key);

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {

  @override
  void initState() {
    super.initState();
    print('${widget.firstName}, ${widget.lastName}, ${widget.phone}, ${widget.id}');
    context.read<ContactDetailsController>().firstNameController.text = widget.firstName;
    context.read<ContactDetailsController>().lastNameController.text = widget.lastName;
    context.read<ContactDetailsController>().phoneController.text = widget.phone;
    context.read<ContactDetailsController>().contactID = widget.id;
    context.read<ContactDetailsController>().isLoadingSave = false;
    context.read<ContactDetailsController>().isLoadingDelete= false;
    context.read<ContactDetailsController>().isEditMode= false;
    print(context.read<ContactDetailsController>().isLoadingSave );
    print(context.read<ContactDetailsController>().isEditMode );
  }
  @override
  Widget build(BuildContext context) {
    final contactDetailsController = context.watch<ContactDetailsController>();
    final contactDetailsControllerRead = context.read<ContactDetailsController>();

    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColor.bgColor,
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: mediaQuery.width,
            height: mediaQuery.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  50.verticalSpace,
                  const Icon(
                    Icons.person,
                    size: 100.0,
                    color: MyColor.appColor,
                  ),
                  20.verticalSpace,
                  contactDetailsController.isEditMode
                      ? CustomTextField(headerText: 'First Name', controller: contactDetailsControllerRead.firstNameController,)
                      : CustomText(
                    requiredText: contactDetailsController.firstNameController.text,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                  20.verticalSpace,
                  contactDetailsController.isEditMode
                      ? CustomTextField(headerText: 'Last Name', controller: contactDetailsControllerRead.lastNameController,)
                      : CustomText(
                    requiredText: contactDetailsController.lastNameController.text,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                  10.verticalSpace,
                  contactDetailsController.isEditMode
                      ? CustomTextField(headerText: 'phone', controller: contactDetailsControllerRead.phoneController,)
                      : CustomText(
                    requiredText: contactDetailsController.phoneController.text,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: mediaQuery.width * 0.4,
                        child: ButtonWidget(buttonText: !contactDetailsController.isEditMode ? 'Edit' : 'Save', fontSize: MyDimension.dim16,
                          textColor: Colors.white,
                          buttonColor: MyColor.appColor,
                          onPressed: () {
                            if (!contactDetailsController.isEditMode) {
                              contactDetailsControllerRead.toggleEditMode();
                            }else{
                              contactDetailsControllerRead.updateContactData();
                              contactDetailsControllerRead.updateContact(context, widget.id);
                            }
                          },
                          isLoading: contactDetailsController.isLoadingSave,),
                      ),
                      10.horizontalSpace,
                      SizedBox(
                        width: mediaQuery.width * 0.4,
                        child: ButtonWidget(buttonText: 'Delete', fontSize: MyDimension.dim16,
                          textColor: Colors.white,
                          buttonColor: MyColor.appColor,
                          onPressed: (){
                          contactDetailsControllerRead.deleteContact(context);
                          },
                          isLoading: contactDetailsController.isLoadingDelete,),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(alignment: const Alignment(-0.8, -0.8),
          child: GestureDetector(
            onTap: () => routerConfig.pop(),
              child: const Icon(CupertinoIcons.left_chevron, size: 30,)), )
        ],
      ),
    );
  }
}
