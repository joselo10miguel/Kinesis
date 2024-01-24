import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../detailRutina.dart';

class PacienteDetailScreen extends StatelessWidget {
  final String nombre;
  final String apellido;
  final int edad;
  final String genero;
  final String correo;
  final String cedula;
  final String direccion;
  final String celular;
  final String tipoLesion;
  final int rutinasAsignadas;
  final int rutinasRealizadas;
  final double porcentajeAvance;

  PacienteDetailScreen({
    required this.nombre,
    required this.apellido,
    required this.edad,
    required this.genero,
    required this.correo,
    required this.cedula,
    required this.direccion,
    required this.celular,
    required this.tipoLesion,
    required this.rutinasAsignadas,
    required this.rutinasRealizadas,
    required this.porcentajeAvance,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Paciente'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Primera tarjeta con información y rutinas
              Card(
                elevation: 5,
                margin: EdgeInsets.all(16),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Datos del Paciente: $nombre',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      ListTile(
                        leading: Icon(Icons.person, color: Colors.blue),
                        title: Text('Nombre: $nombre $apellido'),
                      ),
                      ListTile(
                        leading: Icon(Icons.cake, color: Colors.blue),
                        title: Text('Edad: $edad'.toString()),
                      ),
                      ListTile(
                        leading: Icon(Icons.people, color: Colors.blue),
                        title: Text('Género: $genero'),
                      ),

                      ListTile(
                        leading: Icon(Icons.location_on, color: Colors.blue),
                        title: Text('Dirección: $direccion'),
                      ),
                      ListTile(
                        leading: Icon(Icons.phone, color: Colors.blue),
                        title: Text('Celular: $celular'),
                      ),
                      ListTile(
                        leading: Icon(Icons.favorite, color: Colors.blue),
                        title: Text('Tipo de Lesión: $tipoLesion'),
                      ),

                      // Mostrar información de las rutinas
                    ],
                  ),
                ),
              ),

              // Segunda tarjeta con gráfico de pastel

              Card(
                elevation: 5,
                margin: EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Progreso de Rutinas',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 1.3,
                        child: PieChart(
                          PieChartData(
                            sections: [
                              PieChartSectionData(
                                color: Colors.red,
                                value: rutinasAsignadas.toDouble(),
                                title: '$rutinasAsignadas',
                                radius: 60,
                                showTitle: false,
                                badgeWidget: Text(
                                  '$rutinasAsignadas',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              PieChartSectionData(
                                color: Colors.blue,
                                value: rutinasRealizadas.toDouble(),
                                title: '$rutinasRealizadas',
                                radius: 60,
                                showTitle: false,
                                badgeWidget: Text(
                                  '$rutinasRealizadas',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                            sectionsSpace: 0,
                            centerSpaceRadius: 40,
                            borderData: FlBorderData(
                              show: false,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            color: Colors.red,
                            width: 15,
                            height: 15,
                          ),
                          SizedBox(width: 5),
                          Text('Rutinas Asignadas'),
                          SizedBox(width: 20),
                          Container(
                            color: Colors.blue,
                            width: 15,
                            height: 15,
                          ),
                          SizedBox(width: 5),
                          Text('Rutinas Realizadas'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Porcentaje de Avance: $porcentajeAvance%',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
