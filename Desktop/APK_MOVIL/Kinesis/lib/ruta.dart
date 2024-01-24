import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kinesis/routes/app_routes.dart';
import 'doctor.dart';
import 'detailRutina.dart';
import 'estructuraPacientes.dart';

class ApiService {
  static const String _baseUrl = 'https://kinesis.onrender.com';

  static Future<String?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/api-token-auth/'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final token = data['token'];
        TokenManager.setToken(token);
        return token;
      } else {
        print('Error al iniciar sesión: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error en login: $e');
      return null;
    }
  }

  static Future<void> fetchData(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/api/doctores/'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        // Procesa los datos según sea necesario
        print('Datos obtenidos: $data');
      } else {
        print('Error al obtener datos: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en fetchData: $e');
    }
  }

  static Future<Doctor?> getDoctorProfile(String token) async {
    try {
      print('Token enviado : $token');
      final response = await http.get(
        Uri.parse('https://kinesis.onrender.com/api/doctores/'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          return Doctor.fromJson(data[0]);
        } else {
          print('Error: No se encontraron datos del doctor.');
          return null;
        }
      } else {
        print('Error al obtener datos del doctor: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error en getDoctorProfile: $e');
      return null;
    }
  }

  static Future<int> getTotalPacientes(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/api/pacientes/'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.length;
      } else {
        print('Error al obtener pacientes: ${response.statusCode}');
        return 0;
      }
    } catch (e) {
      print('Error en getTotalPacientes: $e');
      return 0;
    }
  }

  static Future<Map<String, double>> getPorcentajeGenero(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/api/pacientes/'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final total = data.length.toDouble();
        final hombres = data
            .where((paciente) => paciente['genero'] == 'Masculino')
            .length
            .toDouble();
        final mujeres = total - hombres;

        return {
          'hombres': hombres / total * 100,
          'mujeres': mujeres / total * 100,
        };
      } else {
        print('Error al obtener pacientes: ${response.statusCode}');
        return {'hombres': 0, 'mujeres': 0};
      }
    } catch (e) {
      print('Error en getPorcentajeGenero: $e');
      return {'hombres': 0, 'mujeres': 0};
    }
  }

  static Future<List<Paciente>> getPacientes(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/api/pacientes/'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Paciente.fromJson(json)).toList();
      } else {
        print('Error al obtener pacientes: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error en getPacientes: $e');
      return [];
    }
  }

  static Future<Paciente?> getDetallesPacienteById(int pacienteId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/api/pacientes/$pacienteId/'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Token ${TokenManager.token}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return Paciente.fromJson(data);
      } else {
        print('Error al obtener detalles del paciente: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error en getDetallesPacienteById: $e');
      return null;
    }
  }

  static Future<List<Rutina>> getRutinasInfo(int pacienteId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/api/rutinas/?paciente=$pacienteId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Token ${TokenManager.token}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> rutinasData = jsonDecode(response.body);

        List<Rutina> rutinas =
            rutinasData.map((json) => Rutina.fromJson(json)).toList();

        return rutinas;
      } else {
        print('Error al obtener rutinas: ${response.statusCode}');
        throw Exception('Failed to load RutinasInfo');
      }
    } catch (e) {
      print('Error en getRutinasInfo: $e');
      throw Exception('Failed to load RutinasInfo');
    }
  }

  static Future<List<Rutina>> getRutinasByPacienteId(int pacienteId) async {
    final apiUrl = '$_baseUrl/api/rutinas/?paciente=$pacienteId';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Token ${TokenManager.token}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<Rutina> rutinas =
            data.map((json) => Rutina.fromJson(json)).toList();
        return rutinas;
      } else {
        print(
            'Error al obtener las rutinas. Código de estado: ${response.statusCode}');
        print('Mensaje de error: ${response.body}');
        throw Exception('Error al obtener las rutinas');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }
}

class TokenManager {
  static String? _token;

  static String? get token => _token;

  static void setToken(String? token) {
    _token = token;
  }
}
