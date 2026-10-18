import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/features/home/presentation/widgets/banner_card_widget.dart';

class PromoCarouselWidget extends StatefulWidget {
  const PromoCarouselWidget({super.key, required this.banners});

  final List<HomeBanner> banners;

  @override
  State<PromoCarouselWidget> createState() => _PromoCarouselWidgetState();
}

class _PromoCarouselWidgetState extends State<PromoCarouselWidget> {
  final _controller = PageController(viewportFraction: 0.92);
  final _index = ValueNotifier<int>(0);

  @override
  void dispose() {
    _controller.dispose();
    _index.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.banners.length,
            onPageChanged: (i) => _index.value = i,
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: Dimens.xs),
              child: BannerCardWidget(banner: widget.banners[i]),
            ),
          ),
        ),
        Dimens.gapSm,
        ValueListenableBuilder<int>(
          valueListenable: _index,
          builder: (_, current, __) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < widget.banners.length; i++)
                AnimatedContainer(
                  duration: Dimens.normal,
                  margin: const EdgeInsetsDirectional.symmetric(horizontal: 3),
                  height: 6,
                  width: i == current ? 20 : 6,
                  decoration: BoxDecoration(
                    color: i == current ? scheme.primary : scheme.outline,
                    borderRadius: Dimens.borderPill,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}