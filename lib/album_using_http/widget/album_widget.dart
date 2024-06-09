import 'package:flutter/material.dart';

import '../model/album_model.dart';

class AlbumTile extends StatelessWidget {
  final Album album;
   AlbumTile(this.album);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(album.title!),
          Text(album.userId! as String),
          Text(album.id! as String)
        ],
      ),

    );
  }
}
