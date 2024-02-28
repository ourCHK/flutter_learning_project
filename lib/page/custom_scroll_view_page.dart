import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomScrollViewPage extends StatelessWidget {
  const CustomScrollViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CustomScrollView')),
      body: Column(
        children: [
          const Text("Below show the SliverFlexibleHeader"),
          Expanded(
              child: DecoratedBox(
            decoration: const BoxDecoration(color: Colors.yellow),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                _SliverFlexibleHeader(
                  visibleExtent: 50,
                  child: Image.asset('images/image.jpeg'),
                ),
                // _TestSliverToBoxAdapter(
                //   child: Image.asset(
                //       'images/image.jpeg', width: 100, height: 100),
                // ),
                SliverList.builder(
                  itemBuilder: (context, index) {
                    return DecoratedBox(
                        decoration: const BoxDecoration(color: Colors.blue),
                        child: Text("Data:$index"));
                  },
                  itemCount: 50,
                ),
              ],
            ),
          )),
          const Text("Below show the SliverPersistentHeaderToBox"),
          Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return LayoutBuilder(builder: (context, constrains) {
                      print("build index:$index");
                      return DecoratedBox(
                          decoration: BoxDecoration(color: Colors.blue),
                          child: Text("Data:$index"));
                    });
                  },
                  itemCount: 50))
        ],
      ),
    );
  }
}

class _TestSliverToBoxAdapter extends SingleChildRenderObjectWidget {
  const _TestSliverToBoxAdapter({super.key, super.child});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _TestSliverToBoxAdapterRenderSliver();
  }
}

class _TestSliverToBoxAdapterRenderSliver extends RenderSliverSingleBoxAdapter {
  _TestSliverToBoxAdapterRenderSliver();

  @override
  void performLayout() {
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }

    final SliverConstraints constraints = this.constraints;
    print(
        "overlap:${constraints.overlap}  scrollOffset:${constraints.scrollOffset}");
    //首先先给child布局
    child!.layout(constraints.asBoxConstraints(), parentUsesSize: true);

    //计算出child的大小
    final double childExtent;
    switch (constraints.axis) {
      case Axis.vertical:
        childExtent = child!.size.height;
        break;
      case Axis.horizontal:
        childExtent = child!.size.width;
        break;
    }

    final double paintedChildSize =
        calculatePaintOffset(constraints, from: 0, to: childExtent);
    final double cacheExtent =
        calculateCacheOffset(constraints, from: 0, to: childExtent);

    geometry = SliverGeometry(
        scrollExtent: childExtent,
        paintExtent: paintedChildSize,
        cacheExtent: cacheExtent,
        maxPaintExtent: paintedChildSize,
        hitTestExtent: paintedChildSize,
        hasVisualOverflow: childExtent > constraints.remainingPaintExtent ||
            constraints.scrollOffset > 0);
    setChildParentData(child!, constraints, geometry!);
  }
}

class _SliverFlexibleHeader extends SingleChildRenderObjectWidget {
  final double visibleExtent;

  const _SliverFlexibleHeader({super.key, super.child, this.visibleExtent = 0});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _FlexibleHeaderRenderSliver(visibleExtent);
  }

  @override
  void updateRenderObject(BuildContext context, _FlexibleHeaderRenderSliver renderObject) {
    renderObject.visibleExtent = visibleExtent;
  }
}

typedef SliverFlexibleHeaderBuilder = Widget Function(
  BuildContext context,
  double maxExtent,
);

class SliverFlexibleHeader extends StatelessWidget {

  final SliverFlexibleHeaderBuilder builder;

  final double visibleExtent;

  const SliverFlexibleHeader({super.key, this.visibleExtent = 0, required this.builder});

  @override
  Widget build(BuildContext context) {
    return _SliverFlexibleHeader(visibleExtent: visibleExtent,
    child: LayoutBuilder(builder: (context, constraints) {
      return builder(context, constraints.maxHeight);
    }));
  }
}



class _FlexibleHeaderRenderSliver extends RenderSliverSingleBoxAdapter {
  _FlexibleHeaderRenderSliver(double visibleExtent)
      : _visibleExtent = visibleExtent;

  double _lastOverScroll = 0;
  double _lastScrollOffset = 0;
  double _visibleExtent = 0;

  set visibleExtent(double value) {
    // 可视长度发生变化，更新状态并重新布局
    if (_visibleExtent != value) {
      _lastOverScroll = 0;
      _visibleExtent = value;
      markNeedsLayout();
    }
  }

  @override
  void performLayout() {
    if (child == null || constraints.scrollOffset > _visibleExtent) {
      geometry = SliverGeometry(scrollExtent: _visibleExtent);
      child!.layout(constraints.asBoxConstraints(maxExtent: 0),parentUsesSize: false);
      return;
    }

    //下拉距离
    double overScroll = constraints.overlap < 0 ? constraints.overlap.abs() : 0;

    //滑动距离
    var scrollOffset = constraints.scrollOffset;

    //绘制距离等于设置的最开始的大小 + 下滑时的大小，或者最开始的大小减去上划的大小
    double paintExtent = _visibleExtent + overScroll - scrollOffset;

    print("overScroll:${overScroll} "
        "visible:$_visibleExtent "
        "scrollOffset:${constraints.scrollOffset} "
        "remainPaintExtent:${constraints.remainingPaintExtent} "
        "paintExtent:$paintExtent");

    //绘制的大小不超过viewPort的大小
    paintExtent = min(paintExtent, constraints.remainingPaintExtent);

    //布局，且不需要子view的大小
    child!.layout(constraints.asBoxConstraints(maxExtent: paintExtent),
        parentUsesSize: true);

    double layoutExtent = min(_visibleExtent, paintExtent);

    geometry = SliverGeometry(
        scrollExtent: layoutExtent,
        paintExtent: layoutExtent,
        paintOrigin: -overScroll,
        //绘制的位置在下拉的位置或者原始点0(没下拉滑动时)
        maxPaintExtent: layoutExtent,
        layoutExtent: layoutExtent);
  }
}
