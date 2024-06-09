import 'package:get/get.dart';
import '../service/album_service.dart';

class AlbumController extends GetxController{
  var isLoading=true.obs;
  var albumList=[].obs;

  void readAlbum()async{
    try{
      isLoading(true);
      var album=await HttpServices.getAlbum;
      if(album!=null){
        albumList.value=album as List;
      }
    }catch(e){
      print(e);
    }finally{
      isLoading(false);
    }
  }
}