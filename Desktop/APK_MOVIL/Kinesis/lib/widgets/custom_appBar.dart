import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/nav_provider.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavProvider>(context);
    final indexSeleccionado = navProvider.opcionSeleccionada;

    if (indexSeleccionado == 1) {
      final size = MediaQuery.of(context).size;
      return Row(
        children: [
          const Image(image: AssetImage('assets/logo.png'), height: 60),
          SizedBox(
            width: size.width * 0.15,
          ),
          Text("Administracion | ",
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'Inter',
                  fontSize: 22)),
          FloatingActionButton(
            heroTag: 'button_avatar',
            backgroundColor: const Color.fromARGB(33, 255, 255, 255),
            elevation: 0.8,
            mini: true,
            onPressed: () {
              Navigator.pushNamed(context, '/perfil_m');
            },
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://as2.ftcdn.net/v2/jpg/06/04/91/89/1000_F_604918971_lwXHZ65UVUXWaHUgC2nBClTY5jcUini3.jpg'),
            ),
          ),
        ],
      );
    } else if (indexSeleccionado == 2) {
      return const Row(
        children: [
          Image(
              image: AssetImage('assets/logo.png'),
              fit: BoxFit.cover,
              height: 60),
          SizedBox(
            width: 20,
          ),
          Text('Perfil',
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'Inter',
                  fontSize: 22))
        ],
      );
    } else {
      final size = MediaQuery.of(context).size;
      return Row(
        children: [
          const Image(image: AssetImage('assets/logo.png'), height: 60),
          SizedBox(
            width: size.width * 0.30,
          ),
          const Text("Pacientes | ",
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'Inter',
                  fontSize: 22)),
          FloatingActionButton(
            heroTag: 'button_avatar',
            backgroundColor: const Color.fromARGB(33, 255, 255, 255),
            elevation: 0.8,
            mini: true,
            onPressed: () {
              Navigator.pushNamed(context, '/perfil_m');
            },
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://as2.ftcdn.net/v2/jpg/06/04/91/89/1000_F_604918971_lwXHZ65UVUXWaHUgC2nBClTY5jcUini3.jpg'),
            ),
          ),
        ],
      );
    }
  }
}

class ButtonHeadSocial extends StatelessWidget {
  final IconData icono;

  const ButtonHeadSocial({
    Key? key,
    required this.icono,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 40,
      decoration: const ShapeDecoration(
        color: Color.fromARGB(218, 186, 184, 184),
        shape: CircleBorder(),
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(icono, color: Color.fromARGB(255, 0, 0, 0)),
        splashRadius: 25,
      ),
    );
  }
}
