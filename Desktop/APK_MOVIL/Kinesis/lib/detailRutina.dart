class Rutina {
  final int id;
  final int numeroRutina;
  final int repeticionesAsignadas;
  final int tiempoDescansoRepeticiones;
  final DateTime fechaInicio;
  final DateTime? fechaFin;
  final bool? isCompleted;
  final int paciente;

  Rutina({
    required this.id,
    required this.numeroRutina,
    required this.repeticionesAsignadas,
    required this.tiempoDescansoRepeticiones,
    required this.fechaInicio,
    required this.fechaFin,
    required this.isCompleted,
    required this.paciente,
  });

  factory Rutina.fromJson(Map<String, dynamic> json) {
    return Rutina(
      id: json['id'],
      numeroRutina: json['numero_rutina'],
      repeticionesAsignadas: json['repeticiones_asignadas'],
      tiempoDescansoRepeticiones: json['tiempo_descanso_repeticiones'],
      fechaInicio: DateTime.parse(json['fecha_inicio']),
      fechaFin:
          json['fecha_fin'] != null ? DateTime.parse(json['fecha_fin']) : null,
      isCompleted: json['is_completed'],
      paciente: json['paciente'],
    );
  }
}
