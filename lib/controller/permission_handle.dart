//allow multiple permission
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
//if 1 then camera status is Denied , if 2 then microphone is denied, if 3 then storage is denied
/*
Future<void> requestPermissions(context) async {
  Map<Permission, PermissionStatus> status = await [
    Permission.camera,
    Permission.microphone,
    Permission.storage
  ].request();

  if (await Permission.camera.isDenied&&await Permission.microphone.isDenied&&await Permission.storage.isDenied) {
    String text='يرغب تطبيق تحدث بالتقاط الصور وتسجيل صوت ليتيح لك اضافة الصور وتسجيل مقاطع صوتية لاستخدامها داخل التطبيق او امكانية مشاركتها لاحقا';

    showPermissionsDeniedDialog(context,text,false);
  }


}*/
//if 1 then camera status is Denied , if 2 then microphone is denied, if 3 then storage is denied
/*
Future<int> permissionStatus(context) async {
  final statusCamera = await Permission.camera.status;
  final statusMicrophone = await Permission.microphone.status;
  final statusImagePicker= await Permission.storage.status;
  String text="";
  if(statusCamera.isDenied && statusMicrophone.isDenied && statusImagePicker.isDenied){
    requestPermissions(context);
    return 0;
  }else if(statusCamera.isDenied){
    text="يريد تطبيق تحدث السماح بالدخول للكاميرا لاضافة الصور لاستخدامها داخل التطبيق او إمكانية مشاركتها لاحقا";
    _showPermissionsDeniedDialog(context,text,false);
    return 1;

  }else if(statusMicrophone.isDenied){
    text="يريد تطبيق تحدث السماح بتسجيل مقاطع صوتيه لاستخدامها داخل التطبيق او إمكانية مشاركتها لاحقا";
    _showPermissionsDeniedDialog(context,text,true);
    return 2;
  }else{
    text="يريد تطبيق تحدث السماح بالدخول لمعرض الصور لإضافة الصور لاستخدامها داخل التطبيق او إمكانية مشاركتها لاحقا";
    _showPermissionsDeniedDialog(context,text,true);

    return 3;
  }


}
*/
/*
void requestPermissions(context) async {

  if (await Permission.camera.request().isGranted &&
      await Permission.microphone.request().isGranted&&
      await Permission.storage.request().isGranted) {
    //  _showPermissionsGrantedDialog();
  } else {
    String text='يرغب تطبيق تحدث بالتقاط الصور وتسجيل صوت ليتيح لك اضافة الصور وتسجيل مقاطع صوتية لاستخدامها داخل التطبيق او امكانية مشاركتها لاحقا';

    _showPermissionsDeniedDialog(context,text,false);
  }

}


*/

Future<void> requestCameraPermission(context) async {
  final permission = Permission.camera;

  if (await permission.isDenied) {
    showPermissionsDeniedDialog(
        context,
        "يريد تطبيق تحدث السماح بالدخول للكاميرا لاضافة الصور لاستخدامها داخل التطبيق او إمكانية مشاركتها لاحقا",
        true);
  }
}

void showPermissionsDeniedDialog(context, String text, bool isSetting) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('تم رفض الوصول'),
        content: Text(text),
        actions: <Widget>[
          TextButton(
            child: Text(isSetting == true ? 'الدخول للاعدادات' : 'موافق'),
            onPressed: () {
              if (isSetting == true) {
                requestPermissionWithOpenSettings();
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}

//checks permissions
Future<bool> checkCameraPermissionStatus() async {
  final statusCamera = await Permission.camera.status;
  return await statusCamera.isGranted;
}

Future<bool> checkMicrophonePermissionStatus() async {
  final statusMicrophone = await Permission.microphone.status;
  return await statusMicrophone.isGranted;
}

Future<bool> checkGallaryPermissionStatus() async {
  final statusStorage = await Permission.storage.status;
  return statusStorage.isGranted;
}

//allow camera permission //لازم يكون في شرط اذا البيرمشين  قبلها مايكمل اذا ما قبلها تطلع هذه كنافذه

//allow photo permission //لازم يكون في شرط اذا البيرمشين  قبلها مايكمل اذا ما قبلها تطلع هذه كنافذه

//allow audio recording  permission //لازم يكون في شرط اذا البيرمشين  قبلها مايكمل اذا ما قبلها تطلع هذه كنافذه

//go to app setting to change the permissione
void requestPermissionWithOpenSettings() async {
  //if (await Permission.speech.isPermanentlyDenied) {
  openAppSettings();
  //}
}
