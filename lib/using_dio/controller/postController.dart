import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../model/postModel.dart';
import '../service/dioService.dart';
class PostController extends GetxController {
  // Define a reactive list of ProductModel objects to store posts
  RxList<ProductModel> posts = RxList<ProductModel>();

  // Define a reactive boolean to track the loading state
  RxBool isLoading = true.obs;

  // Define a reactive boolean to track if the list is scrolled down
  RxBool isListDowN = false.obs;

  // Define a reactive boolean to track internet connection status
  RxBool isNetConnected = true.obs;

  // Define a scroll controller for managing scroll events
  ItemScrollController scrollController = ItemScrollController();

  // Method to check internet connectivity
  Future<void> isInternetConnected() async {
    // Update isNetConnected with the result of internet connectivity check
    isNetConnected.value = await InternetConnection().hasInternetAccess;
    // Print the internet connection status
    print("Internet connection status: ${isNetConnected.value}");
  }

  // Method to fetch posts from the server
  Future<void> fetchPosts() async {
    // Check if the device is connected to the internet
    await isInternetConnected();
    // If not connected, print message and set isLoading to false
    if (!isNetConnected.value) {
      print("No internet connection.");
      isLoading.value = false;
      return;
    }

    // Set isLoading to true before fetching data
    isLoading.value = true;
    print("Fetching posts...");
    try {
      // Make a network request to fetch posts
      var response = await Dioservice.getPosts();
      // If the response is successful (status code 200)
      if (response.statusCode == 200) {
        // Print the response data
        print('Response data: ${response.data}');
        // Clear the current posts list
        posts.clear();

        // If response data is not null, process each data item
        if (response.data != null) {
          response.data.forEach((data) {
            // If data item is not null and is of correct type, add it to posts
            if (data != null && data is Map<String, dynamic>) {
              posts.add(ProductModel.fromJson(data));
            } else {
              // Print message if data format is invalid
              print('Invalid data format: $data');
            }
          });
        } else {
          // Print message if response data is null
          print('Response data is null.');
        }
        // Set isLoading to false after data is processed
        isLoading.value = false;
      } else {
        // Print message if response status code is not 200
        print("Failed to fetch posts: ${response.statusCode}");
        isLoading.value = false;
      }
    } catch (e) {
      // Catch and print any errors that occur during fetching
      print("Error fetching posts: $e");
      isLoading.value = false;
    }
  }

  // Method to scroll the list to the bottom
  void scrollListDown() {
    // Check if there are any posts to scroll to
    if (posts.isNotEmpty) {
      // Use scrollController to scroll to the last item
      scrollController.scrollTo(
        index: posts.length - 1, // Index of the last item
        duration: Duration(seconds: 3), // Duration of the scroll animation
        curve: Curves.easeInOutCirc, // Animation curve
      );
      // Set isListDowN to false after scrolling down
      isListDowN.value = false;
    }
  }

  // Method to scroll the list to the top
  void scrollListUp() {
    // Check if there are any posts to scroll to
    if (posts.isNotEmpty) {
      // Use scrollController to scroll to the first item
      scrollController.scrollTo(
        index: 0, // Index of the first item
        duration: Duration(seconds: 3), // Duration of the scroll animation
        curve: Curves.fastLinearToSlowEaseIn, // Animation curve
      );
      // Set isListDowN to true after scrolling up
      isListDowN.value = true;
    }
  }

  // Override the onInit method to perform actions when the controller is initialized
  @override
  void onInit() {
    super.onInit(); // Call the parent class's onInit method
    fetchPosts(); // Fetch posts when the controller is initialized
  }
}


/*
class Postcontroller extends GetxController {
  RxList<ProductModel> posts = RxList<ProductModel>();
  RxBool isLoading = true.obs;
  RxBool isListDowN = false.obs;
  RxBool isNetConnected = true.obs;
  ItemScrollController scrollController = ItemScrollController();

  Future<void> isInternetConnected() async {
    isNetConnected.value = await InternetConnection().hasInternetAccess;
    print("Internet connection status: ${isNetConnected.value}");
  }

  Future<void> fetchPosts() async {
    await isInternetConnected();
    if (!isNetConnected.value) {
      print("No internet connection.");
      isLoading.value = false;
      return;
    }

    isLoading.value = true;
    print("Fetching posts...");
    try {
      var response = await Dioservice.getPosts();
      if (response.statusCode == 200) {
        print('Response data: ${response.data}');
        posts.clear(); // Clear the posts list before adding new posts

        if (response.data != null) {
          response.data.forEach((data) {
            if (data != null && data is Map<String, dynamic>) {
              posts.add(ProductModel.fromJson(data));
            } else {
              print('Invalid data format: $data');
            }
          });
        } else {
          print('Response data is null.');
        }
        isLoading.value = false;
      } else {
        print("Failed to fetch posts: ${response.statusCode}");
        isLoading.value = false;
      }
    } catch (e) {
      print("Error fetching posts: $e");
      isLoading.value = false;
    }
  }

  void scrollListDown() {
    if (posts.isNotEmpty) {
      scrollController.scrollTo(
        index: posts.length - 1,
        duration: Duration(seconds: 3),
        curve: Curves.easeInOutCirc,
      );
      isListDowN.value = false;
    }
  }

  void scrollListUp() {
    if (posts.isNotEmpty) {
      scrollController.scrollTo(
        index: 0,
        duration: Duration(seconds: 3),
        curve: Curves.fastLinearToSlowEaseIn,
      );
      isListDowN.value = true;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }
}

 */

/*

class Postcontroller extends GetxController {
  RxList<ProductModel> posts = RxList();
  RxBool isLoading = true.obs;
  RxBool isListDowN = false.obs;
  RxBool isNetConnected = true.obs;
  var scrollController = ItemScrollController();

  void isInternetConnected() async {
    isNetConnected.value = await InternetConnection().hasInternetAccess;
  }

  fetchPosts() async {
    isInternetConnected();
    isLoading.value = true;
    var response = await Dioservice().getPosts();
    if (response.statuscode == 200) {
      response.data.forEach((data) {
        posts.add(ProductModel.fromJson(data));
        print(posts);
      });
      isLoading.value = false;
    }
  }

  scrollListDown() {
    scrollController.scrollTo(
        index: posts.length,
        duration: Duration(seconds: 3),
        curve: Curves.easeInOutCirc);
    isListDowN.value = false;
  }

  scrollListUp() {
    scrollController.scrollTo(
        index: 0,
        duration: Duration(seconds: 3),
        curve: Curves.fastLinearToSlowEaseIn);
    isListDowN.value = false;
  }

  @override
  void onInit() {
    fetchPosts();
    isInternetConnected();
    super.onInit();
  }
}

 */
