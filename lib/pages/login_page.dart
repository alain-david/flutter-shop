import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../share_prefs/preferencias_usuario.dart';
import '../theme/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final prefs = PreferenciasUsuario();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          left: 60,
          top: 110,
          child: Icon(
            Icons.shopify,
            size: 250,
            color: (appTheme.darktheme) ? null : Colors.blue,
          ),
        ),
        SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SafeArea(child: Container(height: 270)),
                Container(
                  color: (appTheme.darktheme)
                      ? const Color.fromRGBO(31, 40, 68, 1)
                      : Colors.white,
                  width: size.width * 0.85,
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Column(
                    children: [
                      _nombre(),
                      const SizedBox(height: 30),
                      _password(),
                      const SizedBox(height: 60),
                      _botton(context),
                    ],
                  ),
                ),
                const Text(
                  'Si no tienes una cuenta',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Solicítala al +5356565616',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  TextFormField _nombre() {
    return TextFormField(
      keyboardType: TextInputType.number,
      initialValue: '',
      decoration: const InputDecoration(
        icon: Icon(Icons.people_alt),
        labelText: 'Usuario o Teléfono',
      ),
      onSaved: (value) => prefs.telefono = value!,
      validator: (value) {
        if (value != '56565616') {
          return 'Ingrese un número valido';
        } else {
          return null;
        }
      },
    );
  }

  TextFormField _password() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
        icon: Icon(Icons.lock_outline_rounded),
        labelText: 'Contraseña',
      ),
      validator: (value) {
        if (value != '56565616') {
          return 'La contraseña es incorrecta';
        } else {
          return null;
        }
      },
    );
  }

  ElevatedButton _botton(context) {
    return ElevatedButton(
      onPressed: _acceder,
      child: const Text(
        'Acceder',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  _acceder() {
    if (!formKey.currentState!.validate()) return;

    formKey.currentState?.save();
    setState(() {});

    prefs.telefono = '56565616';
    prefs.nombre = 'Alain David Puga Rondón';
    prefs.direccion = 'Calle 19 de Noviembre #8, Reparto progreso';

    Navigator.pushReplacementNamed(context, 'home');
  }
}
