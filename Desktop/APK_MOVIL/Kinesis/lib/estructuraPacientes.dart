class Paciente {
  final int id;
  final String nombres;
  final String apellidos;
  final String correo;
  final String cedula;
  final String direccion;
  final String celular;
  final String genero;
  final int edad;
  final String tipoLesion;
  final int rutinasAsignadas;
  final String recomendacion;
  final int tiempoDescansoEntreRutinas;
  final DateTime created;
  final int doctor;
  final int usuario;

  Paciente({
    required this.id,
    required this.nombres,
    required this.apellidos,
    required this.correo,
    required this.cedula,
    required this.direccion,
    required this.celular,
    required this.genero,
    required this.edad,
    required this.tipoLesion,
    required this.rutinasAsignadas,
    required this.recomendacion,
    required this.tiempoDescansoEntreRutinas,
    required this.created,
    required this.doctor,
    required this.usuario,
  });

  factory Paciente.fromJson(Map<String, dynamic> json) {
    return Paciente(
      id: json['id'],
      nombres: json['nombres'],
      apellidos: json['apellidos'],
      correo: json['correo'],
      cedula: json['cedula'],
      direccion: json['direccion'],
      celular: json['celular'],
      genero: json['genero'],
      edad: json['edad'],
      tipoLesion: json['tipo_lesion'],
      rutinasAsignadas: json['rutinas_asignadas'],
      recomendacion: json['recomendacion'],
      tiempoDescansoEntreRutinas: json['tiempo_descanso_entre_rutinas'],
      created: DateTime.parse(json['created']),
      doctor: json['doctor'],
      usuario: json['usuario'],
    );
  }
}
