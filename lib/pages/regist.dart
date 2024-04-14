import 'package:flutter/material.dart';
import 'package:srs5/service/shared_preference.dart';
import 'bottom_bar.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextFieldWithIcon(
              controller: nameController,
              labelText: 'Login',
              icon: Icons.person,
            ),
            SizedBox(height: 20),
            _buildTextFieldWithIcon(
              controller: emailController,
              labelText: 'Email',
              icon: Icons.email,
            ),
            SizedBox(height: 20),
            _buildTextFieldWithIcon(
              controller: phoneNumberController,
              labelText: 'Phone Number',
              icon: Icons.phone,
            ),
            SizedBox(height: 20),
            _buildTextFieldWithIcon(
              controller: passwordController,
              labelText: 'Password',
              icon: Icons.lock,
              isPassword: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                SharedPreferenceHelper.setAuthenticated(true);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomBarPage(
                      // Pass user data to BottomBarPage
                      name: nameController.text,
                      email: emailController.text,
                      phoneNumber: phoneNumberController.text,
                    ),
                  ),
                  (route) => false, // Remove all routes except the new one
                );
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldWithIcon({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // Устанавливаем цвет границы
        borderRadius: BorderRadius.circular(5), // Устанавливаем скругление углов
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icon),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: labelText,
                hintText: 'Enter your $labelText',
                border: InputBorder.none, // Убираем границы внутри текстового поля
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15), // Устанавливаем отступы
              ),
              obscureText: isPassword && !_isPasswordVisible,
            ),
          ),
          if (isPassword)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}
