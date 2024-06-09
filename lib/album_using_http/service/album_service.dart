import '../model/album_model.dart';
import 'package:http/http.dart' as http;

class HttpServices{
  static Future<List<Album>>getAlbum()async{
    var response=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/albums"));
    if (response.statusCode == 200) {
      var data = response.body; //type of body is string
      return albumFromJson(data);
    } else {
      throw Exception();
    }
  }
}