// ignore_for_file: constant_identifier_names
library custom_utils;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'app_navigation_helper.dart';
import 'app_textview.dart';


topNotification(String message) {
  return Positioned(
    top: 0,
    left: 0,
    right: 0,
    child: SafeArea(
      // Ensure the notification is displayed within safe area
      child: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.blue,
        child: Center(
          child: AppTextView(text: message),
        ),
      ),
    ),
  );
}

void showCustomDialog({String? message,String? dialogButtonText,Color? dialogButtonColor}) {
  showDialog(
    barrierDismissible: true,
    context: navKey.currentContext!,
    builder: (context) => AlertDialog(
      // title: CustomTextView(text: alertRequest.title),
      content: AppTextView(
        text: message,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: AppTextView(
            text:dialogButtonText,
            color: dialogButtonColor?? Colors.black,
          ),
        ),
      ],
    ),
  );
}

void showSnackBar(String message, {Color? color}) {
  final snackBar = SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: color ?? Colors.black,
      content: Center(
        child: AppTextView(
          text: message,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ));
  ScaffoldMessenger.of(navKey.currentContext!).showSnackBar(snackBar);
}

void hideKeyword() {
  FocusScope.of(navKey.currentContext!).unfocus();
  FocusScope.of(navKey.currentContext!).requestFocus(FocusNode());
}

class AppUtils {


  static Future<bool> _requestPermission(Permission? permission) async {
    final systemVersion = Platform.operatingSystemVersion;
    int deviceVersion = int.parse(systemVersion.split(' ')[1]);
   // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      late PermissionStatus status;
     // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (deviceVersion > 12) {
        status = await Permission.mediaLibrary.status;
        bool photos = await Permission.photos.isGranted;
        bool video = await Permission.mediaLibrary.isGranted;
        if (status.isGranted || photos || video) {
          return true;
        }
      } else {
        bool storage = await Permission.storage.isGranted;
        status = await Permission.storage.status;
        if (storage || status.isGranted) {
          return true;
        }
      }
    } else {
      bool storage = await Permission.storage.isGranted;
      if (storage) {
        return true;
      }
    }

    if (await permission!.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else if (result == PermissionStatus.permanentlyDenied) {
        openAppSettings();
      }
    }
    return false;
  }

  static Future<bool> hasAcceptedPermissions() async {
    if (Platform.isAndroid) {
      if (await _requestPermission(Permission.storage)) {
        return true;
      } else {
        return false;
      }
    }
    if (Platform.isIOS) {
      if (await _requestPermission(Permission.storage)) {
        return true;
      } else {
        return false;
      }
    } else {
      // not android or ios
      return false;
    }
  }
  static Future<bool> checkStoragePermissions() async {
    PermissionStatus? permissionStatus;
    final systemVersion = Platform.operatingSystemVersion;
    int deviceVersion = int.parse(systemVersion.split(' ')[1]);
   // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
   // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (Platform.isAndroid) {
      if (deviceVersion > 12) {
        permissionStatus = await Permission.photos.request();

      } else {
        permissionStatus = await Permission.storage.request();

      }
    } else {
      permissionStatus = await Permission.photos.request();
    }
    if (permissionStatus == PermissionStatus.granted) {
      return true;
    } else if (permissionStatus == PermissionStatus.denied) {
      checkStoragePermissions();
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
    }
    return false;
  }

  static Future<PermissionStatus?> askPermission() async {
    //DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final systemVersion = Platform.operatingSystemVersion;
    int deviceVersion = int.parse(systemVersion.split(' ')[1]);
    if (Platform.isIOS) {
      var photosStatus = await Permission.storage.request();

      if (photosStatus.isDenied) {
        return photosStatus;
      } else {
        return photosStatus;
      }
    } else {
      if (await Permission.storage.status.isDenied) {
      //  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        if (deviceVersion > 12) {
          var storage = await Permission.mediaLibrary.request();
          var photo = await Permission.photos.request();
          var video = await Permission.videos.request();
          if (photo.isGranted || storage.isGranted || video.isGranted) {
            return photo;
          }
        } else {
          var storageStatus = await Permission.storage.request();
          return storageStatus;
        }
      }
    }
    await openAppSettings();
    // var storageStatus = await Permission.storage.request();
    return null;

  }

/*
  static Future<bool> _requestPermission(Permission? permission) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt > 32) {
        bool storage = await Permission.storage.isGranted;
        bool photos = await Permission.photos.isGranted;
        bool video = await Permission.mediaLibrary.isGranted;

        if (storage && photos && video) {
          return true;
        }
        else {
          bool storage = await Permission.storage.isGranted;
          if (storage) {
            return true;
          }
          else  {
            bool storage = await Permission.photos.isGranted;
            if (storage) {
              return true;
            }else{
              bool storage = await Permission.photos.isGranted;
              if (storage) {
                return true;
              }
            }
          }
        }
      }
      else {
        bool storage = await Permission.photos.isGranted;
        if (storage) {
          return true;
        }
      }
    }
    else {
      bool storage = await Permission.photos.isGranted;
      if (storage) {
        return true;
      }
    }

    if (await permission!.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else if (result == PermissionStatus.permanentlyDenied) {
        openAppSettings();
      }
    }
    return false;
  }

  static Future<bool> hasAcceptedPermissions() async {
    if (Platform.isAndroid) {
      if (await _requestPermission(Permission.storage)) {
        return true;
      } else {
        return false;
      }
    }
    if (Platform.isIOS) {
      if (await _requestPermission(Permission.storage)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }*/

}
