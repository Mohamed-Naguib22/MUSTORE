import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/features/home/presentation/widgets/banner_card_widget.dart';

class PromoCarouselWidget extends StatefulWidget {
  const PromoCarouselWidget({
    super.key,
    required this.banners,
    this.interval = const Duration(seconds: 4),
  });

  final List<HomeBanner> banners;
  final Duration interval;

  @override
  State<PromoCarouselWidget> createState() => _PromoCarouselWidgetState();
}

class _PromoCarouselWidgetState extends State<PromoCarouselWidget> {
  late final PageController _controller;
  final _index = ValueNotifier<int>(0);
  Timer? _timer;

  int get _count => widget.banners.length;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      viewportFraction: 0.92,
      initialPage: _count == 0 ? 0 : _count * 1000,
    );
    _startTimer();
  }

  @override
  void didUpdateWidget(covariant PromoCarouselWidget old) {
    super.didUpdateWidget(old);
    if (old.banners.length != _count || old.interval != widget.interval) {
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    _index.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    if (_count < 2) return;

    _timer = Timer.periodic(widget.interval, (_) {
      if (!mounted || !_controller.hasClients) return;

      _controller.nextPage(duration: Dimens.slow, curve: Curves.easeInOut);
    });
  }

  bool _onScroll(ScrollNotification n) {
    if (n is ScrollStartNotification && n.dragDetails != null) {
      _timer?.cancel();
    } else if (n is ScrollEndNotification) {
      _startTimer();
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (_count == 0) return const SizedBox.shrink();

    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        SizedBox(
          height: 160,
          child: NotificationListener<ScrollNotification>(
            onNotification: _onScroll,
            child: PageView.builder(
              controller: _controller,
              padEnds: false,
              onPageChanged: (i) => _index.value = i % _count,
              itemBuilder: (_, i) => Padding(
                padding: const EdgeInsetsDirectional.only(start: Dimens.lg),
                child: BannerCardWidget(banner: widget.banners[i % _count]),
              ),
            ),
          ),
        ),
        Dimens.gapSm,
        ValueListenableBuilder<int>(
          valueListenable: _index,
          builder: (_, current, __) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < _count; i++)
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