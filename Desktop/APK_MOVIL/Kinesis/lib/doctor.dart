class Doctor {
  final int id;
  final String nombre;
  final String apellido;
  final int edad;
  final String correo;
  final String celular;
  final String genero;
  final int usuario;

  Doctor({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.edad,
    required this.correo,
    required this.celular,
    required this.genero,
    required this.usuario,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      edad: json['edad'],
      correo: json['correo'],
      celular: json['celular'],
      genero: json['genero'],
      usuario: json['usuario'],
    );
  }
}
