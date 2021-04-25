// FutureBuilder<bool>(
//         future: getData(),
//         builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//           if (!snapshot.hasData) {
//             return const SizedBox();
//           } else {
//             return Padding(
//               padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Expanded(
//                     child: FutureBuilder<bool>(
//                       future: getData(),
//                       builder:
//                           (BuildContext context, AsyncSnapshot<bool> snapshot) {
//                         if (!snapshot.hasData) {
//                           return const SizedBox();
//                         } else {
//                           return GridView(
//                             padding: const EdgeInsets.only(
//                                 top: 0, left: 12, right: 12),
//                             physics: const BouncingScrollPhysics(),
//                             scrollDirection: Axis.vertical,
//                             children: List<Widget>.generate(
//                               homeList.length,
//                               (int index) {
//                                 final int count = homeList.length;
//                                 final Animation<double> animation =
//                                     Tween<double>(begin: 0.0, end: 1.0).animate(
//                                   CurvedAnimation(
//                                     parent: animationController,
//                                     curve: Interval((1 / count) * index, 1.0,
//                                         curve: Curves.fastOutSlowIn),
//                                   ),
//                                 );
//                                 animationController.forward();
//                                 return HomeListView(
//                                   animation: animation,
//                                   animationController: animationController,
//                                   callBack: () {
//                                     // Navigator.push<dynamic>(
//                                     //   context,
//                                     //   MaterialPageRoute<dynamic>(
//                                     //     builder: (BuildContext context) =>
//                                     //         homeList[index].navigateScreen,
//                                     //   ),
//                                     // );
//                                   },
//                                 );
//                               },
//                             ),
//                             gridDelegate:
//                                 SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: multiple ? 2 : 1,
//                               mainAxisSpacing: 12.0,
//                               crossAxisSpacing: 12.0,
//                               childAspectRatio: 1.5,
//                             ),
//                           );
//                         }
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
