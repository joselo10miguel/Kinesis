import 'package:flutter/material.dart';
import 'package:kinesis/screens/details_paciente.dart';
import '../screens/screens.dart';
import '../estructuraPacientes.dart';
import '../ruta.dart';
import '../detailRutina.dart';

class AppRoutes {
  static const initialRoute = '/splash';
  static const routeLogin = '/login';
  static const routeMenu = '/menu';
  static const routePacientes = '/pacientes';
  static const routeDetailPacientes = '/detailPacientes';

  static Map<String, Widget Function(BuildContext)> routes = {
    '/splash': (BuildContext context) => const SplashScreen(),
    '/login': (BuildContext context) => const LoginScreen(),
    '/menu': (BuildContext context) => const HomeScreen(),
    '/pacientes': (BuildContext context) => PacientesScreen(),
    '/detailPacientes': (BuildContext context) {
      // Aquí debes obtener los datos necesarios para PacienteDetailScreen
      final Map<String, dynamic>? arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

      if (arguments != null) {
        return PacienteDetailScreen(
          nombre: arguments['nombre'] ?? 'Nombre no disponible',
          apellido: arguments['apellido'] ?? 'Apellido no disponible',
          edad: arguments['edad'] ?? 0,
          genero: arguments['genero'] ?? 'Género no disponible',
          correo: arguments['correo'] ?? 'correo',
          cedula: arguments['cedula'] ?? '00000',
          direccion: arguments['direccion'] ?? 'direccion',
          celular: arguments['celular'] ?? ' 00000',
          tipoLesion: arguments['tipoLesion'] ?? 'tipolesion',
          rutinasAsignadas: arguments['rutinasAsignadas'] ?? 0,
          rutinasRealizadas: arguments['rutinasRealizadas'] ?? 10,
          porcentajeAvance: arguments['porcentajeAvance'] ?? 0.00,
        );
      } else {
        // Manejar el caso cuando los argumentos son nulos
        return Scaffold(
          body: Center(
            child: Text('Error: Argumentos nulos para PacienteDetailScreen'),
          ),
        );
      }
    },
  };

  static Future<void> navigateToPacienteDetailById(
      BuildContext context, int pacienteId) async {
    print('Navigating to PacienteDetailScreen with Paciente ID: $pacienteId');
    try {
      final Paciente? paciente =
          await ApiService.getDetallesPacienteById(pacienteId);

      if (paciente != null) {
        // Obtener la información de las rutinas
        final List<Rutina> rutinas =
            await ApiService.getRutinasByPacienteId(pacienteId);

        // Contar las rutinas realizadas
        final int rutinasRealizadas =
            rutinas.where((rutina) => rutina.isCompleted ?? false).length;

        // Calcular el porcentaje de avance (solo como ejemplo)
        final double porcentajeAvance =
            (rutinasRealizadas / paciente.rutinasAsignadas) * 00;

        // ignore: use_build_context_synchronously
        Navigator.pushNamed(
          context,
          routeDetailPacientes,
          arguments: {
            'nombre': paciente.nombres,
            'apellido': paciente.apellidos,
            'edad': paciente.edad,
            'genero': paciente.genero,
            'correo': paciente.correo,
            'cedula': paciente.cedula,
            'direccion': paciente.direccion,
            'celular': paciente.celular,
            'tipoLesion': paciente.tipoLesion,
            'rutinasAsignadas': paciente.rutinasAsignadas,
            'rutinasRealizadas': rutinasRealizadas,
            'porcentajeAvance': porcentajeAvance
          },
        );
      } else {
        print('Error: No se encontró el paciente con ID $pacienteId');
      }
    } catch (e) {
      print('Error navigating to PacienteDetailScreen: $e');
    }
  }
}
