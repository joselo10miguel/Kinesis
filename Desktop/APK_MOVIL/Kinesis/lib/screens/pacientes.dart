import 'package:kinesis/models/lista.dart';
import 'package:kinesis/widgets/custom_dashboard_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../estructuraPacientes.dart';
import '../ruta.dart';
import '../routes/app_routes.dart';

class PacientesScreen extends StatelessWidget {
  PacientesScreen({Key? key}) : super(key: key);

  final List<Color> colores = [
    Color.fromARGB(255, 178, 204, 235),
    Color.fromARGB(255, 215, 230, 236),
    Color.fromARGB(255, 185, 197, 220),

    // Agrega más colores según sea necesario
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FutureBuilder<List<Paciente>>(
      future: ApiService.getPacientes(TokenManager.token ?? ''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Error al obtener pacientes: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final pacientes = snapshot.data!;
          return buildPacientesScreenWithDatos(context, size, pacientes);
        } else {
          return Center(child: Text('No se encontró la lista de pacientes.'));
        }
      },
    );
  }

  Widget buildPacientesScreenWithDatos(
      BuildContext context, Size size, List<Paciente> pacientes) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: pacientes.length,
              itemBuilder: (context, index) {
                final paciente = pacientes[index];
                final color = colores[index % colores.length];

                return Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: color,
                  ),
                  child: Container(
                    width: size.width * 0.5,
                    height: 100,
                    padding: const EdgeInsets.all(5),
                    child: CustomEntrenamientoButton(
                      titleCard: '${paciente.nombres} ${paciente.apellidos}',
                      colorCarta: color,
                      estado: paciente.rutinasAsignadas > 0
                          ? 'En Progreso'
                          : 'Sin Rutinas',
                      onPressed: () {
                        // Navegar a la pantalla de detalles pasando el paciente
                        if (paciente != null) {
                          AppRoutes.navigateToPacienteDetailById(
                              context, paciente.id);
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
