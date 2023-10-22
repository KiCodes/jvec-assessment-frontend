import 'package:flutter/material.dart';
import 'package:jvec_assessment_frontend/src/constants/color.dart';
import 'package:jvec_assessment_frontend/src/controller/add_contact_controller.dart';
import 'package:jvec_assessment_frontend/src/reusables/button.dart';
import 'package:jvec_assessment_frontend/src/reusables/dimension.dart';
import 'package:jvec_assessment_frontend/src/reusables/textfield.dart';
import 'package:provider/provider.dart';

class AddContact extends StatelessWidget {
  const AddContact({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final addContactController = context.watch<AddContactController>();
    final addContactControlleRead = context.read<AddContactController>();

    return Scaffold(
      backgroundColor: MyColor.bgColor,
      body: Container(
        height: mediaQuery.height * 0.7,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Save Contact',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: MyColor.appColor),
            ),
            CustomTextField(headerText: 'First Name',
              controller: addContactControlleRead.firstNameController, keyboardType: TextInputType.text),
            CustomTextField(headerText: 'Last Name',
              controller: addContactControlleRead.lastNameController, keyboardType: TextInputType.text),
            CustomTextField(headerText: 'Phone',
            controller: addContactControlleRead.phoneNumberController, keyboardType: TextInputType.phone),
            ButtonWidget(buttonText: 'Save', fontSize: MyDimension.dim16,
            textColor: Colors.white,
            buttonColor: MyColor.appColor,
            onPressed:addContactController.isLoading ? null : () => addContactControlleRead.addContact(context),
              isLoading: addContactController.isLoading,),
          ],
        ),
      ),
    );
  }
}