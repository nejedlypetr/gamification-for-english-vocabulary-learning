import 'package:em_widgets/constants/constants.dart';
import 'package:em_widgets/gen/assets.gen.dart';
import 'package:flutter/widgets.dart';

enum CatEmojiSize { s, m, l, xl }

class EmCatEmoji extends StatelessWidget {
  final CatEmoji emoji;
  final CatEmojiSize size;
  final AlignmentGeometry alignment;
  final ColorFilter? colorFilter;

  const EmCatEmoji(
    this.emoji, {
    this.size = CatEmojiSize.m,
    this.alignment = Alignment.center,
    this.colorFilter,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = switch (this.size) {
      CatEmojiSize.s => 32.0,
      CatEmojiSize.m => 48.0,
      CatEmojiSize.l => 64.0,
      CatEmojiSize.xl => 80.0,
    };

    return emoji.asset.svg(
      width: size,
      height: size,
      alignment: alignment,
      package: packageName,
      colorFilter: colorFilter,
      semanticsLabel: 'cat ${emoji.name} emoji',
    );
  }
}

enum CatEmoji {
  angel,
  angry,
  annoyed,
  confused,
  cool,
  cry,
  demon,
  heartEyes,
  hearts,
  lol,
  mask,
  naughty,
  party,
  puke,
  sad,
  shocked,
  shy,
  sleep,
  smile,
  smirk,
  tears,
  think,
  upset,
  wink,
  worry;

  SvgGenImage get asset {
    return switch (this) {
      CatEmoji.angel => Assets.catEmojis.angel,
      CatEmoji.angry => Assets.catEmojis.angry,
      CatEmoji.annoyed => Assets.catEmojis.annoyed,
      CatEmoji.confused => Assets.catEmojis.confused,
      CatEmoji.cool => Assets.catEmojis.cool,
      CatEmoji.cry => Assets.catEmojis.cry,
      CatEmoji.demon => Assets.catEmojis.demon,
      CatEmoji.heartEyes => Assets.catEmojis.heartEyes,
      CatEmoji.hearts => Assets.catEmojis.hearts,
      CatEmoji.lol => Assets.catEmojis.lol,
      CatEmoji.mask => Assets.catEmojis.mask,
      CatEmoji.naughty => Assets.catEmojis.naughty,
      CatEmoji.party => Assets.catEmojis.party,
      CatEmoji.puke => Assets.catEmojis.puke,
      CatEmoji.sad => Assets.catEmojis.sad,
      CatEmoji.shocked => Assets.catEmojis.shocked,
      CatEmoji.shy => Assets.catEmojis.shy,
      CatEmoji.sleep => Assets.catEmojis.sleep,
      CatEmoji.smile => Assets.catEmojis.smile,
      CatEmoji.smirk => Assets.catEmojis.smirk,
      CatEmoji.tears => Assets.catEmojis.tears,
      CatEmoji.think => Assets.catEmojis.think,
      CatEmoji.upset => Assets.catEmojis.upset,
      CatEmoji.wink => Assets.catEmojis.wink,
      CatEmoji.worry => Assets.catEmojis.worry,
    };
  }
}
