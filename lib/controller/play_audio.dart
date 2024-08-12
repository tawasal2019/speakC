import 'package:just_audio/just_audio.dart';

Future<void> _playAudio(String ThePath) async {
  AudioPlayer _audioPlayer = AudioPlayer();

  try {
    // Get the directory where the file is located
    /*final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/flutter_audio_recorder_1721562720575.aac';*/

    // Check if the file exists
    if (ThePath!="") {
      // Set the URL for the local file
      await _audioPlayer.setFilePath(ThePath);

      // Start playback
      _audioPlayer.play();
      print('Playback successful');
    } else {
      print('File does not exist');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
}

