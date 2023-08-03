import 'dart:typed_data';

import 'package:coba_coba/constant.dart';
import 'package:coba_coba/helper/encrypt.dart';
import 'package:flutter/cupertino.dart';

PackageHeaders({required Uint8List buf}) {
//Get package Signature
  ValueNotifier<int> getSignature = ValueNotifier(Encrypt().encrypt4(buf, 0));
// Pkg Length	Unsigned Int	4
  ValueNotifier<int> getPkgLenght = ValueNotifier(Encrypt().encrypt4(buf, 4));
// Pkg Id	Unsigned Short	2
  ValueNotifier<int> getPackageID = ValueNotifier(Encrypt().encrypt2(buf, 8));
//Get Common Flags

  ValueNotifier<int> getCommonFlags =
      ValueNotifier(Encrypt().encrypt2(buf, 10));
//Get Error Code
  ValueNotifier<int> getErrorCode = ValueNotifier(Encrypt().encrypt2(buf, 12));
//Get Reserved
  ValueNotifier<int> getReserved = ValueNotifier(Encrypt().encrypt4(buf, 14));

  if (Constans.PACKAGE_ID_LOGIN == getPackageID.value) {
    print("Package ID nya : ${getPackageID.value}");
  } else {
    print("${getPackageID.value}");
  }
  return HeaderModel(
    packageSignature: getSignature.value,
    packageLength: getPkgLenght.value,
    packageId: getPackageID.value,
    commonFlags: getCommonFlags.value,
    errorCode: getErrorCode.value,
    reserved: getReserved.value,
  ).toJson();
//-------------------------End Encrypt Header-----------------------------------
}

// dsdsdsdsd

class HeaderModel {
  int? packageSignature;
  int? packageLength;
  int? packageId;
  int? commonFlags;
  int? errorCode;
  int? reserved;
  HeaderModel({
    this.packageSignature,
    this.packageLength,
    this.packageId,
    this.commonFlags,
    this.errorCode,
    this.reserved,
  });

  HeaderModel.fromJson(Map<String, dynamic> json) {
    packageSignature = json['packageSignature'];
    packageLength = json['packageLength'];
    packageId = json['packageId'];
    commonFlags = json['commonFlags'];
    errorCode = json['errorCode'];
    reserved = json['reserved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['packageSignature'] = packageSignature;
    data['packageLength'] = packageLength;
    data['packageId'] = packageId;
    data['commonFlags'] = commonFlags;
    data['errorCode'] = errorCode;
    data['reserved'] = reserved;
    print("PACKAGE SIGNATURE CONSTANS: ${Constans.PKG_SIGNATURE}");
    print("DATA HEADER: $data");
    return data;
  }
}
