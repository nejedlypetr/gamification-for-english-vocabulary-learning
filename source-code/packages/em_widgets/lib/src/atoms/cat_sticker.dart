import 'package:em_widgets/constants/constants.dart';
import 'package:em_widgets/gen/assets.gen.dart';
import 'package:flutter/widgets.dart';

enum CatStickerSize { s, m, l, xl }

class EmCatSticker extends StatelessWidget {
  final CatSticker sticker;
  final CatStickerSize size;
  final AlignmentGeometry alignment;
  final ColorFilter? colorFilter;

  const EmCatSticker(
    this.sticker, {
    this.size = CatStickerSize.m,
    this.alignment = Alignment.center,
    this.colorFilter,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = switch (this.size) {
      CatStickerSize.s => 64.0,
      CatStickerSize.m => 96.0,
      CatStickerSize.l => 128.0,
      CatStickerSize.xl => 160.0,
    };

    return sticker.asset.svg(
      width: size,
      height: size,
      alignment: alignment,
      package: packageName,
      colorFilter: colorFilter,
      semanticsLabel: 'cat ${sticker.name} sticker',
    );
  }
}

enum CatSticker {
  diploma,
  geography,
  sunbathing;

  SvgGenImage get asset {
    return switch (this) {
      CatSticker.diploma => Assets.catStickers.diploma,
      CatSticker.geography => Assets.catStickers.geography,
      CatSticker.sunbathing => Assets.catStickers.sunbathing,
    };
  }
}
