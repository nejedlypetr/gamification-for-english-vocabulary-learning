import 'package:audioplayers/audioplayers.dart';
import 'package:english_mind_demo/ui/hooks/utils/use_on_unmount.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void Function(String, {String accent}) usePronunciation() {
  const baseUrl = 'https://api.englishmind.app/';
  final player = useRef(AudioPlayer());

  void play(String sourceFileName, {String accent = 'us'}) {
    player.value.stop();
    player.value.play(UrlSource('$baseUrl$accent/$sourceFileName.mp3'));
  }

  useOnUnmount(() => player.value.dispose());

  return play;
}
