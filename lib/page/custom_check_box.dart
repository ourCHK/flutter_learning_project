import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

class CustomRenderBoxPage extends StatefulWidget {
  const CustomRenderBoxPage({super.key});


  @override
  State createState() {
    return _CustomRenderBoxState();
  }

}

class _CustomRenderBoxState extends State<CustomRenderBoxPage> {

  bool _checked = false;

  String textString = "Click to Change me!";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:const Text("CustomRenderBoxPage")),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomCheckBox(
                value: _checked,
                onChanged: _onChange,
              ),
              ElevatedButton(onPressed: (){
                setState(() {
                  textString = "I have been change!";
                });
              }, child: Text(textString))
            ],
          )
        )
    );
  }

  _onChange(bool value) {
    print("onChange:$value");
    setState(() {
      _checked = value;
    });
  }
}

class CustomCheckBox extends LeafRenderObjectWidget {

  const CustomCheckBox({super.key,this.strokeWidth = 2.0,
    this.value = false,
    this.strokeColor = Colors.white,
    this.fillColor = Colors.blue,
    this.radius = 2.0,
    this.onChanged});

  final double strokeWidth; // “勾”的线条宽度
  final Color strokeColor; // “勾”的线条宽度
  final Color? fillColor; // 填充颜色
  final bool value; //选中状态
  final double radius; // 圆角
  final ValueChanged<bool>? onChanged; // 选中状态发生改变后的回调

  @override
  RenderObject createRenderObject(BuildContext context) {
    print("createRenderObject");
    return RenderCustomCheckBox(
      strokeWidth,
      strokeColor,
      fillColor ?? Theme.of(context).primaryColor,
      value,
      radius,
      onChanged,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderCustomCheckBox renderObject) {
    print("updateRenderObject");
    if (renderObject.value != value) {
      renderObject.animationStatus = value ? AnimationStatus.forward : AnimationStatus.reverse;
    }
    renderObject
      ..strokeWidth = strokeWidth
      ..strokeColor = strokeColor
      ..fillColor = fillColor ?? Theme.of(context).primaryColor
      ..radius = radius
      ..value = value
      ..onChanged = onChanged;
  }
}

class RenderCustomCheckBox extends RenderBox {

  bool value;
  int pointerId = -1;
  double strokeWidth;
  Color strokeColor;
  Color fillColor;
  double radius;
  ValueChanged<bool>? onChanged;

  // 下面的属性用于调度动画
  double progress = 0; // 动画当前进度
  int? _lastTimeStamp;//上一次绘制的时间
  //动画执行时长
  Duration get duration => const Duration(milliseconds: 550);
  //动画当前状态
  AnimationStatus _animationStatus = AnimationStatus.completed;
  set animationStatus(AnimationStatus v) {
    if (_animationStatus != v) {
      markNeedsPaint();
    }
    _animationStatus = v;
  }

  //背景动画时长占比（背景动画要在前40%的时间内执行完毕，之后执行打勾动画）
  final double bgAnimationInterval = .4;

  RenderCustomCheckBox(this.strokeWidth, this.strokeColor, this.fillColor,
      this.value, this.radius, this.onChanged)
      : progress = value ? 1 : 0;

  @override
  bool get isRepaintBoundary => true;

  @override
  void performLayout() {
    size = constraints.constrain(constraints.isTight ? Size.infinite : const Size(100, 100));
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, covariant BoxHitTestEntry entry) {
    if (event.down) {
      pointerId = event.pointer;
    } else if (pointerId == event.pointer) {
      if (size.contains(event.localPosition)) {
        onChanged?.call(!value);
      }
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    Rect rect = offset & size;
    _drawBackground(context, rect);
    _scheduleAnimation();
    // drawRectBg(context, rect);
  }

  void drawRectBg(PaintingContext context, Rect rect) {
    var paint = Paint()
      ..color = Colors.purple;
    context.canvas.drawRect(rect, paint);
  }

  void _drawBackground(PaintingContext context, Rect rect) {
    Color color = value ? fillColor : Colors.grey;
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..strokeWidth
      ..color = color;

    final outer = RRect.fromRectXY(rect, radius, radius);
    var rects = [
      rect.inflate(-strokeWidth),
      Rect.fromCenter(center: rect.center, width: 0, height: 0)
    ];

    var rectProgress = Rect.lerp(rects[0], rects[1], min(progress,bgAnimationInterval) / bgAnimationInterval)!;

    final inner = RRect.fromRectXY(rectProgress, 0, 0);
    context.canvas.drawDRRect(outer, inner, paint);

    // context.canvas.drawRRect(outer, paint);
    
  }

  //执行动画
  void _scheduleAnimation() {
    if (_animationStatus != AnimationStatus.completed) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        print("timeStamp:$timeStamp");
        if (_lastTimeStamp != null) {
          double delta = (timeStamp.inMilliseconds - _lastTimeStamp!)/duration.inMilliseconds;
          print("delta:$delta");
          if (_animationStatus == AnimationStatus.reverse) {
            delta = -delta;
          }

          progress = progress + delta;
          if (progress >= 1 || progress <= 0) {
            _animationStatus = AnimationStatus.completed;
            progress = progress.clamp(0, 1);
          }
        }
        //标记需要重新绘制
        markNeedsPaint();
        _lastTimeStamp = timeStamp.inMilliseconds;
      });
    } else {
      _lastTimeStamp = null;
    }
  }

}