import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../ruta.dart';

class SocialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: ApiService.getTotalPacientes(TokenManager.token ?? ''),
      builder: (context, totalPacientesSnapshot) {
        if (totalPacientesSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (totalPacientesSnapshot.hasError) {
          return Center(
              child: Text(
                  'Error al obtener pacientes: ${totalPacientesSnapshot.error}'));
        } else if (totalPacientesSnapshot.hasData) {
          final totalPacientes = totalPacientesSnapshot.data!;
          return FutureBuilder<Map<String, double>>(
            future: ApiService.getPorcentajeGenero(TokenManager.token ?? ''),
            builder: (context, porcentajeGeneroSnapshot) {
              if (porcentajeGeneroSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (porcentajeGeneroSnapshot.hasError) {
                return Center(
                    child: Text(
                        'Error al obtener porcentaje de género: ${porcentajeGeneroSnapshot.error}'));
              } else if (porcentajeGeneroSnapshot.hasData) {
                final porcentajeGenero = porcentajeGeneroSnapshot.data!;
                return buildSocialScreenWithDatos(
                    totalPacientes, porcentajeGenero);
              } else {
                return Center(
                    child: Text('No se pudo obtener el porcentaje de género.'));
              }
            },
          );
        } else {
          return Center(child: Text('No se encontró el total de pacientes.'));
        }
      },
    );
  }

  Widget buildSocialScreenWithDatos(
      int totalPacientes, Map<String, double> porcentajeGenero) {
    return ListView(
      children: <Widget>[
        // ... otros widgets

        Card(
          elevation: 5,
          margin: EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Total de Pacientes',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 230,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      totalPacientes.toString(),
                      style: TextStyle(
                        color: Color.fromARGB(255, 81, 81, 81),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        Card(
          elevation: 5,
          margin: EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Pacientes por sexo',
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
                          color: Colors.blue,
                          value: porcentajeGenero['hombres'] ?? 0,
                          title: 'Masculino',
                          radius: 60,
                          showTitle: false,
                          badgeWidget: Text(
                              '${porcentajeGenero['hombres']!.round()}%',
                              style: TextStyle(color: Colors.white)),
                        ),
                        PieChartSectionData(
                          color: Colors.pink,
                          value: porcentajeGenero['mujeres'] ?? 0,
                          title: 'Femenino',
                          radius: 60,
                          showTitle: false,
                          badgeWidget: Text(
                              '${porcentajeGenero['mujeres']!.round()}%',
                              style: TextStyle(color: Colors.white)),
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
                      color: Colors.blue,
                      width: 15,
                      height: 15,
                    ),
                    SizedBox(width: 5),
                    Text('Masculino'),
                    SizedBox(width: 20),
                    Container(
                      color: Colors.pink,
                      width: 15,
                      height: 15,
                    ),
                    SizedBox(width: 5),
                    Text('Femenino'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
