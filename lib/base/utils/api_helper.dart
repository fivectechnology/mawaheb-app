const String BASE_API = 'http://34.235.130.49:8080/mawaheb';

const String BASE_REST_API = '/ws/rest';

String webServiceEndPoint(String modelName, {String id}) {
  return '$BASE_API$BASE_REST_API/$modelName/${id ?? ''}';
}
