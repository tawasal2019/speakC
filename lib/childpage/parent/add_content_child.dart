import 'dart:async';
import 'dart:io' as io;
import 'dart:io';

import 'package:arabicchildandroid/childpage/parent/main_parent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:record/record.dart';

import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/error_alert.dart';
import '../../controller/images.dart';
import '../../controller/is_tablet.dart';
import '../../controller/lib_to_string.dart';
import '../../controller/my_provider.dart';
import '../../controller/permission_handle.dart';
import '../../controller/var.dart';
import '../../icon/icons_group.dart';
import '../../model/content.dart';
import '../../model/library.dart';

class AddContentChild extends StatefulWidget {
  final int libraryindex;

  const AddContentChild({super.key, required this.libraryindex});

  @override
  State<AddContentChild> createState() => _AddContentChildState();
}

class _AddContentChildState extends State<AddContentChild> {
  //parametr text fild//
  TextEditingController textController = TextEditingController();
  //parameter text fild//

  //parameter Record your voice //
  String message = "";
  final AudioRecorder _recorder = AudioRecorder();
  bool _isRecording = false;

  bool isRecordPermision = false;
  Timer? _timer; // Timer to update recording duration
  int _recordingDuration = 0; // Recording duration in seconds
  AudioPlayer _audioPlayer = AudioPlayer();
  bool _isVoiceUploadByUser = false;
  String? _audioPath;
  String? _audioUrl;
  //parameter Record your voice //

  //parameter Delete Button//
  bool deleteButtonClicked = false;
  //End parameter Delete Button//
// display hint message parameter//
  bool hint = true;
  //End display hint message parameter//

  //display error message parameter//
  bool errorsen = false;
  bool errorImage = false;
  String imageMessageError = "";
  //End display error message parameter//

  //image Parameter//
  String imPath = "";
  bool isImageUpload = false;
  //End image Parameter//

  //

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MyProvider>(context, listen: false).setPath("");
    });
    super.initState();
    AudioPermission();
  }

  AudioPermission() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      String text =
          "يريد تطبيق تحدث السماح بتسجيل مقاطع صوتيه لاستخدامها داخل التطبيق او إمكانية مشاركتها لاحقا";
      showPermissionsDeniedDialog(context, text, true);
    } else {
      print('Microphone permission granted.');
      setState(() {
        isRecordPermision = true;
      });
    }
  }

  ////startRecording function////
  Future startRecording() async {
    if (!isRecordPermision) {
      AudioPermission();
    }
    String customPath = '/flutter_audio_recorder_';
    Directory? appDocDirectory;
    if (Platform.isIOS) {
      appDocDirectory = await getApplicationDocumentsDirectory();
      print(appDocDirectory.path);
    } else {
      appDocDirectory = await getExternalStorageDirectory();
      print(appDocDirectory?.path);
    }
    String fileName = 'recording_${DateTime.now().millisecondsSinceEpoch}.m4a';

    if (appDocDirectory != null) {
      customPath = appDocDirectory.path + customPath + fileName;
      print(customPath);
      try {
        // Define the configuration for the recording
        const config = RecordConfig(
          // Specify the format, encoder, sample rate, etc., as needed
          encoder: AudioEncoder.aacLc, // For example, using AAC codec
          sampleRate: 44100, // Sample rate
          bitRate: 128000, // Bit rate
        );

        // Start recording to file with the specified configuration
        await _recorder.start(config, path: customPath!);
        setState(() {
          _isRecording = true;
        });
      } catch (e) {
        print('Error starting recording: $e');
      }
    }
  }
//// End startRecording function////

  ///stopRecording function////
  Future stopRecording() async {
    if (!isRecordPermision) {
      print('Recorder is not initialized or is null');
      return;
    }

    try {
      print('Stopping recording...');
      final path = await _recorder.stop();
      setState(() {
        _isRecording = false;
      });
      // _timer?.cancel();

      if (path != null) {
        Provider.of<MyProvider>(context, listen: false).addAudioPath(path);
        setState(() {
          _audioPath = path!;
          _isVoiceUploadByUser = true;
        });

        print('Recording saved to: ${path}');
      } else {
        print('Recording result is null.');
      }
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  ///End stopRecording function////

////dispose Function////
  @override
  void dispose() {
    _recorder.dispose();
    _timer?.cancel(); // Cancel the timer when disposing
    _audioPlayer.dispose();

    super.dispose();
  }
  ////End dispose Function////

////_playAudio Function////
  Future<void> _playAudio(String ThePath) async {
    AudioPlayer _audioPlayer = AudioPlayer();

    try {
      // Get the directory where the file is located
      /*final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/flutter_audio_recorder_1721562720575.aac';*/

      // Check if the file exists
      if (ThePath != "") {
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
////End _playAudio Function////

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          //المفروض يكون هو والي وراه موحد او فيه على الاقل طريقة للعودة
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body:
              // whole view column//
              Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text title"Add sentence"//
              Padding(
                padding: const EdgeInsets.only(bottom: 45),
                child: Text(
                  "إضافة جملة",
                  style: TextStyle(
                      fontSize: DeviceUtil.isTablet ? 45 : 30,
                      fontWeight: FontWeight.w900,
                      color: maincolor),
                ),
              ),
              // Text title"Add sentence"//

              //  padding between Text "add sentence" and the lare box  //
              Padding(
                padding: EdgeInsets.only(
                    left: DeviceUtil.isTablet ? 40 : 15,
                    right: DeviceUtil.isTablet ? 40 : 15,
                    bottom: 22),
                child:
                    //the Large box//
                    Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: greyColor, width: 1),
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(255, 255, 255,
                              255) // Color.fromARGB(255, 121, 161, 134)
                          .withOpacity(.4)),
                  child:
                      //padding between the largest box and colum that contain all element inside this box//
                      Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 20),
                    child:
                        //Column that contain all element inside this box//
                        Column(
                      children: [
                        //TextField //
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Container(
                            height: DeviceUtil.isTablet ? 97 : 70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextField(
                              onChanged: (value) {
                                if (textController.text.isNotEmpty) {
                                  setState(() {
                                    errorsen = false;
                                  });
                                }
                              },
                              controller: textController,
                              maxLines: 3,
                              cursorColor: maincolor,
                              decoration: InputDecoration(
                                labelText: "اكتب جملة لا تتجاوز ست كلمات",
                                labelStyle: TextStyle(
                                    fontSize: DeviceUtil.isTablet ? 24 : 18,
                                    fontWeight: FontWeight.bold,
                                    color: maincolor),
                                enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Color.fromARGB(
                                            255, 123, 123, 123))),
                                focusedBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.grey)),
                              ),
                            ),
                          ),
                        ),
                        // End TextField //

                        //padding between first element Text fild and second element Row//
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child:
                              //Row element "  مسح", "صورة  ", " تسجيل صوتي"//
                              Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // voice recorder button//
                              //voice Recording by user
                              Provider.of<MyProvider>(context)
                                      .lastAudioPath
                                      .toString()
                                      .isEmpty
                                  ? InkWell(
                                      onTap: () async {
                                        setState(() {
                                          message =
                                              "سيتم نطق الجملة بواسطة الصوت الخاص بك";
                                        });
                                        print(_audioPath);
                                        if (isRecordPermision == false) {
                                          AudioPermission();
                                        } else {
                                          print(_isRecording);
                                          if (_isRecording) {
                                            stopRecording();
                                          } else {
                                            startRecording();
                                          }
                                        }
                                      },
                                      child: Container(
                                        height: DeviceUtil.isTablet ? 100 : 80,
                                        width: DeviceUtil.isTablet ? 100 : 80,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: greyColor, width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: const Color.fromARGB(
                                                    255,
                                                    255,
                                                    255,
                                                    255) // Color.fromARGB(255, 121, 161, 134)
                                                .withOpacity(.4)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              _isRecording

                                                  //isRecorderNow==true
                                                  ? Icon(
                                                      Icons.stop,
                                                      size: DeviceUtil.isTablet
                                                          ? 40
                                                          : 20,
                                                      color: Colors.red,
                                                    )
                                                  : Icon(Icons.mic,
                                                      size: DeviceUtil.isTablet
                                                          ? 40
                                                          : 20,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              132,
                                                              132,
                                                              132)),
                                              _isRecording

                                                  //isRecorderNow==true
                                                  ? FittedBox(
                                                      child: Text(
                                                        ' $_recordingDuration s',
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    132,
                                                                    132,
                                                                    132),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      ),
                                                    )
                                                  : const FittedBox(
                                                      child: Text(
                                                        "تسجيل صوتي",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    132,
                                                                    132,
                                                                    132),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  //after user voice recording  (الغاء التسجيل)
                                  : InkWell(
                                      onTap: () {
                                        setState(() {
                                          message =
                                              "سيتم نطق الجملة بواسطة المتحدث العربي    ";
                                          _audioPath = "";
                                          /*_audioPath = result.path!;
        _isVoiceUploadByUser = true;*/

                                          _recordingDuration = 0;
                                          //isRecorderNow=false;
                                          //voiceRecordButton = "";
                                        });
                                      },
                                      child: Container(
                                        height: DeviceUtil.isTablet ? 100 : 80,
                                        width: DeviceUtil.isTablet ? 100 : 80,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: greyColor, width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: const Color.fromARGB(
                                                    255,
                                                    255,
                                                    255,
                                                    255) // Color.fromARGB(255, 121, 161, 134)
                                                .withOpacity(.4)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.restart_alt,
                                                color: const Color.fromARGB(
                                                    255, 132, 132, 132),
                                                size: DeviceUtil.isTablet
                                                    ? 60
                                                    : 40),
                                            const FittedBox(
                                              child: Text(
                                                "إلغاء التسجيل",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 132, 132, 132),
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),

                              //End voice recorder button //
                              ElevatedButton(
                                  onPressed: () {
                                    if (Provider.of<MyProvider>(context,
                                            listen: false)
                                        .lastAudioPath
                                        .toString()
                                        .isNotEmpty) {
                                      _playAudio(_audioPath!);
                                    } else {
                                      print(
                                          "there is no saved audio. record first");
                                    }
                                  },
                                  child: Text("استماع")),

                              //----------------------------------------//
                              //space between VoiceRecordButton and ImageButton//
                              Container(
                                width: 30,
                              ),
                              //End space between VoiceRecordButton and ImageButton//
                              // ---------------------------------------//
                              Provider.of<MyProvider>(context)
                                      .lastimagepath
                                      .toString()
                                      .isNotEmpty
                                  ? InkWell(
                                      onTap: () => diag(),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 31),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: greyColor, width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: const Color.fromARGB(
                                                      255,
                                                      255,
                                                      255,
                                                      255) // Color.fromARGB(255, 121, 161, 134)
                                                  .withOpacity(.4)),
                                          height:
                                              DeviceUtil.isTablet ? 100 : 80,
                                          width: DeviceUtil.isTablet ? 100 : 80,
                                          child: getImage(
                                              Provider.of<MyProvider>(context)
                                                  .lastimagepath
                                                  .toString()),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              Container(
                                width: Provider.of<MyProvider>(context)
                                        .lastimagepath
                                        .toString()
                                        .isNotEmpty
                                    ? 0
                                    : 30,
                              ),
                              Provider.of<MyProvider>(context)
                                      .lastimagepath
                                      .toString()
                                      .isEmpty
                                  ? InkWell(
                                      onTap: () => diag(),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: greyColor, width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: const Color.fromARGB(
                                                    255,
                                                    255,
                                                    255,
                                                    255) // Color.fromARGB(255, 121, 161, 134)
                                                .withOpacity(.4)),
                                        height: DeviceUtil.isTablet ? 100 : 80,
                                        width: DeviceUtil.isTablet ? 100 : 80,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.add_a_photo,
                                                  color: const Color.fromARGB(
                                                      255, 132, 132, 132),
                                                  size: DeviceUtil.isTablet
                                                      ? 40
                                                      : 20),
                                              const Text(
                                                "صورة",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 132, 132, 132),
                                                    fontWeight:
                                                        FontWeight.w800),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              /*
                              //Image Button//
                              //if there no image choosing//

                              isImageUpload == false
                                  ? InkWell(
                                      onTap: () => diag(),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: greyColor, width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: const Color.fromARGB(
                                                    255,
                                                    255,
                                                    255,
                                                    255) // Color.fromARGB(255, 121, 161, 134)
                                                .withOpacity(.4)),
                                        height: DeviceUtil.isTablet ? 100 : 80,
                                        width: DeviceUtil.isTablet ? 100 : 80,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.add_a_photo,
                                                  color: const Color.fromARGB(
                                                      255, 132, 132, 132),
                                                  size: DeviceUtil.isTablet
                                                      ? 40
                                                      : 20),
                                              const Text(
                                                "صورة",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 132, 132, 132),
                                                    fontWeight:
                                                        FontWeight.w800),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () => diag(),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 31),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: greyColor, width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: const Color.fromARGB(
                                                      255,
                                                      255,
                                                      255,
                                                      255) // Color.fromARGB(255, 121, 161, 134)
                                                  .withOpacity(.4)),
                                          height:
                                              DeviceUtil.isTablet ? 100 : 80,
                                          width: DeviceUtil.isTablet ? 100 : 80,
                                          child: getImage(imPath),
                                          /*Provider.of<MyProvider>(context)
                                            .lastimagepath
                                            .toString()),*/
                                        ),
                                      ),
                                    ),
                              //End if there no image choosing//

                              //End Image Button//
                              //--------------------------------------//
                              */
                              //space between Image Button//
                              Container(
                                width: 30,
                              ),
                              //End between Image Button//

                              //Delete Button//
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      deleteButtonClicked = true;
                                    });
                                    Future.delayed(const Duration(seconds: 1))
                                        .then((value) {
                                      setState(() {
                                        deleteButtonClicked = false;
                                      });
                                    });
                                    textController.clear();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: greyColor, width: 1.5),
                                        borderRadius: BorderRadius.circular(15),
                                        color: const Color.fromARGB(
                                                255,
                                                255,
                                                255,
                                                255) // Color.fromARGB(255, 121, 161, 134)
                                            .withOpacity(.4)),
                                    height: DeviceUtil.isTablet ? 100 : 80,
                                    width: DeviceUtil.isTablet ? 100 : 80,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.delete_outline,
                                              color: deleteButtonClicked
                                                  ? Colors.red
                                                  : const Color.fromARGB(
                                                      255, 132, 132, 132),
                                              size: DeviceUtil.isTablet
                                                  ? 40
                                                  : 20),
                                          Text(
                                            "مسح",
                                            style: TextStyle(
                                                color: deleteButtonClicked
                                                    ? Colors.red
                                                    : const Color.fromARGB(
                                                        255, 132, 132, 132),
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),

                              //End Delete Button//
                            ],
                          ),
                          //End Row element "  مسح", "صورة  ", " تسجيل صوتي"//
                        ),
                        //End padding between first element Text fild and second element Row//
                      ],
                    ),
                    //End Column that contain all element inside the larger box//
                  ),

                  //End padding between the largest box and colum that contain all element inside this box//
                ),
                //End the Large box//
              ),
              //End  padding between Text "add sentence" and the large box  //

              //display hint messages//
              hint
                  ? Padding(
                      padding:
                          const EdgeInsets.only(top: 3, right: 33, bottom: 10),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 238, 237, 237),
                          shape: BoxShape.rectangle,
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    hint = false;
                                  });
                                },
                                child: const Icon(Icons.close),
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: maincolor,
                                  size: 16,
                                ),
                                Text(
                                  message,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: DeviceUtil.isTablet ? 16 : 14),
                                ),
                              ],
                            ),
                            Container(
                              height: 18,
                            )
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(),
              //End display hint messages//

              //display error messages//
              errorsen
                  ? Padding(
                      padding:
                          const EdgeInsets.only(top: 3, right: 33, bottom: 10),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                          Text(
                            " يجب ادخال جملة  ",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: DeviceUtil.isTablet ? 20 : 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
              //End display error messages//
              //Error message for image//
              errorImage
                  ? Padding(
                      padding:
                          const EdgeInsets.only(top: 3, right: 33, bottom: 10),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                          Text(
                            " يجب ادخال صورة  ",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: DeviceUtil.isTablet ? 20 : 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
              //End display error messages//
              //End error message for image//

              //space between the larger box and '"save" " الغاء " button//
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Padding(
                  padding: DeviceUtil.isTablet
                      ? const EdgeInsets.only(right: 10)
                      : const EdgeInsets.only(right: 10.0),
                  child: SizedBox(
                    height: DeviceUtil.isTablet ? 65 : 50,
                    width: DeviceUtil.isTablet ? 220 : 160,
                    child: InkWell(
                      onTap: () async {
                        if (textController.text.trim().isEmpty) {
                          setState(() {
                            errorsen = true;
                          });
                        } else if (imPath == "") {
                          setState(() {
                            errorImage = true;
                          });
                        } else {
                          String imgUpload = "true";
                          String voiceUpload = "true";
                          if (Provider.of<MyProvider>(context, listen: false)
                                  .lastimagepath
                                  .toString()
                                  .isEmpty ||
                              Provider.of<MyProvider>(context, listen: false)
                                  .lastimagepath
                                  .toString()
                                  .contains("assets/")) {
                            print(imPath);
                            imgUpload = "false";
                            print(imgUpload);
                          }
                          // if (result == null) voiceUpload = false;

                          print(_audioPath);
                          libraryListChild[widget.libraryindex].contenlist.add(
                              Content(
                                  textController.text,
                                  imPath,
                                  imgUpload,
                                  _audioPath ?? "",
                                  _audioUrl ?? "",
                                  voiceUpload));
                          SharedPreferences liblist =
                              await SharedPreferences.getInstance();
                          List<String> v = [];
                          for (lib l in libraryListChild) {
                            String s = convertLibString(l);
                            print(s);
                            v.add(s);
                          }

                          liblist.setStringList("liblistChild", v);
                          //tryUploadDataChild();

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainParentPage(
                                        index: 1,
                                      )),
                              (route) => false);
                          //Navigator.pop(context);

                          Provider.of<MyProvider>(context, listen: false)
                              .setPath("");
                          acceptAlert(context, "تم إضافة المحتوى بنجاح");
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                            color: maincolor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text(
                          'حفظ',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: SizedBox(
                    height: DeviceUtil.isTablet ? 65 : 50,
                    width: DeviceUtil.isTablet ? 220 : 160,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainParentPage(
                                      index: 1,
                                    )),
                            (route) => false);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                            color: maincolor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text(
                          'إلغاء',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
              //End space between the larger box and '"save" " الغاء " button//
            ],
          ),
          //End whole view column//
        ));
  }

  diag() {
    return showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                  child: const Text(
                    "الكاميرا",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    _checkPermissionAndCamera(ImageSource.camera);
                  }),
              CupertinoDialogAction(
                child: const Text(" الاستديو",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  /*checkGallaryPermissionStatus().then((reslut){
                    isGallaryPermissioned=reslut;
                    print("result after called checkMGallaryPermissionStatus is $reslut");
                    print("isGallaryPermissioned is  $isGallaryPermissioned" );
                  });
                  if(isGallaryPermissioned==false){
                    requestGallaryPermission(context);
                    //showPermissionsDeniedDialog(context,"يريد تطبيق تحدث السماح بالدخول لمعرض الصور لإضافة الصور لاستخدامها داخل التطبيق او إمكانية مشاركتها لاحقا",true);
                    //Navigator.pop(context);
                  }*/
                  Navigator.pop(context);
                  checkPermissionAndPickImage(ImageSource.gallery);

                  //  Navigator.pop(context);
                  // pickImage(ImageSource.gallery);
                },
              ),
              CupertinoDialogAction(
                child: const Text("مكتبة الايقونات",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const IconGroups()));
                },
              ),
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                  child: const Text('إلغاء',
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold))),
            ],
          );
        });
  }

  //permission for camera
  Future<void> _checkPermissionAndCamera(ImageSource source) async {
    PermissionStatus status = await Permission.camera.status;
    if (status.isGranted) {
      // Permission already granted
      await pickImage(source);
    } else if (status.isDenied) {
      // Request permission if not already granted
      await Permission.camera.request();
      if (await Permission.camera.isGranted) {
        await pickImage(source);
      }
    } else {
      // Permission denied, show snackbar/dialog to open settings
      var text =
          "يريد تطبيق تحدث السماح بالدخول للكاميرا لاضافة الصور لاستخدامها داخل التطبيق او إمكانية مشاركتها لاحقا";
      showPermissionsDeniedDialog(context, text, true);
    }
  }

  //permission for gallary
  Future<void> checkPermissionAndPickImage(ImageSource source) async {
    PermissionStatus status = await Permission.photos.status;
    if (status.isGranted) {
      await pickImage(source);
    } else if (status.isDenied) {
      await Permission.photos.request();
      if (await Permission.photos.isGranted) {
        await pickImage(source);
      }
    } else {
      // Permission denied, show snackbar/dialog to open settings
      var text =
          "يريد تطبيق تحدث السماح بالدخول لمعرض الصور لإضافة الصور لاستخدامها داخل التطبيق او إمكانية مشاركتها لاحقا";
      showPermissionsDeniedDialog(context, text, true);
    }
  }

  //To pick an image either from camera or gallary
  Future pickImage(ImageSource source) async {
    print("pickImage MEthod");
    try {
      print("inside try ");
      final im = await ImagePicker().pickImage(source: source);
      if (im == null) {
        print('please select an image');
        setState(() {
          isImageUpload = false;
          errorImage = true;
        });
        return;
      } else {
        Provider.of<MyProvider>(context, listen: false).setPath(im.path);
        print(im.path);
        imPath = im.path;
        setState(() {
          isImageUpload = true;
        });
      }
    } on PlatformException {
      ///////////edit heeeeeeeeeeeeeeeeeeeeeeeeere
      return;
    }
  }
}
