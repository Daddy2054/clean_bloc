import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:path/path.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class AddContentScreen extends StatelessWidget {
  const AddContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Content'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _handleVideo();
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
          child: Text(
            'Select a Video',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }

  Future<void> _handleVideo() async {
    XFile? uploadedVideo = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (uploadedVideo == null) {
      return;
//      return null;
    }

    final directory = await getApplicationDocumentsDirectory();
    final fileName = p.basename(uploadedVideo.path);
    final savedVideo =
        await File(uploadedVideo.path).copy('${directory.path}/$fileName');
    debugPrint(savedVideo.toString());
  }
}
