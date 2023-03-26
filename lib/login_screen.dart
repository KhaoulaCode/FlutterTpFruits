import 'auth_form.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'userProvider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userEmail = userProvider.email;
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 40, 33, 243),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(userEmail),
          ElevatedButton(
            onPressed: () {
              userProvider.setId('');
              userProvider.setToken('');
              userProvider.setEmail('');
              userProvider.setIsLogin(false);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content:
                  Text('Utilisateur déconnecté'),
                  backgroundColor: Colors.grey,
                ),
              );

            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
 
 }
}