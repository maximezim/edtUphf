import 'package:edt/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:edt/config/config.dart';
import 'package:edt/data/web/session.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      final result = await authUser(LoginData(
        name: _usernameController.text,
        password: _passwordController.text,
      ));
      if (result != null) {
        showSnackBar(result);
        _passwordController.clear();
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => Menu(
            isconnected: Storage.connected,
            title:
                '${DateTime.now().day} ${Mois.mois[DateTime.now().month - 1]}',
            username: Storage.id,
            password: Storage.password,
          ),
        ));
      }
      setState(() => _isLoading = false);
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<String?> authUser(LoginData data) async {
    try {
      if (!await Session.instance.isLog(data.name, data.password)) {
        return "Identifiant ou mot de passe incorrect";
      }
      Storage.storeLogin(data.name, data.password);
      Storage.setConnected(true);
      return null;
    } catch (e) {
      return e.toString().replaceAll("Exception: ", "");
    }
  }

  _launchURL() async {
    final Uri url = Uri.parse('https://sesame.uphf.fr/identifiants.html');
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'lib/screens/UPHF_logo.png', // Path to your logo image
                  width: 100, // Width of the logo
                  height: 100, // Height of the logo
                  fit: BoxFit.contain, // Use this to prevent image distortion
                ),
                const SizedBox(height: 48),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Please enter your username'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Please enter your password'
                      : null,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Connexion'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _launchURL,
                  child: const Text('Mot de passe oublié?'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
