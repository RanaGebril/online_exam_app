import 'package:flutter/material.dart';


class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth= MediaQuery.of(context).size.width;
    final double screenHigh= MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("Reset password")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  SizedBox(height: screenHigh*0.1,),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Current password",
                      hintText: " Current password",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: screenHigh*0.06,),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "New password",
                      hintText: "New password",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: screenHigh*0.06,),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Confirm password",
                      hintText: "Confirm password",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),

    );
  }
}
