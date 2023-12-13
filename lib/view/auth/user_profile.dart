import 'package:abdulla_nasar/controller/user_profile_controller.dart';
import 'package:abdulla_nasar/utils/hex_colors.dart';
import 'package:abdulla_nasar/utils/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: text(
            giveText: 'Update Profile',
            fontsize: 16,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Consumer<UserProfileController>(
            builder: (context, upCtrl, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFormField(
                        labelText: "First Name",
                        hintText: "Eg: John",
                        controller: upCtrl.firstNameController,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z]')),
                        ],
                        keyboardType: TextInputType.name,
                      ),
                      kHeight(15),
                      CustomFormField(
                        labelText: "Last Name",
                        hintText: "Eg: Smith",
                        controller: upCtrl.lastNameController,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z]')),
                        ],
                        keyboardType: TextInputType.name,
                      ),
                      kHeight(15),
                      CustomFormField(
                        labelText: "E-mail",
                        hintText: "Eg: example@mail.com",
                        controller: upCtrl.emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      kHeight(15),
                      text(
                        giveText: "Phone Number",
                        fontsize: 12,
                        fontweight: FontWeight.w700,
                      ),
                      kHeight(10),
                      text(giveText: phoneNumber)
                    ],
                  ),
                  Column(
                    children: [
                      text(giveText: "Completing Your Profile", fontsize: 12),
                      kHeight(10),
                      text(
                        giveText:
                            "This action will reflect in your activities and payments after saving. we ask\nfor email details for recieving monthly activity and notifications.",
                        fontsize: 8,
                        maxLine: 2,
                        textColor: HexColor("666766"),
                      ),
                      kHeight(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: RawMaterialButton(
                          onPressed: () async {
                            await upCtrl.registerUser(context, phoneNumber);
                          },
                          child: Container(
                            width: double.infinity,
                            height: 38,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: HexColor("E6740C"),
                            ),
                            child: Center(
                              child: text(
                                giveText: "Save Changes",
                                fontsize: 12,
                                textColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ));
  }
}
