import 'package:appwrite/appwrite.dart';

class AppwriteConfig {
  static const String endpoint = 'https://[TU-ENDPOINT-DE-APPWRITE]';
  static const String projectId = '[TU-ID-DE-PROYECTO]';
  static const String databaseId = '[ID-BASE-DATOS]';
  static const String collectionId = '[ID-COLECCION]';

  static final client = Client()
    ..setEndpoint(endpoint)
    ..setProject(projectId)
    ..setSelfSigned(status: true);

  static final account = Account(client);
  static final databases = Databases(client);
}
