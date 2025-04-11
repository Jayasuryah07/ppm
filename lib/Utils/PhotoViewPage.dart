import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ConstHelper.dart';


class PhotoViewPage extends StatefulWidget {
  String imagePath="";
  PhotoViewPage({super.key,required this.imagePath});

  @override
  State<PhotoViewPage> createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          iconTheme: IconThemeData(color: ConstHelper.whiteColor),
          backgroundColor: Colors.black,
          title: Text('photo'.tr,style: TextStyle(color: ConstHelper.whiteColor),),
          centerTitle: true,
        ),
        body: InteractiveViewer(
          minScale: 1.0,
          maxScale: 3.0,
          child: Image.file(File(widget.imagePath),height: Get.height,width: Get.width,), // Optional: Align panning to one axis
        ),
      ),
    );
  }
}
