import 'package:flutter/material.dart';
import '../../../../config/di/di.dart';
import '../../../../config/routes_manager/app_routes.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/di/di.dart';
import '../../../auth/data/models.dart';

import '../../data/datasources/user_local_storage.dart';
import '../../data/models/user_profile_model.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import 'addphoto/image_picker_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool enable = false;
  late TextEditingController usernameController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  void _updateProfile() async {
    final updateUseCase = sl<UpdateUserUseCase>();
    try {
      final updatedUser = await updateUseCase(
        username: usernameController.text.trim(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
      );

      final profile = UserProfileModel.fromUserModel(updatedUser as UserModel);
      await UserLocalStorage.saveUser(profile);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Profile updated successfully ✅")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Update failed: $e")),
      );
    }
  }
  @override
  void initState() {
    super.initState();
    final user = UserLocalStorage.getUser();
    usernameController = TextEditingController(text: user?.username ?? "");
    firstNameController = TextEditingController(text: user?.firstName ?? "");
    lastNameController = TextEditingController(text: user?.lastName ?? "");
    emailController = TextEditingController(text: user?.email ?? "");
    phoneController = TextEditingController(text: user?.phone ?? "");
  }

  @override
  Widget build(BuildContext context) {
    final user = UserLocalStorage.getUser();


    void _updateProfile() async {
      final updatedUser = UserProfileModel(
        username: usernameController.text.trim(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
      );

      await UserLocalStorage.saveUser(updatedUser);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Profile updated successfully ✅")),
      );
    }
    final double screenWidth= MediaQuery.of(context).size.width;
    final double screenHigh= MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Profile")),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    ImagePickerWidget(),
                    SizedBox(height: screenHigh*0.1,),
                    TextField(
                      enabled: enable,
                      decoration: InputDecoration(
                        labelText: "User name",
                        hintText: "${user?.username} ",
                        hintStyle: TextStyle(color: AppColors.black[100]),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: screenHigh*0.06,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child:
                            TextField(
                              enabled: enable,
                              decoration: InputDecoration(
                                labelText: "First Name",
                                hintText: "${user?.firstName}",
                                hintStyle: TextStyle(color: AppColors.black[100]),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                border: OutlineInputBorder(),
                              ),
                            ),
                        ),
                        SizedBox(width: screenWidth*0.05,),
                        Expanded(
                          child:
                          TextField(
                            enabled: enable,
                            decoration: InputDecoration(
                              labelText: "Last name",
                              hintText: "${user?.lastName}",
                              hintStyle: TextStyle(color: AppColors.black[100]),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: screenHigh*0.06,),
                    TextField(
                      enabled: enable,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: " ${user?.email}",
                        hintStyle: TextStyle(color: AppColors.black[100]),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: screenHigh*0.06,),
                    TextField(
                      enabled: enable,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "x x x x x x x ",
                        hintStyle: TextStyle(color: AppColors.black[100]),
                        suffix: GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, AppRoutes.resetpassword);
                          },
                          child: Text("Change",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff02369C),
                          ),),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: screenHigh*0.06,),
                    TextField(
                      enabled: enable,
                      decoration: InputDecoration(
                        labelText: "Phone number",
                        hintText: "${user?.phone}",
                        hintStyle: TextStyle(color: AppColors.black[100]),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: screenHigh*0.1,),
                    SizedBox(
                      width: double.infinity,
                      height: screenHigh*0.14,
                      child: ElevatedButton(onPressed: (){
                        setState(() {
                          enable=!enable;
                          _updateProfile;
                        });
                      },
                          child: Text("Update")
                      ),
                    ),
                    SizedBox(height: screenHigh*0.1,),
                    ElevatedButton(
                      onPressed: () async {
                        await UserLocalStorage.clearUser();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.login,
                              (route) => false,
                        );
                      },
                      child: Text("Logout"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
