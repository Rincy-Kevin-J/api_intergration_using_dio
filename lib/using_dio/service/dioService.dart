import 'package:dio/dio.dart';

class Dioservice {
  // Defines a static method named getPosts that returns a Future of dynamic type
  static Future<dynamic> getPosts() async {
    // Creates an instance of the Dio class
    Dio dio = Dio();

    // Initiates an asynchronous GET request to the specified URL using Dio
    return await dio
        .get(
      "https://jsonplaceholder.typicode.com/posts", // URL endpoint for fetching posts
      options: Options(
        responseType: ResponseType.json, // Set the expected response type to JSON
        method: "Get", // Specify the HTTP method as GET
      ),
    )
    // Use the then method to handle the response after the GET request completes
        .then((response) {
      print(response.statusCode); // Print the HTTP status code of the response
      print("??????"); // Print a placeholder message (could be used for debugging)
      return response; // Return the response object from the then method
    });
  }
}

/*
class Dioservice {
  static Future<dynamic> getPosts() async {
    Dio dio = Dio();
    return await dio
        .get("https://jsonplaceholder.typicode.com/posts",
        options: Options(responseType: ResponseType.json, method: "Get"))
        .then((response) {
      print(response.statusCode);
      print("??????");
      return response;
    });
  }
}

 */

/*
class Dioservice {
  static Future<dynamic> getPosts() async {
    Dio dio = Dio();
    return await dio
        .get("https://jsonplaceholder.typicode.com/posts",
            options: Options(responseType: ResponseType.json, method: "Get"))
        .then((response) {
      return response;
    });
  }
}

 */
