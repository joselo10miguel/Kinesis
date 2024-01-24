import 'package:flutter/material.dart';
import '../ruta.dart';
import '../doctor.dart';

class PerfilScreen extends StatelessWidget {
  final String token;

  const PerfilScreen({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Doctor?>(
        future: ApiService.getDoctorProfile(token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error al obtener datos: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final doctor = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Tarjeta de Cabecera
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40.0,
                            // Puedes ajustar la lógica para cargar la imagen del doctor
                            backgroundImage: AssetImage('assets/logo.png'),
                          ),
                          SizedBox(width: 16.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ' ${doctor.nombre} ${doctor.apellido}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  // Tarjeta de Datos de Contacto
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Información de contacto
                        ListTile(
                          leading: Icon(Icons.mail),
                          title: Text('Correo electrónico'),
                          subtitle: Text(doctor.correo),
                        ),
                        ListTile(
                          leading: Icon(Icons.phone),
                          title: Text('Teléfono'),
                          subtitle: Text(doctor.celular),
                        ),

                        ListTile(
                          leading: Icon(Icons.cake),
                          title: Text('Edad'),
                          subtitle: Text(doctor.edad.toString()),
                        ),
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text('Género'),
                          subtitle: Text(doctor.genero),
                        ),
                        // Puedes agregar más ListTile según la información necesaria
                      ],
                    ),
                  ),

                  SizedBox(height: 16),

                  // Pie de página
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          // Navegar a la pantalla de inicio de sesión
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        label: const Text(
                          'Cerrar Sesión',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          } else {
            return Center(child: Text('No se encontraron datos del doctor.'));
          }
        },
      ),
    );
  }
}
