import 'package:api_intergration_using_http_dio/album_using_http/screens/album_screens.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ApiHttp());
}
class ApiHttp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: AlbumHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}
