import 'package:em_theme/em_theme.dart';
import 'package:flutter/widgets.dart';

class EmWordHighlighter extends StatelessWidget {
  final String text;
  final String word;
  final TextStyle textStyle;
  final TextStyle wordStyle;

  const EmWordHighlighter(
    this.text, {
    required this.word,
    required this.textStyle,
    required this.wordStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final spans = <TextSpan>[];

    final regex = RegExp(
      '(${word.capitalize()})',
      caseSensitive: word == word.capitalize(),
    );

    // Match all words in the text based on the regex
    final matches = regex.allMatches(text);
    var lastMatchEnd = 0;

    for (final match in matches) {
      // Add text before the match with normal style
      if (match.start > lastMatchEnd) {
        spans.add(
          TextSpan(
            text: text.substring(lastMatchEnd, match.start),
            style: textStyle,
          ),
        );
      }

      // Add matched text with highlight style
      spans.add(
        TextSpan(
          text: text.substring(match.start, match.end),
          style: wordStyle,
        ),
      );

      lastMatchEnd = match.end;
    }

    // Add any remaining text after the last match
    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd), style: textStyle));
    }

    return RichText(
      textScaler: context.textScaler,
      text: TextSpan(style: textStyle, children: spans),
    );
  }
}
