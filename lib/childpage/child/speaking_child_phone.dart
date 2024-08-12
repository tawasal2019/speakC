// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:get/get_connect/http/src/utils/utils.dart';

import 'speaking_child_tablet.dart';
import '/controller/harakat_prediction.dart';
import '/controller/real_time.dart';
import 'package:provider/provider.dart';

import 'package:share_plus/share_plus.dart';
//import 'package:just_audio/just_audio.dart';

import '../../controller/error_alert.dart';
import '../../controller/my_provider.dart';
import '../../model/library_to_choose.dart';
import '/childpage/constant.dart';
import '/controller/images.dart';
import '/controller/speak.dart';
import '/controller/upload_data_child.dart';
import '/controller/var.dart';
import '/model/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/content.dart';
import 'package:just_audio/just_audio.dart';

class SpeakingChildPhone extends StatefulWidget {
  const SpeakingChildPhone({super.key});

  @override
  State<SpeakingChildPhone> createState() => _SpeakingChildPhoneState();
}

class _SpeakingChildPhoneState extends State<SpeakingChildPhone> {
  // AudioPlayer _audioPlayer = AudioPlayer();
  //bool _isPlaying = false;
  int coloredOpenLibraryindex = 0;
  late List<List<String>> predictionWords;
  List<Content> fieldContent = [];
  List<Content> contentWord = [];
  List<String> LocalDB = [];
  List<String> fav = [];
  TextEditingController controller = TextEditingController();
  final controllerList = ScrollController();
  final controllerList2 = ScrollController();
  final contentWordController = ScrollController();
  double currentOffsetScroll = 0;
  double currentOffsetScroll2 = 0;
  bool isLoading = true;
  bool isFav = false;
  late bool speakingWordByWord;
  bool isLess = false;
  late int size;
  double _scrollOffset = 0;

  @override
  void initState() {
    contentWordController.addListener(() {
      double v = contentWordController.offset / (fieldContent.length * 50);
      setState(() {
        _scrollOffset = v < 0
            ? 0
            : v >= 1
                ? 1
                : v;
      });
    });

    getFavData();
    getLocalDB();
    getData().then((v) {
      contentWord =
          libraryListChild.isNotEmpty ? libraryListChild[0].contenlist : [];
      setState(() {
        isLoading = false;
      });
    });
    tryUploadDataChild();

    super.initState();
  }

  getData() async {
    List<List<String>> p = [];
    for (var element in librarywordChild[0].contenlist) {
      p.add([element.nameContent, element.imageURL]);
    }
    predictionWords = p;
    /////////////////////////////////
    SharedPreferences liblistChild = await SharedPreferences.getInstance();
    size = liblistChild.getInt("size") ?? 1;

    List<String>? library = liblistChild.getStringList("liblistChild");
    if (library != null) {
      for (String element in library) {
        List e = json.decode(element);
        List<Content> contentlist = [];
        for (List l in e[3]) {
          contentlist.add(Content(l[0], l[1], l[2], l[3], l[4], l[5]));
        }
        libraryListChild.add(lib(e[0], e[1], e[2], contentlist));
      }
    } else {
      libraryListChild = chooseLibrary;
    }
    speakingWordByWord = liblistChild.getBool("switchValue") ?? true;
  }

  getFavData() async {
    SharedPreferences favlist = await SharedPreferences.getInstance();
    var tem = favlist.getStringList("favlistChild");
    if (tem != null) {
      for (var element in tem) {
        List test = json.decode(element);
        String a = "";
        for (var element2 in test) {
          a += element2[0] + " ";
        }
        fav.add(a.trim());
      }
    }
  }

  /*
  Future<void> _playAudio(String ThePath) async {
    //AudioPlayer _audioPlayer = AudioPlayer();

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
*/
  Future<void> _playAudio(String ThePath) async {
    AudioPlayer _audioPlayer = AudioPlayer();

    try {
      // Check if the file exists
      if (ThePath != "") {
        print('Playing audio from path: $ThePath');

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

  getLocalDB() async {
    SharedPreferences LocalChild = await SharedPreferences.getInstance();
    List list = LocalChild.getStringList("LocalChild") ?? [];
    for (var element in list) {
      LocalDB.add(element);
    }
  }

  storeInLocal(String Text) async {
    Text = Text.trim();
    Text = Text.replaceAll("  ", " ");
    SharedPreferences localChild = await SharedPreferences.getInstance();
    if (!LocalDB.contains(Text)) {
      LocalDB.add(Text);
      localChild.setStringList("LocalChild", LocalDB);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          extendBodyBehindAppBar: true,
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: Column(
                    children: [
                      //appbar
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 10, top: 8, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () => Scaffold.of(context).openDrawer(),
                              child: Image.asset(
                                "assets/uiImages/drawer.png",
                                height: 24,
                              ),
                            ),
                            Text(
                              "اختر الكلمات",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: pinkColor),
                            ),
                            Text(
                              "         ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: pinkColor),
                            )
                          ],
                        ),
                      ),

                      ////////////
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5, left: 5),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      bool t = Provider.of<MyProvider>(context,
                                              listen: false)
                                          .isSpeakingNow;
                                      if (!t) {
                                        if (controller.text.trim().isNotEmpty) {
                                          setState(() {
                                            fieldContent.add(Content(
                                                controller.text.trim(),
                                                "",
                                                "false",
                                                "",
                                                "",
                                                "false"));
                                          });
                                          if (fieldContent.length > 5) {
                                            contentWordController.animateTo(
                                                contentWordController.position
                                                        .maxScrollExtent -
                                                    200,
                                                duration: const Duration(
                                                    milliseconds: 750),
                                                curve: Curves.easeOut);
                                          }

                                          controller.clear();
                                        }
                                        //speak
                                        String a = "";
                                        for (var element in fieldContent) {
                                          a += "${element.nameContent} ";
                                        }

                                        if (fav.contains(a.trim())) {
                                          setState(() {
                                            isFav = true;
                                          });
                                        } else {
                                          setState(() {
                                            isFav = false;
                                          });
                                        }
                                        if (controller.text.trim().isNotEmpty) {
                                          predict(a
                                              .replaceAll("أ", "ا")
                                              .replaceAll("إ", "ا")
                                              .replaceAll("ة", "ه"));
                                        }
                                        howToSpeak(a, context);
                                        storeInLocal(a);
                                        tryUploadToRealTimeForChild(a);
                                      }
                                    },
                                    child: Container(
                                        height: size == 0 ? 112 : 106,
                                        width: 45,
                                        decoration: BoxDecoration(
                                          color: Provider.of<MyProvider>(
                                                      context,
                                                      listen: true)
                                                  .isSpeakingNow
                                              ? pinkColor.withOpacity(.6)
                                              : pinkColor,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                                spreadRadius: 3,
                                                blurRadius: 5,
                                                offset: const Offset(0, 3)),
                                          ],
                                          border: Border.all(
                                            width: 2,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/uiImages/volume.png",
                                              height: 35,
                                              color: Colors.white,
                                            ),
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(top: 8.0),
                                              child: Text(
                                                "نطق",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                  Container(
                                    width: 3,
                                  ),
                                  Expanded(
                                      child: InkWell(
                                    onTap: () async {
                                      bool t = Provider.of<MyProvider>(context,
                                              listen: false)
                                          .isSpeakingNow;
                                      if (!t) {
                                        if (controller.text.trim().isNotEmpty) {
                                          setState(() {
                                            fieldContent.add(Content(
                                                controller.text.trim(),
                                                "",
                                                "false",
                                                "",
                                                "",
                                                "false"));
                                          });
                                          if (fieldContent.length > 5) {
                                            contentWordController.animateTo(
                                                contentWordController.position
                                                        .maxScrollExtent -
                                                    200,
                                                duration: const Duration(
                                                    milliseconds: 750),
                                                curve: Curves.easeOut);
                                          }

                                          controller.clear();
                                        }
                                        //speak
                                        String a = "";
                                        for (var element in fieldContent) {
                                          a += "${element.nameContent} ";
                                        }

                                        if (fav.contains(a.trim())) {
                                          setState(() {
                                            isFav = true;
                                          });
                                        } else {
                                          setState(() {
                                            isFav = false;
                                          });
                                        }
                                        if (controller.text.trim().isNotEmpty) {
                                          predict(a
                                              .replaceAll("أ", "ا")
                                              .replaceAll("إ", "ا")
                                              .replaceAll("ة", "ه"));
                                        }
                                        howToSpeak(a, context);
                                        storeInLocal(a);
                                        tryUploadToRealTimeForChild(a);
                                      }
                                    },
                                    child: Container(
                                      height: size == 0 ? 112 : 106,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffe9edf3),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 3,
                                              blurRadius: 5,
                                              offset: const Offset(0, 3)),
                                        ],
                                        border: Border.all(
                                          width: 2,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Row(
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: InkWell(
                                                onTap: () {
                                                  // clear
                                                  if (fieldContent.isNotEmpty) {
                                                    if (fieldContent.length ==
                                                        1) {
                                                      List<List<String>> main =
                                                          [];
                                                      for (var element
                                                          in librarywordChild[0]
                                                              .contenlist) {
                                                        main.add([
                                                          element.nameContent,
                                                          element.imageURL
                                                        ]);
                                                      }
                                                      setState(() {
                                                        predictionWords = main;
                                                        fieldContent = [];
                                                        isFav = false;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        fieldContent.removeAt(
                                                            fieldContent
                                                                    .length -
                                                                1);
                                                      });
                                                      String text = "";
                                                      for (var element
                                                          in fieldContent) {
                                                        text +=
                                                            "${element.nameContent} ";
                                                      }
                                                      predict(text
                                                          .replaceAll("أ", "ا")
                                                          .replaceAll("إ", "ا")
                                                          .replaceAll(
                                                              "ة", "ه"));
                                                      if (fav.contains(
                                                          text.trim())) {
                                                        setState(() {
                                                          isFav = true;
                                                        });
                                                      } else {
                                                        setState(() {
                                                          isFav = false;
                                                        });
                                                      }
                                                    }
                                                  }
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4),
                                                  child: Image.asset(
                                                    "assets/uiImages/delete.png",
                                                    height: 26,
                                                    matchTextDirection: true,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      child: ListView(
                                                        controller:
                                                            contentWordController,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        children: [
                                                          for (int i = 0;
                                                              i <
                                                                  fieldContent
                                                                      .length;
                                                              i++)
                                                            fieldContent[i]
                                                                    .imageURL
                                                                    .isEmpty
                                                                ? FittedBox(
                                                                    child: Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          const SizedBox(
                                                                            height:
                                                                                110,
                                                                            width:
                                                                                110,
                                                                          ),
                                                                          Text(
                                                                            fieldContent[i].nameContent,
                                                                            style: TextStyle(
                                                                                fontSize: 40,
                                                                                fontWeight: FontWeight.w900,
                                                                                color: pinkColor),
                                                                          )
                                                                        ]),
                                                                  )
                                                                : FittedBox(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              12),
                                                                      child: Column(
                                                                          children: [
                                                                            SizedBox(
                                                                              height: 110,
                                                                              width: 110,
                                                                              child: getImage(fieldContent[i].imageURL),
                                                                            ),
                                                                            Text(
                                                                              fieldContent[i].nameContent,
                                                                              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: pinkColor),
                                                                            )
                                                                          ]),
                                                                    ),
                                                                  ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 15),
                                                            child: SizedBox(
                                                              height: 140,
                                                              width: 300,
                                                              child: Center(
                                                                child:
                                                                    TextField(
                                                                  controller:
                                                                      controller,
                                                                  cursorColor:
                                                                      pinkColor,
                                                                  onTap: () {
                                                                    controller.selection = TextSelection.fromPosition(TextPosition(
                                                                        offset: controller
                                                                            .text
                                                                            .trim()
                                                                            .length));
                                                                  },
                                                                  onChanged:
                                                                      (v) async {
                                                                    if (v
                                                                        .trim()
                                                                        .isNotEmpty) {
                                                                      autoComplete(
                                                                          v);
                                                                    } else if (v
                                                                            .trim()
                                                                            .isEmpty &&
                                                                        fieldContent
                                                                            .isNotEmpty) {
                                                                      predict(fieldContent[fieldContent.length -
                                                                              1]
                                                                          .nameContent);
                                                                    } else if (fieldContent
                                                                            .isEmpty &&
                                                                        v
                                                                            .trim()
                                                                            .isEmpty) {
                                                                      List<List<String>>
                                                                          main =
                                                                          [];
                                                                      for (var element
                                                                          in librarywordChild[0]
                                                                              .contenlist) {
                                                                        main.add([
                                                                          element
                                                                              .nameContent,
                                                                          element
                                                                              .imageURL
                                                                        ]);
                                                                      }
                                                                      setState(
                                                                          () {
                                                                        predictionWords =
                                                                            main;
                                                                      });
                                                                    }
                                                                  },
                                                                  cursorWidth:
                                                                      4,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          35,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900),
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 8,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                              height: 10,
                                                              width: 150,
                                                              child: fieldContent
                                                                          .length >=
                                                                      5
                                                                  ? SliderTheme(
                                                                      data: SliderTheme.of(
                                                                              context)
                                                                          .copyWith(
                                                                        activeTrackColor: const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            114,
                                                                            114,
                                                                            114),
                                                                        inactiveTrackColor: const Color.fromARGB(
                                                                                255,
                                                                                114,
                                                                                114,
                                                                                114)
                                                                            .withOpacity(.5),
                                                                        trackShape:
                                                                            const RectangularSliderTrackShape(),
                                                                        trackHeight:
                                                                            4,
                                                                        thumbColor: const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            114,
                                                                            114,
                                                                            114),
                                                                        thumbShape:
                                                                            const RoundSliderThumbShape(enabledThumbRadius: 8),
                                                                        overlayColor: Colors
                                                                            .red
                                                                            .withAlpha(32),
                                                                      ),
                                                                      child: Slider(
                                                                          value: _scrollOffset,
                                                                          //sliderValue,
                                                                          onChanged: ((value) {
                                                                            contentWordController.animateTo(contentWordController.position.maxScrollExtent * value,
                                                                                duration: const Duration(seconds: 1),
                                                                                curve: Curves.easeOut);
                                                                          })),
                                                                    )
                                                                  : Container()),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .3,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    List<List<String>>
                                                                        main =
                                                                        [];
                                                                    for (var element
                                                                        in librarywordChild[0]
                                                                            .contenlist) {
                                                                      main.add([
                                                                        element
                                                                            .nameContent,
                                                                        element
                                                                            .imageURL
                                                                      ]);
                                                                    }
                                                                    setState(
                                                                        () {
                                                                      isFav =
                                                                          false;
                                                                      fieldContent =
                                                                          [];
                                                                      predictionWords =
                                                                          main;
                                                                    });
                                                                    controller
                                                                        .clear();
                                                                  },
                                                                  child:
                                                                      SizedBox(
                                                                    height: 25,
                                                                    width: 25,
                                                                    child: Image
                                                                        .asset(
                                                                      "assets/uiImages/trash.png",
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 15,
                                                                ),
                                                                InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    if (controller
                                                                        .text
                                                                        .trim()
                                                                        .isNotEmpty) {
                                                                      setState(
                                                                          () {
                                                                        fieldContent.add(Content(
                                                                            controller.text.trim(),
                                                                            "",
                                                                            "false",
                                                                            "",
                                                                            "",
                                                                            "false"));
                                                                      });

                                                                      controller
                                                                          .clear();
                                                                    }
                                                                    if (fieldContent
                                                                        .isNotEmpty) {
                                                                      //speak
                                                                      String
                                                                          text =
                                                                          "";
                                                                      for (var element
                                                                          in fieldContent) {
                                                                        text +=
                                                                            "${element.nameContent} ";
                                                                      }
                                                                      if (controller
                                                                          .text
                                                                          .trim()
                                                                          .isNotEmpty) {
                                                                        predict(text
                                                                            .replaceAll("أ",
                                                                                "ا")
                                                                            .replaceAll("إ",
                                                                                "ا")
                                                                            .replaceAll("ة",
                                                                                "ه"));
                                                                      }

                                                                      SharedPreferences
                                                                          favlist =
                                                                          await SharedPreferences
                                                                              .getInstance();
                                                                      if (!fav.contains(
                                                                          text.trim())) {
                                                                        setState(
                                                                            () {
                                                                          fav.add(
                                                                              text.trim());
                                                                          isFav =
                                                                              true;
                                                                        });

                                                                        String
                                                                            newFav =
                                                                            "";
                                                                        for (int y =
                                                                                0;
                                                                            y < fieldContent.length;
                                                                            y++) {
                                                                          String
                                                                              input =
                                                                              fieldContent[y].nameContent;
                                                                          String
                                                                              imurl =
                                                                              fieldContent[y].imageURL;
                                                                          String
                                                                              isimup =
                                                                              fieldContent[y].isImageUploadbyUser.toString();
                                                                          String
                                                                              voiceurl =
                                                                              fieldContent[y].localVoiceFilePath;
                                                                          String
                                                                              voiceCache =
                                                                              fieldContent[y].firebaseVoiceFilePath;
                                                                          String
                                                                              isvoiceUp =
                                                                              fieldContent[y].isVoiceUploadByUser.toString();

                                                                          if (y ==
                                                                              fieldContent.length - 1) {
                                                                            newFav +=
                                                                                """["$input","$imurl","$isimup","$voiceurl","$voiceCache","$isvoiceUp"]""";
                                                                          } else {
                                                                            newFav +=
                                                                                """["$input","$imurl","$isimup","$voiceurl","$voiceCache","$isvoiceUp"],""";
                                                                          }
                                                                        }
                                                                        newFav =
                                                                            "[$newFav]";
                                                                        List<String>
                                                                            favChildList =
                                                                            [];
                                                                        var temp =
                                                                            favlist.getStringList("favlistChild");
                                                                        if (temp ==
                                                                            null) {
                                                                          favChildList =
                                                                              [
                                                                            newFav
                                                                          ];
                                                                        } else {
                                                                          favChildList =
                                                                              temp;
                                                                          favChildList
                                                                              .add(newFav);
                                                                        }
                                                                        favlist.setStringList(
                                                                            "favlistChild",
                                                                            favChildList);
                                                                      } else {
                                                                        fav.remove(
                                                                            text.trim());
                                                                        setState(
                                                                            () {
                                                                          isFav =
                                                                              false;
                                                                        });
                                                                        List<String>
                                                                            v =
                                                                            favlist.getStringList("favlistChild") ??
                                                                                [];
                                                                        List
                                                                            favChild =
                                                                            [];
                                                                        for (var element
                                                                            in v) {
                                                                          favChild
                                                                              .add(json.decode(element));
                                                                        }
                                                                        favChild
                                                                            .removeWhere((element) {
                                                                          if (element.length !=
                                                                              fieldContent.length) {
                                                                            return false;
                                                                          } else {
                                                                            bool
                                                                                sam =
                                                                                true;
                                                                            for (int o = 0;
                                                                                o < element.length;
                                                                                o++) {
                                                                              if (element[o][0] != fieldContent[o].nameContent) {
                                                                                sam = false;
                                                                              }
                                                                            }
                                                                            return sam;
                                                                          }
                                                                        });

                                                                        List<String>
                                                                            favString =
                                                                            convertFvaChildrenToString(favChild);
                                                                        favlist.setStringList(
                                                                            "favlistChild",
                                                                            favString);
                                                                      }
                                                                    } else {
                                                                      errorAlert(
                                                                          context,
                                                                          "يرجى ملئ الحقل للاضافة الى المفضلة");
                                                                    }
                                                                  },
                                                                  child:
                                                                      SizedBox(
                                                                    height: 25,
                                                                    width: 25,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .all(
                                                                              0),
                                                                      child: isFav
                                                                          ? Image.asset(
                                                                              "assets/uiImages/star2.png",
                                                                              color: pinkColor,
                                                                              height: 33,
                                                                            )
                                                                          : Image.asset(
                                                                              "assets/uiImages/star.png",
                                                                              height: 33,
                                                                            ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 15,
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    if (controller
                                                                        .text
                                                                        .trim()
                                                                        .isNotEmpty) {
                                                                      setState(
                                                                          () {
                                                                        fieldContent.add(Content(
                                                                            controller.text.trim(),
                                                                            "",
                                                                            "false",
                                                                            "",
                                                                            "",
                                                                            "false"));
                                                                      });
                                                                      if (fieldContent
                                                                              .length >
                                                                          5) {
                                                                        contentWordController.animateTo(
                                                                            contentWordController.position.maxScrollExtent -
                                                                                200,
                                                                            duration:
                                                                                const Duration(milliseconds: 750),
                                                                            curve: Curves.easeOut);
                                                                      }

                                                                      controller
                                                                          .clear();
                                                                    }
                                                                    //speak
                                                                    String a =
                                                                        "";
                                                                    for (var element
                                                                        in fieldContent) {
                                                                      a +=
                                                                          "${element.nameContent} ";
                                                                    }

                                                                    if (a
                                                                        .isNotEmpty) {
                                                                      Share.share(
                                                                          a);
                                                                    } else {
                                                                      errorAlert(
                                                                          context,
                                                                          "لا يمكن مشاركة حقل فارغ");
                                                                    }
                                                                  },
                                                                  child:
                                                                      SizedBox(
                                                                    height: 25,
                                                                    width: 25,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .all(
                                                                              0),
                                                                      child: Image
                                                                          .asset(
                                                                        "assets/uiImages/share.png",
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(right: 5, left: 5),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, top: 8),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            border: Border.all(
                                                width: 2, color: greyColor)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5,
                                              left: 8,
                                              right: 8,
                                              bottom: 10),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                  child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  predictionWords.isNotEmpty
                                                      ? box(0)
                                                      : const SizedBox(
                                                          height: 80,
                                                          width: 80,
                                                        ),
                                                  predictionWords.length >= 2
                                                      ? box(1)
                                                      : const SizedBox(
                                                          height: 80,
                                                          width: 80,
                                                        ),
                                                  predictionWords.length >= 3
                                                      ? box(2)
                                                      : const SizedBox(
                                                          height: 80,
                                                          width: 80,
                                                        ),
                                                  InkWell(
                                                    onTap: () {
                                                      List<List<String>> main =
                                                          [];
                                                      for (var element
                                                          in librarywordChild[0]
                                                              .contenlist) {
                                                        main.add([
                                                          element.nameContent,
                                                          element.imageURL
                                                        ]);
                                                      }
                                                      setState(() {
                                                        predictionWords = main;
                                                      });
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 7),
                                                      child: Container(
                                                        width:
                                                            size == 0 ? 80 : 75,
                                                        decoration: BoxDecoration(
                                                            color: const Color(
                                                                0xffC06FB9),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        child: const Center(
                                                          child: Text(
                                                            "الرئيسية",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )),
                                              Container(
                                                height: 7,
                                              ),
                                              Expanded(
                                                  child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  predictionWords.length >= 4
                                                      ? box(3)
                                                      : const SizedBox(
                                                          height: 80,
                                                          width: 80,
                                                        ),
                                                  predictionWords.length >= 5
                                                      ? box(4)
                                                      : const SizedBox(
                                                          height: 80,
                                                          width: 80,
                                                        ),
                                                  predictionWords.length >= 6
                                                      ? box(5)
                                                      : const SizedBox(
                                                          height: 80,
                                                          width: 80,
                                                        ),
                                                  InkWell(
                                                    onTap: () {
                                                      List<List<String>> verbs =
                                                          [];
                                                      for (var element
                                                          in librarywordChild[1]
                                                              .contenlist) {
                                                        verbs.add([
                                                          element.nameContent,
                                                          element.imageURL
                                                        ]);
                                                      }
                                                      setState(() {
                                                        predictionWords = verbs;
                                                      });
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 7),
                                                      child: Container(
                                                        width:
                                                            size == 0 ? 80 : 75,
                                                        decoration: BoxDecoration(
                                                            color: const Color(
                                                                0xffA7CB89),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        child: const Center(
                                                          child: Text(
                                                            "أفعال",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )),
                                              Container(
                                                height: 7,
                                              ),
                                              Expanded(
                                                  child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  predictionWords.length >= 7
                                                      ? box(6)
                                                      : const SizedBox(
                                                          height: 80,
                                                          width: 80,
                                                        ),
                                                  predictionWords.length >= 8
                                                      ? box(7)
                                                      : const SizedBox(
                                                          height: 80,
                                                          width: 80,
                                                        ),
                                                  predictionWords.length >= 9
                                                      ? box(8)
                                                      : const SizedBox(
                                                          height: 80,
                                                          width: 80,
                                                        ),
                                                  InkWell(
                                                    onTap: () {
                                                      List<List<String>>
                                                          letters = [];
                                                      for (var element
                                                          in librarywordChild[2]
                                                              .contenlist) {
                                                        letters.add([
                                                          element.nameContent,
                                                          element.imageURL
                                                        ]);
                                                      }
                                                      setState(() {
                                                        predictionWords =
                                                            letters;
                                                      });
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 7),
                                                      child: Container(
                                                        width:
                                                            size == 0 ? 80 : 75,
                                                        decoration: BoxDecoration(
                                                            color: const Color(
                                                                0xffE9E467),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        child: const Center(
                                                          child: Text(
                                                            "حروف",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )),
                                              Container(
                                                height: 7,
                                              ),
                                              !isLess && size != 0
                                                  ? Expanded(
                                                      child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        predictionWords
                                                                    .length >=
                                                                10
                                                            ? box(9)
                                                            : const SizedBox(
                                                                height: 80,
                                                                width: 80,
                                                              ),
                                                        predictionWords
                                                                    .length >=
                                                                11
                                                            ? box(10)
                                                            : const SizedBox(
                                                                height: 80,
                                                                width: 80,
                                                              ),
                                                        predictionWords
                                                                    .length >=
                                                                12
                                                            ? box(11)
                                                            : const SizedBox(
                                                                height: 80,
                                                                width: 80,
                                                              ),
                                                        InkWell(
                                                          onTap: () {
                                                            List<List<String>>
                                                                con = [];
                                                            for (var element
                                                                in librarywordChild[
                                                                        3]
                                                                    .contenlist) {
                                                              con.add([
                                                                element
                                                                    .nameContent,
                                                                element.imageURL
                                                              ]);
                                                            }
                                                            setState(() {
                                                              predictionWords =
                                                                  con;
                                                            });
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 7),
                                                            child: Container(
                                                              width: size == 0
                                                                  ? 80
                                                                  : 75,
                                                              decoration: BoxDecoration(
                                                                  color: const Color(
                                                                          0xff1367A2)
                                                                      .withOpacity(
                                                                          .6),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15)),
                                                              child:
                                                                  const Center(
                                                                child: Text(
                                                                  "صفات",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ))
                                                  : Container()
                                            ],
                                          ),
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isLess = !isLess;
                                      });
                                    },
                                    child: Container(
                                      height: 22,
                                      width: 45,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Image.asset(
                                        isLess
                                            ? "assets/uiImages/down.png"
                                            : "assets/uiImages/upArrow.png",
                                        height: 45,
                                        color: const Color.fromARGB(
                                            255, 204, 204, 204),
                                        matchTextDirection: false,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                            Padding(
                              padding: const EdgeInsets.only(right: 5, left: 5),
                              child: Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        if (currentOffsetScroll - 100 > 0) {
                                          setState(() {
                                            currentOffsetScroll -= 100;
                                            controllerList.animateTo(
                                                currentOffsetScroll,
                                                duration:
                                                    const Duration(seconds: 1),
                                                curve: Curves.easeOut);
                                          });
                                        } else {
                                          setState(() {
                                            currentOffsetScroll = 0;

                                            controllerList.jumpTo(0);
                                          });
                                        }
                                      },
                                      child: Image.asset(
                                        "assets/uiImages/arrow.png",
                                        height: 25,
                                        color: Colors.grey,
                                      )),
                                  Expanded(
                                    child: SizedBox(
                                      height: 56,
                                      child: ListView(
                                        controller: controllerList,
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          for (int i = 0;
                                              i < libraryListChild.length;
                                              i++)
                                            box2(i)
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        if (currentOffsetScroll + 100 <
                                            70 * libraryListChild.length) {
                                          setState(() {
                                            currentOffsetScroll += 70;
                                            controllerList.animateTo(
                                                currentOffsetScroll,
                                                duration:
                                                    const Duration(seconds: 1),
                                                curve: Curves.easeOut);
                                          });
                                        } else {
                                          setState(() {
                                            currentOffsetScroll =
                                                70.0 * libraryListChild.length;
                                            controllerList.animateTo(
                                                70.0 * libraryListChild.length,
                                                duration:
                                                    const Duration(seconds: 1),
                                                curve: Curves.easeOut);
                                          });
                                        }
                                      },
                                      child: Image.asset(
                                        "assets/uiImages/arrow.png",
                                        height: 25,
                                        matchTextDirection: true,
                                        color: Colors.grey,
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              height: isLess
                                  ? 200
                                  : size == 0
                                      ? 110
                                      : 100,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 206, 213, 218),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 5, left: 5),
                                child: Row(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          if (currentOffsetScroll2 - 100 > 0) {
                                            setState(() {
                                              currentOffsetScroll2 -= 100;
                                              controllerList2.animateTo(
                                                  currentOffsetScroll2,
                                                  duration: const Duration(
                                                      seconds: 1),
                                                  curve: Curves.easeOut);
                                            });
                                          } else {
                                            setState(() {
                                              currentOffsetScroll2 = 0;

                                              controllerList2.jumpTo(0);
                                            });
                                          }
                                        },
                                        child: Image.asset(
                                          "assets/uiImages/arrow.png",
                                          height: 30,
                                          color: Colors.black,
                                        )),
                                    Expanded(
                                      child: Container(
                                        color: const Color.fromARGB(
                                            255, 206, 213, 218),
                                        child: ListView(
                                          controller: controllerList2,
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            for (int i = 0;
                                                i < contentWord.length;
                                                isLess ? i = i + 2 : i++)
                                              Column(
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      onLongPress: () {
                                                        bool t = Provider.of<
                                                                    MyProvider>(
                                                                context,
                                                                listen: false)
                                                            .isSpeakingNow;
                                                        if (!t) {
                                                          if (contentWord[i]
                                                                  .localVoiceFilePath !=
                                                              "") {
                                                            print(
                                                                "the file path is:${contentWord[i].localVoiceFilePath}");
                                                            //_playAudio(contentWord[i].cacheVoicePath);
                                                            _playAudio(contentWord[
                                                                    i]
                                                                .localVoiceFilePath);
                                                            //playLocalAsset();
                                                          } else {
                                                            howToSpeak(
                                                                contentWord[i]
                                                                    .nameContent,
                                                                context);
                                                          }
                                                        }
                                                        ;
                                                      },
                                                      onDoubleTap: () {
                                                        bool t = Provider.of<
                                                                    MyProvider>(
                                                                context,
                                                                listen: false)
                                                            .isSpeakingNow;
                                                        if (!t) {
                                                          if (contentWord[i]
                                                                  .localVoiceFilePath !=
                                                              "") {
                                                            print(contentWord[i]
                                                                .localVoiceFilePath);
                                                            //_playAudio(contentWord[i].opvoice);
                                                            //_play(contentWord[i].opvoice);
                                                            _playAudio(contentWord[
                                                                    i]
                                                                .localVoiceFilePath);
                                                          } else {
                                                            howToSpeak(
                                                                contentWord[i]
                                                                    .nameContent,
                                                                context);
                                                          }
                                                        }
                                                        ;
                                                      },
                                                      onTap: () {
                                                        bool t = Provider.of<
                                                                    MyProvider>(
                                                                context,
                                                                listen: false)
                                                            .isSpeakingNow;
                                                        if (!t) {
                                                          if (speakingWordByWord) {
                                                            if (contentWord[i]
                                                                    .localVoiceFilePath !=
                                                                "") {
                                                              //  print(contentWord[i].opvoice);
                                                              //_playAudio(contentWord[i].opvoice);
                                                              print(
                                                                  "the file path is:${contentWord[i].localVoiceFilePath}");

                                                              _playAudio(
                                                                  contentWord[i]
                                                                      .localVoiceFilePath);
                                                            } else {
                                                              howToSpeak(
                                                                  contentWord[i]
                                                                      .nameContent,
                                                                  context);
                                                            }
                                                          }
                                                          setState(() {
                                                            fieldContent.add(
                                                              contentWord[i],
                                                            );
                                                          });
                                                          String text = "";
                                                          for (var element
                                                              in fieldContent) {
                                                            text +=
                                                                "${element.nameContent} ";
                                                          }
                                                          if (fav.contains(
                                                              text.trim())) {
                                                            setState(() {
                                                              isFav = true;
                                                            });
                                                          } else {
                                                            setState(() {
                                                              isFav = false;
                                                            });
                                                          }
                                                          if (fieldContent
                                                                  .length >
                                                              5) {
                                                            contentWordController.animateTo(
                                                                contentWordController
                                                                        .position
                                                                        .maxScrollExtent -
                                                                    200,
                                                                duration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            750),
                                                                curve: Curves
                                                                    .easeOut);
                                                          }
                                                          predict(text
                                                              .replaceAll(
                                                                  "أ", "ا")
                                                              .replaceAll(
                                                                  "إ", "ا")
                                                              .replaceAll(
                                                                  "ة", "ه")
                                                              .trim());
                                                        }
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 3,
                                                                left: 3,
                                                                top: 2,
                                                                bottom: 2),
                                                        child: Container(
                                                          width: size == 0
                                                              ? 120
                                                              : 120,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20)),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  spreadRadius:
                                                                      3,
                                                                  blurRadius: 5,
                                                                  offset:
                                                                      const Offset(
                                                                          0,
                                                                          3)),
                                                            ],
                                                            border: Border.all(
                                                              width: size == 0
                                                                  ? 3
                                                                  : 2,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          child: Column(
                                                              /* mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,*/
                                                              children: [
                                                                SizedBox(
                                                                  height: 20,
                                                                  width: 20,
                                                                  child: getImage(
                                                                      contentWord[
                                                                              i]
                                                                          .imageURL),
                                                                ),
                                                                Text(
                                                                  noMoreText(
                                                                      contentWord[
                                                                              i]
                                                                          .nameContent),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontSize: size ==
                                                                              0
                                                                          ? 18
                                                                          : 18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                      color:
                                                                          pinkColor),
                                                                ),
                                                              ]),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  isLess
                                                      ? Expanded(
                                                          child: i + 1 !=
                                                                  contentWord
                                                                      .length
                                                              ? InkWell(
                                                                  onLongPress:
                                                                      () {
                                                                    howToSpeak(
                                                                        contentWord[i +
                                                                                1]
                                                                            .nameContent,
                                                                        context);
                                                                  },
                                                                  onDoubleTap:
                                                                      () {
                                                                    howToSpeak(
                                                                        contentWord[i +
                                                                                1]
                                                                            .nameContent,
                                                                        context);
                                                                  },
                                                                  onTap: () {
                                                                    if (speakingWordByWord) {
                                                                      howToSpeak(
                                                                          contentWord[i + 1]
                                                                              .nameContent,
                                                                          context);
                                                                    }
                                                                    setState(
                                                                        () {
                                                                      fieldContent
                                                                          .add(
                                                                        contentWord[
                                                                            i + 1],
                                                                      );
                                                                    });
                                                                    String
                                                                        text =
                                                                        "";
                                                                    for (var element
                                                                        in fieldContent) {
                                                                      text +=
                                                                          "${element.nameContent} ";
                                                                    }
                                                                    if (fav.contains(
                                                                        text.trim())) {
                                                                      setState(
                                                                          () {
                                                                        isFav =
                                                                            true;
                                                                      });
                                                                    } else {
                                                                      setState(
                                                                          () {
                                                                        isFav =
                                                                            false;
                                                                      });
                                                                    }
                                                                    if (fieldContent
                                                                            .length >
                                                                        5) {
                                                                      contentWordController.animateTo(
                                                                          contentWordController.position.maxScrollExtent -
                                                                              200,
                                                                          duration: const Duration(
                                                                              milliseconds:
                                                                                  750),
                                                                          curve:
                                                                              Curves.easeOut);
                                                                    }
                                                                    predict(text
                                                                        .replaceAll(
                                                                            "أ",
                                                                            "ا")
                                                                        .replaceAll(
                                                                            "إ",
                                                                            "ا")
                                                                        .replaceAll(
                                                                            "ة",
                                                                            "ه")
                                                                        .trim());
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            2),
                                                                    child:
                                                                        Container(
                                                                      width: size ==
                                                                              0
                                                                          ? 120
                                                                          : 120,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius: const BorderRadius
                                                                            .all(
                                                                            Radius.circular(20)),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                              color: Colors.grey.withOpacity(0.3),
                                                                              spreadRadius: 3,
                                                                              blurRadius: 5,
                                                                              offset: const Offset(0, 3)),
                                                                        ],
                                                                        border:
                                                                            Border.all(
                                                                          width: size == 0
                                                                              ? 3
                                                                              : 2,
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                      ),
                                                                      child: Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceAround,
                                                                          children: [
                                                                            SizedBox(
                                                                              height: 30,
                                                                              width: 30,
                                                                              child: getImage(contentWord[i + 1].imageURL),
                                                                            ),
                                                                            Text(
                                                                              noMoreText(contentWord[i + 1].nameContent),
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(fontSize: size == 0 ? 18 : 18, fontWeight: FontWeight.w900, color: pinkColor),
                                                                            ),
                                                                          ]),
                                                                    ),
                                                                  ),
                                                                )
                                                              : Container(),
                                                        )
                                                      : Container()
                                                ],
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          if (currentOffsetScroll2 + 100 <
                                              90 *
                                                  libraryListChild[
                                                          coloredOpenLibraryindex]
                                                      .contenlist
                                                      .length) {
                                            setState(() {
                                              currentOffsetScroll2 += 60;
                                              controllerList2.animateTo(
                                                  currentOffsetScroll2,
                                                  duration: const Duration(
                                                      seconds: 1),
                                                  curve: Curves.easeOut);
                                            });
                                          } else {
                                            setState(() {
                                              currentOffsetScroll2 = 90.0 *
                                                  libraryListChild[
                                                          coloredOpenLibraryindex]
                                                      .contenlist
                                                      .length;
                                              controllerList2.animateTo(
                                                  90.0 *
                                                      libraryListChild[
                                                              coloredOpenLibraryindex]
                                                          .contenlist
                                                          .length,
                                                  duration: const Duration(
                                                      seconds: 1),
                                                  curve: Curves.easeOut);
                                            });
                                          }
                                        },
                                        child: Image.asset(
                                          "assets/uiImages/arrow.png",
                                          height: 30,
                                          matchTextDirection: true,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
    );
  }

  String noMoreText(String text) {
    List textList = text.trim().split(" ");
    if (textList.length > 4) {
      String a = textList[0] +
          " " +
          textList[1] +
          " " +
          textList[2] +
          " " +
          textList[3] +
          "..";
      return a;
    } else {
      return text;
    }
  }

  autoComplete(String v) async {
    v = v.replaceAll("أ", "ا");
    v = v.replaceAll("إ", "ا");
    v = v.replaceAll("ة", "ه");
    bool isautoComplete = true;
    if (v.trim().length > 1) {
      if (v[v.length - 1] == " ") {
        isautoComplete = false;
        if (speakingWordByWord) {
          howToSpeak(controller.text, context);
        }
        setState(() {
          fieldContent.add(
              Content(controller.text.trim(), "", "false", "", "", "false"));
        });
        String text = "";
        for (var element in fieldContent) {
          text += "${element.nameContent} ";
        }
        predict(text
            .replaceAll("أ", "ا")
            .replaceAll("إ", "ا")
            .replaceAll("ة", "ه"));
        controller.clear();
      }
    }
    if (isautoComplete) {
      v = v.trim();
      if (v.isNotEmpty) {
        predictionWords = [];
        int leng = v.length;
        for (String element in LocalDB) {
          List<String> Sentence = element.trim().split(" ");

          for (var w in Sentence) {
            if (w.length >= leng) {
              if (w
                      .substring(0, leng)
                      .replaceAll("أ", "ا")
                      .replaceAll("إ", "ا")
                      .replaceAll("ة", "ه") ==
                  v) {
                if (!searchInPredictionWords(w)) {
                  predictionWords.removeWhere((element) => element[0] == w);
                  predictionWords.add([w, getImageWord(w)]);
                }
              }
            }
          }
          if (predictionWords.length >= 12) break;
        }
        if (predictionWords.length < 12) {
          String path1 = await rootBundle.loadString("assets/oneWord.txt");
          List<String> result = path1.split('\n');
          for (int i = 0; i < result.length; i++) {
            result[i] = result[i].replaceAll("\"", "").trim();
            int searchLenght = v.trim().length;
            String word = result[i];
            if (word.length >= v.trim().length) {
              if (word.substring(0, searchLenght) == v.trim()) {
                if (!searchInPredictionWords(word)) {
                  predictionWords.add([word, getImageWord(word)]);
                }
              }
            }
            if (predictionWords.length >= 12) break;
          }
        }
        setState(() {
          predictionWords;
        });
      }
    }
  }

  box(int index) {
    return InkWell(
      onTap:
          Provider.of<MyProvider>(context, listen: false).isSpeakingNow == true
              ? null
              : () {
                  controller.clear();
                  if (speakingWordByWord) {
                    howToSpeak(
                        harakatPrediction(predictionWords[index][0]), context);
                  }

                  setState(() {
                    fieldContent.add(
                      Content(predictionWords[index][0],
                          predictionWords[index][1], "false", "", "", "false"),
                    );
                  });

                  String text = "";
                  for (var element in fieldContent) {
                    text += "${element.nameContent} ";
                  }
                  predict(text
                      .replaceAll("أ", "ا")
                      .replaceAll("إ", "ا")
                      .replaceAll("ة", "ه"));
                  if (fav.contains(text.trim())) {
                    setState(() {
                      isFav = true;
                    });
                  } else {
                    setState(() {
                      isFav = false;
                    });
                  }
                  if (fieldContent.length > 5) {
                    contentWordController.animateTo(
                        contentWordController.position.maxScrollExtent - 200,
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.easeOut);
                  }
                },
      child: Container(
        width: size == 0 ? 83 : 80,
        height: 500,
        decoration: BoxDecoration(
            // color: getWordColor(predictionWords[index][0]).withOpacity(.4),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(
                color: getWordColor(predictionWords[index][0]),
                width: size == 0 ? 4.3 : 3)),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: FittedBox(
            child: Column(children: [
              SizedBox(
                height: size == 0 ? 85 : 90,
                width: size == 0 ? 85 : 90,
                child: getImage(predictionWords[index][1]),
              ),
              Text(
                predictionWords[index][0],
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: pinkColor),
              )
            ]),
          ),
        ),
      ),
    );
  }

  box2(int index) {
    return InkWell(
      onTap: () {
        print("انا ابي ابكي");
        setState(() {
          coloredOpenLibraryindex = index;
          currentOffsetScroll2 = 0;
          controllerList2.jumpTo(0);
          contentWord = libraryListChild[index].contenlist;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: index == coloredOpenLibraryindex
            ? Column(
                children: [
                  Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 206, 213, 218),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: const Offset(0, 3)),
                        ],
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(7),
                                child: Text(
                                  libraryListChild[index].name,
                                  style: TextStyle(
                                      fontSize: size == 0 ? 20 : 20,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ])),
                ],
              )
            : Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          border: Border.all(
                            width: size == 0 ? 3 : 2,
                            color: Colors.grey,
                          ),
                        ),
                        child: Center(
                          child: FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(7),
                              child: Text(
                                libraryListChild[index].name,
                                style: TextStyle(
                                    fontSize: size == 0 ? 20 : 20,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
      ),
    );
  }

  searchInPredictionWords(String word) {
    for (int i = 0; i < predictionWords.length; i++) {
      if (predictionWords[i][0]
              .replaceAll("أ", "ا")
              .replaceAll("إ", "ا")
              .replaceAll("ة", "ه")
              .trim() ==
          word
              .replaceAll("أ", "ا")
              .replaceAll("إ", "ا")
              .replaceAll("ة", "ه")
              .trim()) {
        return true;
      }
    }
    return false;
  }

  predict(String word) {
    List<String> sentence = word
        .replaceAll("  ", " ")
        .replaceAll("أ", "ا")
        .replaceAll("ة", "ه")
        .replaceAll("إ", "ا")
        .trim()
        .split(' ');
    if (sentence.length == 1) {
      predictionWords.clear();
      secondWordLocal(sentence[0], 0);
    } else if (sentence.length == 2) {
      predictionWords.clear();
      thirdWordLocal(sentence, 0);
    } else {
      predictionWords.clear();
      List sent = sentence.sublist(sentence.length - 3, sentence.length);

      fourthWordLocal(sent, 0);
    }
  }

  fourthWordLocal(List text, int counter) async {
    List<String> result = LocalDB;
    for (String r in result) {
      if (counter < 12) {
        List<String> s = r
            .replaceAll("أ", "ا")
            .replaceAll("إ", "ا")
            .replaceAll("ة", "ه")
            .split(" ");
        List<String> sf = r.split(" ");
        for (int i = 0; i < s.length; i++) {
          if (s[i] == text[1]) {
            if (s.length - i >= 3 &&
                s[i + 1] == text[2] &&
                fieldContent[fieldContent.length - 1].nameContent.trim() !=
                    s[i + 2] &&
                !searchInPredictionWords(s[i + 2])) {
              counter++;
              predictionWords.add([sf[i + 2], getImageWord(sf[i + 2])]);
            }
          }
        }
      } else {
        break;
      }
    }
    setState(() {});
    if (counter < 12) {
      fourthWordChild(text, counter);
    } else {
      return counter;
    }
  }

  fourthWordChild(List text, int counter) async {
    String path = await rootBundle.loadString("assets/fourgram.txt");
    List<String> result = path.split('\n');
    for (String r in result) {
      r = r.replaceAll("\"", "");

      if (counter < 12) {
        List<String> s = r
            .replaceAll("أ", "ا")
            .replaceAll("إ", "ا")
            .replaceAll("ة", "ه")
            .split(" ");
        List<String> sf = r.split(" ");
        if (s[1].compareTo(text[1]) == 0 &&
            s[2].compareTo(text[2]) == 0 &&
            s[3] != fieldContent[fieldContent.length - 1].nameContent.trim() &&
            !searchInPredictionWords(s[3])) {
          counter++;
          predictionWords.add([sf[3], getImageWord(sf[3])]);
        }
      } else {
        break;
      }
    }
    setState(() {});

    if (counter < 12) {
      thirdWordLocal(text.sublist(1, text.length), counter);
    } else {
      return counter;
    }
  }

  thirdWordLocal(List text, int counter) async {
    for (String r in LocalDB) {
      if (counter < 12) {
        List<String> s = r
            .replaceAll("أ", "ا")
            .replaceAll("إ", "ا")
            .replaceAll("ة", "ه")
            .split(" ");
        List<String> sf = r.split(" ");
        for (int i = 0; i < s.length; i++) {
          if (s[i] == text[0]) {
            if (s.length - i >= 3 &&
                s[i + 1].trim() == text[1].trim() &&
                s[i + 2].trim() !=
                    fieldContent[fieldContent.length - 1].nameContent.trim() &&
                !searchInPredictionWords(s[i + 2])) {
              counter++;
              predictionWords.add([sf[i + 2], getImageWord(sf[i + 2])]);
            }
          }
        }
      } else {
        break;
      }
    }
    setState(() {});
    if (counter < 12) {
      return thirdWordChild(text, counter);
    }
    return counter;
  }

  thirdWordChild(List text, int counter) async {
    String path = await rootBundle.loadString("assets/trigram.txt");
    List<String> result = path.split('\n');
    for (String r in result) {
      r = r.replaceAll("\"", "");
      if (counter < 12) {
        List<String> s = r
            .replaceAll("أ", "ا")
            .replaceAll("إ", "ا")
            .replaceAll("ة", "ه")
            .split(" ");
        List<String> sf = r.split(" ");
        if (s[0] == text[0] &&
            s[1] == text[1] &&
            s[2] != fieldContent[fieldContent.length - 1].nameContent.trim() &&
            !searchInPredictionWords(s[2])) {
          counter++;
          predictionWords.add([sf[2], getImageWord(sf[2])]);
        }
      } else {
        break;
      }
    }
    setState(() {});
    /*  if (counter < 12) {
      for (String r in result) {
        r = r.replaceAll("\"", "");
        if (counter < 12) {
          List<String> s = r
              .replaceAll("أ", "ا")
              .replaceAll("إ", "ا")
              .replaceAll("ة", "ه")
              .split(" ");
          List<String> sf = r.split(" ");
          if (s[1] == text[1] &&
              fieldContent[fieldContent.length - 1].name.trim() != s[2] &&
              !search_in_predictionWords(s[2])) {
            counter++;
            predictionWords.add([sf[2], getImageWord(sf[2])]);
          }
        } else {
          break;
        }
      }
      setState(() {});
    }*/

    if (counter < 12) {
      secondWordLocal(text[1], counter);
    } else {
      return counter;
    }
  }

  secondWordLocal(String text, int counter) async {
    List<String> result = LocalDB;
    for (String r in result) {
      if (counter < 12) {
        List<String> s = r
            .replaceAll("أ", "ا")
            .replaceAll("إ", "ا")
            .replaceAll("ة", "ه")
            .split(" ");
        List<String> sf = r.split(" ");

        for (int i = 0; i < s.length; i++) {
          if (s[i] == text) {
            if (s.length - i >= 2 && !searchInPredictionWords(sf[i + 1])) {
              counter++;

              predictionWords.add([sf[i + 1], getImageWord(sf[i + 1].trim())]);
            }
          }
        }
      } else {
        break;
      }
    }
    setState(() {});
    if (counter < 12) {
      return secondWordChild(text, counter);
    }
  }

  secondWordChild(String text, int counter) async {
    String path = await rootBundle.loadString("assets/bigram.txt");
    List<String> result = path.split('\n');

    for (String r in result) {
      r = r.replaceAll("\"", "");

      if (counter < 12) {
        List<String> s = r
            .replaceAll("أ", "ا")
            .replaceAll("إ", "ا")
            .replaceAll("ة", "ه")
            .split(" ");
        List<String> sf = r.split(" ");

        if (s[0] == text &&
            s[1] != fieldContent[fieldContent.length - 1].nameContent.trim() &&
            !searchInPredictionWords(s[1])) {
          counter++;
          predictionWords.add([sf[1], getImageWord(sf[1].trim())]);
        }
      } else {
        break;
      }
    }
    setState(() {});
    if (counter < 12) {
      return oneWordChild(counter);
    }
    return counter;
  }

  oneWordChild(int counter) async {
    List wordsP = [
      "طيب",
      "تمام",
      "لا",
      "شكرا",
      "أنا",
      "هل",
      "كم",
      "هذا",
      "نعم",
      "أبغى",
      "كيف",
      "ممكن",
      "السلام",
      "اهلا",
      "مرحبا",
      "متى",
      "هذا",
      "مرحبا",
    ];
    for (int i = 0; i < wordsP.length; i++) {
      if (predictionWords.length < 12 && !searchInPredictionWords(wordsP[i])) {
        predictionWords.add([wordsP[i], getImageWord(wordsP[i])]);
      }
    }

    setState(() {});
  }
}
