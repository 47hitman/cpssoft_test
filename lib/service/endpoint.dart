import 'dart:convert';

import 'package:http/http.dart' as http;

import 'custom_exception.dart';

class Endpoint {
  Endpoint._privateConstructor();
  String apiAddress =
      "https://627e360ab75a25d3f3b37d5a.mockapi.io/api/v1/accurate/";
  static final Endpoint instance = Endpoint._privateConstructor();

//get kode wilayah
  Future userget() async {
    final http.Response response = await http.get(
      Uri.parse('${apiAddress}user'),
    );
    // print("code cuaca");
    // print(response.request);
    // print(response.body);
    // print(response);
    return _response(response);
  }

  Future userpost(
    String name,
    String address,
    String email,
    String phoneNumber,
    String city,
  ) async {
    final response = await http.post(Uri.parse('${apiAddress}user'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "name": name,
          "address": address,
          "email": email,
          "phoneNumber": phoneNumber,
          "city": city,
        }));
    print('onrest');
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      print("work");
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

//data cuaca perwilayah
  // Future cuacawilayah(int wilayahCode) async {
  //   final http.Response response = await http.get(
  //     Uri.parse('${apiAddress}user/$wilayahCode.json'),
  //   );
  //   print("code cuaca");
  //   print(response.request);
  //   print(response.body);
  //   print(response);
  //   return _response(response);
  // }
}

dynamic _response(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    case 204:
      return null;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
      throw InvalidToken(response.body.toString());
    case 404:
      throw UnauthorizedException(response.body.toString());
    case 500:
      throw InvalidParameter(response.body.toString());
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode: ${response.statusCode}');
  }
}
