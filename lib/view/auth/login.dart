import 'package:abdulla_nasar/controller/auth_controller.dart';
import 'package:abdulla_nasar/utils/hex_colors.dart';
import 'package:abdulla_nasar/utils/reusable_widget.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer<AuthController>(
          builder: (context, authCtrl, child) {
            return Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      kHeight(150),
                      text(
                        giveText: "ChargeMOD",
                        fontsize: 16,
                        textColor: theme.textTheme.bodyLarge!.color!,
                      ),
                      text(
                          giveText: "Let’s Start",
                          fontsize: 40,
                          textColor: theme.textTheme.bodyLarge!.color!,
                          fontweight: FontWeight.w700),
                      text(
                          giveText: "From login",
                          fontsize: 40,
                          textColor: HexColor("E6740C"),
                          fontweight: FontWeight.w700),
                      kHeight(50),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                showPhoneCode: true,
                                onSelect: (Country country) {
                                  Provider.of<AuthController>(context,
                                          listen: false)
                                      .setSelectedCountryCode(
                                          country.phoneCode);
                                },
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: theme.focusColor,
                                border: Border.all(color: HexColor("E4DFDF")),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.asset(
                                      'assets/images/india.webp',
                                      height: 35,
                                      width: 35,
                                    ),
                                  ),
                                  Icon(
                                    Icons.expand_more,
                                    color: theme.scaffoldBackgroundColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                          kWidth(20),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              style: textStyle(
                                  textColor: theme.textTheme.bodyMedium!.color),
                              controller: authCtrl.phoneNumberController,
                              decoration: InputDecoration(
                                fillColor: theme.focusColor,
                                filled: true,
                                prefixIcon: Image.asset(
                                  "assets/images/call.png",
                                ),
                                contentPadding: const EdgeInsets.all(5),
                                hintText: 'Phone Number',
                                hintStyle: textStyle(
                                    textColor:
                                        theme.textTheme.bodyMedium!.color),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: HexColor("E4DFDF")),
                                ),
                                enabled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: HexColor("E4DFDF"),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      kHeight(16),
                      RawMaterialButton(
                        onPressed: () async {
                          await authCtrl.login(context);
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
                              giveText: "Sent OTP",
                              fontsize: 16,
                              textColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RichText(
                    text: TextSpan(
                      text: '       By continuing you agree to our\n',
                      style: TextStyle(
                          fontFamily: "Poppins",
                          color: theme.textTheme.bodyLarge!.color),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Terms & Conditions',
                          style: TextStyle(
                              color: HexColor("E6740C"), fontFamily: "Poppins"),
                        ),
                        const TextSpan(
                          text: ' and ',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                              color: HexColor("E6740C"), fontFamily: "Poppins"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
