import 'dart:convert';
import 'dart:io';
import 'package:data_cache/podo/PostData.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

/*
* @author Sagar Chavan
* @since 14-feb-2020
* @version 1.0.0
* @class GetBrunchData calls api to get brunches data
* */

class GetPostsData {

  Future<List<PostData>> getPosts() async {
    final uri = 'https://jsonplaceholder.typicode.com/posts';
    print('RESPONSEURL: $uri');

    String fileName = "articledata.json";
    var dir = await getTemporaryDirectory();
    File file = new File(dir.path+"/"+fileName);

    if (file.existsSync()) {
      print("LOADINGFROM FILE");

      var jsonData = file.readAsStringSync();

      List<dynamic> resbody = jsonDecode(jsonData);
      print('RESPONSEBODY: $resbody');

      List<PostData> posts = resbody
          .map(
            (dynamic item) => PostData.fromJson(item),
      )
          .toList();

      return posts;
    }
    else{
      print("LOADINGFROM API");

      final res = await get(uri);
      print('RESPONSE: ${res.body}');
      file.writeAsStringSync(res.body, flush: true, mode: FileMode.write);

      List<dynamic> resbody = jsonDecode(res.body);
      print('RESPONSEBODY: $resbody');



      List<PostData> posts = resbody
          .map(
            (dynamic item) => PostData.fromJson(item),
      )
          .toList();

      return posts;
    }


  }
}
