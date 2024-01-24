import 'package:kinesis/providers/nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Navegacion extends StatelessWidget {
  const Navegacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavProvider>(context);

    final indexActual = navProvider.opcionSeleccionada;

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: BottomNavigationBar(
        onTap: (int i) => navProvider.opcionSeleccionada = i,
        currentIndex: indexActual,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.home, indexActual, 0),
            label: 'Dahsboard',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.person, indexActual, 1),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.settings, indexActual, 2),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon, int selectedIndex, int itemIndex) {
    return Icon(
      icon,
      color: selectedIndex == itemIndex
          ? Color.fromARGB(255, 57, 116, 255)
          : Colors.black,
      size: selectedIndex == itemIndex
          ? 30.0
          : 24.0, // Cambia el tamaño cuando se selecciona
    );
  }
}
