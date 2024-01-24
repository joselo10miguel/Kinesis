import 'package:kinesis/providers/nav_provider.dart';
import 'package:kinesis/screens/pacientes.dart';
import 'package:kinesis/screens/perfil.dart';
import 'package:kinesis/screens/screens.dart';
import 'package:kinesis/widgets/bottom_navigation.dart';
import 'package:kinesis/widgets/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ruta.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomAppBar(),
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: _ItemsNavigation(),
      bottomNavigationBar: const Navegacion(),
    );
  }
}

class _ItemsNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavProvider>(context);

    final indexSeleccionado = navProvider.opcionSeleccionada;
    final token = TokenManager.token;
    switch (indexSeleccionado) {
      case 0:
        return PacientesScreen();

      case 1:
        return SocialScreen();

      case 2:
        return PerfilScreen(token: token!);

      default:
        return PacientesScreen();
    }
  }
}
