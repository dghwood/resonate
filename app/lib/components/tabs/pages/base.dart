import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/components/tabs/search.dart';
import 'package:resonate/router/navigation.dart';

final Logger _log = Logger('PageComponent');

// abstract class PageComponent extends StatelessWidget {
//   const PageComponent({super.key, required this.title});

//   final String title;

//   Widget buildChild(BuildContext context);

//   @override
//   Widget build(BuildContext context) {
//     var child = buildChild(context);
//     return Scaffold(
//       appBar: AppBar(
//         // leading: BackButton(),
//         title: Row(
//           children: [
//             IconButton(
//               icon: Icon(Icons.home),
//               onPressed: () => Navigate(context).reset(),
//             ),
//             Text(title),
//           ],
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigate(context).toSearch();
//             },
//             icon: Icon(Icons.search),
//           ),
//           IconButton(
//             onPressed: () {
//               Navigate(context).toProfilePage();
//             },
//             icon: Icon(Icons.person),
//           ),
//         ],
//       ),
//       body: child,
//     );
//   }
// }

// void openBottomPlayer() {
//     if (_bottomPlayerController != null) return;
//     print("openBottomPlayer");
//     _bottomPlayerController = showBottomSheet(
//       enableDrag: false,
//       constraints: BoxConstraints(maxHeight: 80),
//       context: context,
//       builder: (context) {
//         print("openBottomPlayer::builder");
//         return BottomPlayerComponent(viewModel: this);
//       },
//     );
//     print(_bottomPlayerController);
//   }

class PageScaffold extends StatelessWidget {
  const PageScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: child);
  }
}

abstract class PageComponent extends StatelessWidget {
  const PageComponent({super.key, required this.title});

  final String title;

  Widget buildChild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    var child = buildChild(context);
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).canvasColor),
      child: Column(
        children: [
          AppBar(
            // leading: BackButton(),
            title: Text(title),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

abstract class PageComponentWithScaffold extends StatelessWidget {
  const PageComponentWithScaffold({super.key, required this.title});

  final String title;

  Widget buildChild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: buildChild(context),
    );
  }
}
