import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../utils/snackbar.dart';
import '../controller/postController.dart';
class PostHome extends StatelessWidget {
  // Create an instance of PostController and register it with GetX for dependency injection
  PostController controller = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    // Build method to create the widget tree
    return Scaffold(
      // Scaffold provides the basic structure for the visual interface
      appBar: AppBar(
        title: Text("Posts"), // Title displayed in the app bar
        backgroundColor: Colors.teal, // Background color of the app bar
      ),
      // The body of the Scaffold is an Obx widget that reacts to changes in the controller
      body: Obx(() => SizedBox(
          height: double.infinity, // Full height of the available space
          width: double.infinity, // Full width of the available space
          // Conditional rendering based on internet connectivity and loading state
          child: controller.isNetConnected.value == true
              ? controller.isLoading.value
          // Show loading indicator while data is being fetched
              ? const Center(
            child: CircularProgressIndicator(
              color: Colors.purple, // Color of the loading spinner
            ),
          )
          // Show the data when it is available
              : getData()
          // Show no internet message if not connected to the internet
              : noInternet(context)
      )),
      // Conditionally show a floating action button based on internet connectivity
      floatingActionButton: Obx(() =>
      controller.isNetConnected.value == true ? buildFAB() : Container()
      ),
    );
  }

  // Method to build the floating action button
  FloatingActionButton buildFAB() {
    return FloatingActionButton(
      onPressed: () {
        // Toggle the scroll direction based on the isListDowN value
        controller.isListDowN.value
            ? controller.scrollListUp() // Scroll to the top if list is down
            : controller.scrollListDown(); // Scroll to the bottom if list is up
      },
      // Icon changes based on the value of isListDowN
      child: FaIcon(controller.isListDowN.value
          ? FontAwesomeIcons.arrowTrendUp // Up arrow icon if list is down
          : FontAwesomeIcons.arrowTrendDown // Down arrow icon if list is up
      ),
    );
  }

  // Method to build the widget that displays the posts data
  RefreshIndicator getData() {
    return RefreshIndicator(
      // Refresh the list by fetching posts again when pulled down
      onRefresh: () => controller.fetchPosts(),
      child: ScrollablePositionedList.builder(
          itemScrollController: controller.scrollController, // Scroll controller for the list
          itemCount: controller.posts.length, // Number of items in the list
          itemBuilder: (context, index) {
            // Build each item in the list
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.brown[300], // Background color of the avatar
                  // Display the ID of the post inside the avatar
                  child: Text(controller.posts[index].id!.toString()),
                ),
                // Display the title of the post
                title: Text(controller.posts[index].title!),
                // Display the body of the post
                subtitle: Text(controller.posts[index].body!),
              ),
            );
          }
      ),
    );
  }

  // Method to build the widget that displays the no internet connection message
  Center noInternet(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // Display an animation when there is no internet connection
          Lottie.asset("assets/animation/hamsteranime.json"),
          // Button to retry fetching posts
          MaterialButton(
            onPressed: () async {
              // Check internet connection and fetch posts if connected
              if (await InternetConnection().hasInternetAccess == true) {
                controller.fetchPosts();
              } else {
                // Show a snack bar if still no internet connection
                showCustomSnackBar(context);
              }
            },
            shape: const StadiumBorder(), // Shape of the button
            child: const Text("Retry"), // Text on the button
          )
        ],
      ),
    );
  }
}

/*
class PostHome extends StatelessWidget {
  Postcontroller controller = Get.put(Postcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
        backgroundColor: Colors.teal,
      ),
      body: Obx(() => SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: controller.isNetConnected.value == true
              ? controller.isLoading.value
              ? const Center(
            child: CircularProgressIndicator(
              color: Colors.purple,
            ),
          )
              : getData()
              : noInternet(context))),
      floatingActionButton: Obx(() =>
      controller.isNetConnected.value == true ? buildFAB() : Container()),
    );
  }

  FloatingActionButton buildFAB() {
    return FloatingActionButton(
      onPressed: () {
        controller.isListDowN.value
            ? controller.scrollListUp()
            : controller.scrollListDown();
      },
      child: FaIcon(controller.isListDowN.value
          ? FontAwesomeIcons.arrowTrendUp
          : FontAwesomeIcons.arrowTrendDown),
    );
  }

  RefreshIndicator getData() {
    return RefreshIndicator(
      onRefresh: () => controller.fetchPosts(),
      child: ScrollablePositionedList.builder(
          itemScrollController: controller.scrollController,
          itemCount: controller.posts.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.brown[300],
                  child: Text(controller.posts[index].id!.toString()),
                ),
                title: Text(
                  controller.posts[index].title!,
                ),
                subtitle: Text(
                  controller.posts[index].body!,
                ),
              ),
            );
          }),
    );
  }

  Center noInternet(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Lottie.asset("assets/animation/hamsteranime.json"),
          MaterialButton(
            onPressed: () async {
              if (await InternetConnection().hasInternetAccess == true) {
                controller.fetchPosts();
              } else {
                showCustomSnackBar(context);
              }
            },
            shape: const StadiumBorder(),
            child: const Text("Retry"),
          )
        ],
      ),
    );
  }
}

 */


// class PostHome extends StatelessWidget {
//   Postcontroller controller = Get.put(Postcontroller());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Posts"),
//         backgroundColor: Colors.teal,
//       ),
//       body: Obx(() => SizedBox(
//           height: double.infinity,
//           width: double.infinity,
//           child: controller.isNetConnected.value == true
//               ? controller.isLoading.value
//                   ? const Center(
//                       child: CircularProgressIndicator(
//                         color: Colors.purple,
//                       ),
//                     )
//                   : getData()
//               : noInternet(context))),
//       floatingActionButton: Obx(() =>
//           controller.isNetConnected.value == true ? buildFAB() : Container()),
//     );
//   }
//
//   FloatingActionButton buildFAB() {
//     return FloatingActionButton(
//       onPressed: () {
//         controller.isListDowN.value
//             ? controller.scrollListUp()
//             : controller.scrollListDown();
//       },
//       child: FaIcon(controller.isListDowN.value
//           ? FontAwesomeIcons.arrowTrendUp
//           : FontAwesomeIcons.arrowTrendDown),
//     );
//   }
//
//   RefreshIndicator getData() {
//     return RefreshIndicator(
//       onRefresh: () => controller.fetchPosts(),
//       child: ScrollablePositionedList.builder(
//           itemScrollController: controller.scrollController,
//           itemCount: controller.posts.length,
//           itemBuilder: (context, index) {
//             return Card(
//               child: ListTile(
//                 leading: CircleAvatar(
//                   backgroundColor: Colors.brown[300],
//                   child: Text(controller.posts[index].id!.toString()),
//                 ),
//                 title: Text(
//                   controller.posts[index].title!,
//                 ),
//                 subtitle: Text(
//                   controller.posts[index].body!,
//                 ),
//               ),
//             );
//           }),
//     );
//   }
//
//   Center noInternet(BuildContext context) {
//     return Center(
//       child: Column(
//         children: [
//           Lottie.asset("assets/animation/hamsteranime.json"),
//           MaterialButton(
//             onPressed: () async {
//               if (await InternetConnection().hasInternetAccess == true) {
//                 controller.fetchPosts();
//               } else {
//                 showCustomSnackBar(context);
//               }
//             },
//             shape: const StadiumBorder(),
//             child: const Text("Retry"),
//           )
//         ],
//       ),
//     );
//   }
// }
