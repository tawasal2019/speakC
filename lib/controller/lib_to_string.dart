import '../model/library.dart';

String convertLibString(lib l) {
  String a = "";

  for (int i = 0; i < l.contenlist.length; i++) {
    if (i == l.contenlist.length - 1) {
      a += """
["${l.contenlist[i].nameContent}",
"${l.contenlist[i].imageURL}",
"${l.contenlist[i].isImageUploadbyUser}",
"${l.contenlist[i].localVoiceFilePath}",
"${l.contenlist[i].firebaseVoiceFilePath}",
"${l.contenlist[i].isVoiceUploadByUser}"]
""";
    } else {
      a += """
["${l.contenlist[i].nameContent}",
"${l.contenlist[i].imageURL}",
"${l.contenlist[i].isImageUploadbyUser}",
"${l.contenlist[i].localVoiceFilePath}",
"${l.contenlist[i].firebaseVoiceFilePath}",
"${l.contenlist[i].isVoiceUploadByUser}"],
""";
    }
  }
  return """[
    "${l.name}","${l.imgurl}","${l.isImageUpload}",
    [$a]
    
    ]""";
}

String convertListOfContrntToString(List l) {
  String a = "";

  for (int i = 0; i < l.length; i++) {
    if (i == l.length - 1) {
      a += """
["${l[i][0]}",
"${l[i][1]}",
"${l[i][2]}",
"${l[i][3]}",
"${l[i][4]}",
"${l[i][5]}"]
""";
    } else {
      a += """
["${l[i][0]}",
"${l[i][1]}",
"${l[i][2]}",
"${l[i][3]}",
"${l[i][4]}",
"${l[i][5]}"],
""";
    }
  }
  return """[$a]""";
}
