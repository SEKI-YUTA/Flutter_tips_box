import 'package:flutter/material.dart';

class ParallaxListHorizontalScreen extends StatelessWidget {
  const ParallaxListHorizontalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ParallaxListItem(
                name: "Some where",
                country: "earth",
                imageName: "assets/image2.jpg"),
            ParallaxListItem(
                name: "Some where",
                country: "earth",
                imageName: "assets/image2.jpg"),
            ParallaxListItem(
                name: "Some where",
                country: "earth",
                imageName: "assets/image2.jpg"),
            ParallaxListItem(
                name: "Some where",
                country: "earth",
                imageName: "assets/image2.jpg"),
          ],
        ),
      ),
    );
  }
}

class ParallaxListItem extends StatelessWidget {
  ParallaxListItem(
      {Key? key,
      required this.name,
      required this.country,
      required this.imageName})
      : super(key: key);
  final GlobalKey _backgroundImageKey = GlobalKey();
  final String name;
  final String country;
  final String imageName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                _buildBackground(context),
                _buildGradient(),
                _buildContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackground(BuildContext context) {
    return Flow(
        delegate: ParallaxFlowDelegate(
            scrollable: Scrollable.of(context)!,
            listItemContext: context,
            backgroundImageKey: _backgroundImageKey),
        children: [
          Image.asset(
            "assets/image2.jpg",
            fit: BoxFit.cover,
            key: _backgroundImageKey,
          )
        ]);
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.6, 0.95])),
      ),
    );
  }

  Widget _buildContent() {
    return Positioned(
      left: 20,
      bottom: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            country,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          )
        ],
      ),
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate(
      {required this.scrollable,
      required this.listItemContext,
      required this.backgroundImageKey})
      : super(repaint: scrollable.position);

  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    // 画像の大きさを設定している
    // return BoxConstraints.tightFor(width: constraints.maxWidth);
    return BoxConstraints.tightFor(height: constraints.maxHeight);
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size.centerLeft(Offset.zero),
        ancestor: scrollableBox);
    // print("listItemOffset: ${listItemOffset}");
    // スクロールアイテムがどの位置にあるかをパーセントへ変換している
    // scrollable.positionはどれだけスクロールできるかなどの情報が入っている
    // Rowで作ると横スクロールの情報Columnで作ると縦スクロールの情報が入ってくる
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
        (listItemOffset.dx / viewportDimension).clamp(0.0, 1.0);
    // print("scrollable.position: ${scrollable.position}");
    // print("scrollFraction: ${scrollFraction}");

    final horizontalAlignment = Alignment(scrollFraction * 2 - 1, 0.0);
    print("result: ${horizontalAlignment}");

    final backgroundSize =
        (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
            .size;
    print("backgroundSize: ${backgroundSize}");
    final listItemSize = context.size;
    print("listItemSize: ${listItemSize}");
    final childRect = horizontalAlignment.inscribe(
        backgroundSize, Offset.zero & listItemSize);
    print(Offset.zero & listItemSize);
    print("childRect: ${childRect}");
    print("childRect.top: ${childRect.top}");

    context.paintChild(0,
        transform:
            Transform.translate(offset: Offset(childRect.left, 0.0)).transform);
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}
