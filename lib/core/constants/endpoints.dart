class Endpoints {
  static const base = 'https://adamix.net/medioambiente/';

  // Catálogos (ajústalos si el doc los nombra distinto)
  static const servicios    = 'api/servicios';
  static const noticias     = 'api/noticias';
  static const videos       = 'api/videos';
  static const areas        = 'areas_protegidas';   //Libe
  static const medidas      = 'api/medidas';
  static const equipo       = 'api/equipo';
  static const normativas   = 'api/normativas';

  // Auth / usuario
  static const login        = 'api/login';
  static const register     = 'api/registro';
  static const forgot       = 'api/recuperar_clave';

  // Reportes
  static const reportar     = 'api/reportar';
  static const misReportes  = 'api/mis_reportes';
}