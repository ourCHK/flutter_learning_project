import 'dart:typed_data';
import 'dart:ui' as ui show Image;
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomTouchEventPage extends StatefulWidget {
  const CustomTouchEventPage({super.key});


  @override
  State createState() {
    return _CustomTouchEventState();
  }

}

class _CustomTouchEventState extends State<CustomTouchEventPage> {

  @override
  Widget build(BuildContext context) {
    print("CustomTouchEventPage Build!");
    return Scaffold(
      appBar: AppBar(title: Text("_CustomTouchEventState")),
      body: GestureDetector(
        onTap: (){
          print("your tap container!");
        },
        child: Container(
          color: Colors.pink,
          child: Center(
            child: SizedBox(
              height: 300,
              child: GestureDetector(
                onTap: (){
                  print("you tap CustomTouchEvent!");
                },
                child: CustomTouchEventLayout(
                  child: GestureDetector(
                    onTap: (){
                      print("you tap the text!");
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.green),
                      child: Text("This is the text you tap!"),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}

class CustomTouchEventLayout extends SingleChildRenderObjectWidget {
  const CustomTouchEventLayout({super.key, super.child});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return CustomTouchEventLayoutRenderObject();
  }

}

class CustomTouchEventLayoutRenderObject extends RenderBox with RenderObjectWithChildMixin<RenderBox> {

  @override
  bool get sizedByParent => true;

  @override
  void performResize() {
    size = constraints.biggest;
  }

  @override
  void performLayout() {
    if (child == null) {
      return;
    }
    child!.layout(constraints,parentUsesSize: true);
    // var childSize = child!.size;
    // size = childSize;
  }

  /// 绘制
  /// 注：绘制是不受布局限制的，也就是说允许在布局之外绘制
  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);

    /// 在指定的位置绘制 child
    context.paintChild(child!, offset);

    // /// 在指定的位置添加一个不透明度为 0x40 的图层
    // context.pushOpacity(offset, 0x40, (context, offset) {
    //   /// 在这个图层内的指定位置绘制 child，从而实现阴影效果
    //   context.paintChild(child!, shadowOffset);
    // });
  }

  @override
  bool hitTest(BoxHitTestResult result, { required Offset position }){
    // print("${toImageSync(position)}");
    // return false;
    // return super.hitTest(result, position: position);
    super.hitTest(result, position: position);
    return false;
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    super.hitTestChildren(result, position: position);
    // print("$position ${child!.size.contains(position)}");
    // var childHit = child!.hitTest(result, position: position);
    return false;
  }

  @override
  bool get isRepaintBoundary => true;

  Future<ui.Image> toImageSync(Offset point,{ double pixelRatio = 1.0 }) async {
    // assert(!debugNeedsPaint);
    print("point:$point");
    final OffsetLayer offsetLayer = layer! as OffsetLayer;
    var image = offsetLayer.toImageSync(Offset.zero & size, pixelRatio: pixelRatio);
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.rawRgba);
    if (byteData != null) {
      int pixel32 = byteData.getInt32((point.dx.floor() + point.dy.floor() * image.width) * 4);
      print(pixel32.toRadixString(16));
      if (pixel32 == 0) {
        GestureBinding.instance!.handlePointerEvent(PointerDownEvent());
      }
    }
    return image;
  }

  // Future<Color> getPixelColor(BuildContext context, Offset point) async {
  //
  //   // RenderBox renderBox = context.findRenderObject() as RenderBox;
  //   // Image image = await renderBox.toImage();
  //   // ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //   // int pixel32 = byteData.getInt32((point.dx.floor() + point.dy.floor() * image.width) * 4);
  //   //
  //   // return Color(pixel32);
  // }


}