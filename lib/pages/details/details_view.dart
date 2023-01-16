import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'details_logic.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({Key? key}) : super(key: key);

  final logic = Get.put(DetailsLogic());
  final state = Get.find<DetailsLogic>().state;

  Future _showMenu(context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        // NOTE: 弹窗加圆角
        return Stack(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.black54,
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.copy),
                    title: const Text('复制'),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const ListTile(
                    leading: Icon(
                      Icons.warning_amber,
                      color: Colors.red,
                    ),
                    title: Text(
                      '警告',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  ListTile(
                    title: const Center(
                      child: Text('取消'),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailsLogic>(
      builder: (logic) {
        return Scaffold(
          // NOTE: 隐藏导航栏
          // appBar: AppBar(
          //   title: const Text('详情'),
          // ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 400,
                padding: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(state.posterDetails.posterUrl ?? ''),
                    fit: BoxFit.contain,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 90,
                      left: 20,
                      right: 20,
                      child: Text(
                        state.posterDetails.content,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              // TODO: 超出一屏超出会报错？？布局不会自动撑开吗？
              // CachedNetworkImage(
              //   alignment: Alignment.topCenter,
              //   imageUrl: state.posterDetails.posterUrl ?? '',
              //   fit: BoxFit.cover,
              //   width: MediaQuery.of(context).size.width,
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(10),
              //   child: Text(
              //     state.posterDetails.content,
              //   ),
              // )
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.chevron_left,
                      ),
                      color: Colors.grey,
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                    Row(
                      // TODO: 批量设置间距和颜色
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 10,
                          ),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.add_chart_sharp,
                                color: Colors.grey,
                              ),
                              Text(
                                '134',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 10,
                          ),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.messenger_outline,
                                color: Colors.grey,
                              ),
                              Text(
                                '34',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 10,
                          ),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.heart_broken_outlined,
                                color: Colors.grey,
                              ),
                              Text(
                                '13',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    _showMenu(context);
                  },
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
