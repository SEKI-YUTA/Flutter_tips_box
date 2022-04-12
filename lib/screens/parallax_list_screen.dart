import 'package:flutter/material.dart';

class ParallaxListScreen extends StatelessWidget {
  const ParallaxListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ParallaxListItem(
                name: "Some where",
                country: "earth",
                imageUrl:
                    "https://images.unsplash.com/photo-1649329409377-b91999d1c298?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80"),
            ParallaxListItem(
                name: "Some where",
                country: "earth",
                imageUrl:
                    "https://images.unsplash.com/photo-1649329409377-b91999d1c298?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80"),
            ParallaxListItem(
                name: "Some where",
                country: "earth",
                imageUrl:
                    "https://images.unsplash.com/photo-1649329409377-b91999d1c298?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80"),
            ParallaxListItem(
                name: "Some where",
                country: "earth",
                imageUrl:
                    "https://images.unsplash.com/photo-1649329409377-b91999d1c298?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80"),
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
      required this.imageUrl})
      : super(key: key);
  final GlobalKey _backgroundImageKey = GlobalKey();
  final String name;
  final String country;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }

  Widget _buildBackground(BuildContext context) {
    return Flow(
        delegate: ParallaxFlowDelegate(
            scrollable: Scrollable.of(context)!,
            listItemContext: context,
            backgroundImageKey: _backgroundImageKey),
        children: [
          Image.network(
            imageUrl,
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
    return BoxConstraints.tightFor(width: constraints.maxWidth);
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size.centerLeft(Offset.zero),
        ancestor: scrollableBox);
    // スクロールアイテムがどの位置にあるかをパーセントへ変換している
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
        (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);
    //

    // アイテムの位置をもとに背景の位置を計算
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    final backgroundSize =
        (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect =
        verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);
    print("childRect: ${childRect}");
    context.paintChild(0,
        transform:
            Transform.translate(offset: Offset(0.0, childRect.top)).transform);
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}
