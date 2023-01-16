import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one/components/Footer.dart';
import 'package:one/models/poster_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'home_logic.dart';
import 'home_state.dart';

const defaultPoster = 'assets/images/poster-1.jpeg';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final logic = Get.put(HomeLogic()); // 实例化logic
  final state = Get.find<HomeLogic>().state;

  var pageNum = 1;

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  void _onRefresh() {
    logic.getPosterList(++state.pageNum, 'down').then(
      (_) {
        if (state.hasMore == true) {
          _refreshController.refreshCompleted();
        } else {
          _refreshController.refreshCompleted();
        }
      },
    );
  }

  void _onLoading() {
    logic.getPosterList(++state.pageNum, 'up').then(
      (_) {
        if (state.hasMore == true) {
          _refreshController.loadComplete();
        } else {
          _refreshController.loadNoData();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const spacing = 10.0;
    return GetBuilder<HomeLogic>(builder: (logic) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('订阅'),
          centerTitle: true, // NOTE: 标题居中
          backgroundColor: Colors.transparent,
        ),
        // bottomNavigationBar: const Footer(),
        body: Scrollbar(
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: CustomHeader(
              builder: (context, mode) {
                Widget body = const SizedBox();
                if (mode == RefreshStatus.idle) {
                  body = const Text("下拉刷新");
                } else if (mode == RefreshStatus.refreshing) {
                  body = const CupertinoActivityIndicator();
                } else if (mode == RefreshStatus.canRefresh) {
                  body = const Text("松手，加载更多!");
                } else if (mode == RefreshStatus.completed) {
                  body = const Text("加载完成!");
                }

                return SizedBox(
                  height: 60.0,
                  child: Center(
                    child: body,
                  ),
                );
              },
            ),
            footer: CustomFooter(
              builder: (_, mode) {
                switch (mode) {
                  case LoadStatus.idle:
                    return _buildScrollBarFooterView(const Text('上拉加载'));
                  case LoadStatus.loading:
                    return _buildScrollBarFooterView(
                        const CupertinoActivityIndicator());
                  case LoadStatus.failed:
                    return _buildScrollBarFooterView(const Text('加载失败，稍后重试'));
                  case LoadStatus.canLoading:
                    return _buildScrollBarFooterView(const Text('松手，加载更多！'));
                  default:
                    return _buildScrollBarFooterView(const Text('没有更多数据了！'));
                }
              },
            ),
            controller: _refreshController,
            onLoading: _onLoading,
            onRefresh: _onRefresh,
            child: GridView(
              padding: const EdgeInsets.all(spacing),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                mainAxisSpacing: spacing,
                crossAxisSpacing: spacing,
              ),
              children: state.posterList.map((poster) {
                return buildPosterCard(poster);
              }).toList(),
            ),
          ),
        ),
      );
    });
  }

  Widget buildPosterCard(posterInfo) {
    return InkWell(
      onTap: () {},
      child: GridTile(
        child: GestureDetector(
          child: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 8.0,
                  color: Colors.black12,
                  offset: Offset(0, 0),
                )
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: ClipRRect(
              // NOTE: 圆角超出裁剪
              borderRadius: BorderRadius.circular(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    // NOTE: 剪裁控件的使用
                    children: [
                      ClipRect(
                        child: SizedBox(
                          height: 130,
                          child: CachedNetworkImage(
                            alignment: Alignment.topCenter,
                            imageUrl: posterInfo.posterUrl ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          posterInfo.content,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12, height: 1.5),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 10),
                        child: Text('- ${posterInfo.author} -'),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          onTap: () {
            Get.toNamed('/details/${posterInfo.id}');
          },
        ),
      ),
    );
  }

  Widget _buildScrollBarFooterView(Widget footerView) {
    return SizedBox(
      height: 55.0,
      child: Center(
        child: footerView,
      ),
    );
  }
}
