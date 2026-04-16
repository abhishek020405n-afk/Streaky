import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  final SpeechToText _speech = SpeechToText();
  bool _initialized = false;

  Future<bool> initialize() async {
    _initialized = await _speech.initialize(onError: (_) {}, onStatus: (_) {});
    return _initialized;
  }

  Future<String?> listen() async {
    if (!_initialized) {
      final ready = await initialize();
      if (!ready) {
        return null;
      }
    }
    await _speech.listen(localeId: 'en_US');
    return _speech.lastRecognizedWords.isNotEmpty ? _speech.lastRecognizedWords : null;
  }

  Future<void> stop() async {
    await _speech.stop();
  }
}
