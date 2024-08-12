// ignore_for_file: file_names

import '/controller/lib_to_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/library.dart';

editWordBoxContent(context, int indexLib, int indexContent,
    String nameNewContent, String imgNewContent) async {
  librarywordChild[indexLib].contenlist[indexContent].nameContent =
      nameNewContent;
  librarywordChild[indexLib].contenlist[indexContent].imageURL = imgNewContent;
  saveWordBoxContent(context, librarywordChild);
}

saveWordBoxContent(context, List<lib> l) async {
  List<String> data = [];
  for (var element in l) {
    String l = convertLibString(element);
    data.add(l);
  }
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setStringList("wordListChild", data);
}
