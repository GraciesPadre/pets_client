import 'package:http/http.dart';
import 'package:pets_client/models/pets_data_model.dart';
import 'dart:convert';

class HttpServices {
  HttpServices(this.url);

  final String url;

  Client client = Client();

  Future<AllPetsData> getPetData() async {
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return AllPetsData.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load pet data.");
    }
  }
}