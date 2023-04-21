import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_login/screens/signup/controller/signup_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GenderWidget extends StatelessWidget {
  GenderWidget(
      {super.key,
      required this.signupController,
      required this.genderValidator});
  SignupController signupController;
  RxString genderValidator;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 43.0),
              child: Text(
                'Gender',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 43.0),
              child: Text(
                genderValidator.value,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.person_2_outlined, color: Colors.blue),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    signupController.genderType.value = 'Male';
                    print(signupController.genderType.value);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: signupController.genderType.value == 'Male'
                            ? Colors.blue
                            : Colors.grey.shade50,
                      ),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.height * 0.1,
                      height: MediaQuery.of(context).size.width * 0.2,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.male),
                            Text(
                              'Male',
                              style: TextStyle(
                                  color: signupController.genderType.value ==
                                          'Male'
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ]),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    signupController.genderType.value = 'Female';
                    print(signupController.genderType.value);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: signupController.genderType.value == 'Female'
                            ? Colors.blue
                            : Colors.grey.shade50,
                      ),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.height * 0.1,
                      height: MediaQuery.of(context).size.width * 0.2,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.female),
                            Text('Female',
                                style: TextStyle(
                                    color: signupController.genderType.value ==
                                            'Female'
                                        ? Colors.white
                                        : Colors.black)),
                          ]),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    signupController.genderType.value = 'Other';
                    print(signupController.genderType.value);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: signupController.genderType.value == 'Other'
                            ? Colors.blue
                            : Colors.grey.shade50,
                      ),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.height * 0.1,
                      height: MediaQuery.of(context).size.width * 0.2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const FaIcon(FontAwesomeIcons.transgender),
                          Text('Other',
                              style: TextStyle(
                                  color: signupController.genderType.value ==
                                          'Other'
                                      ? Colors.white
                                      : Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ));
  }
}
