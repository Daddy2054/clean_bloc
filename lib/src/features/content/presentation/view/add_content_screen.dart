import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:path/path.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../../../shared/presentation/widgets/widgets.dart';
import '../blocs/add_content/add_content_cubit.dart';

class AddContentScreen extends StatelessWidget {
  const AddContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Content'),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              context.read<AddContentCubit>().reset();
            },
            icon: const Icon(Icons.clear),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: BlocConsumer<AddContentCubit, AddContentState>(
        buildWhen: (previous, current) => previous.video != current.video,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state.video == null) {
            return Center(
              child: ElevatedButton(
                onPressed: () async {
                  await _handleVideo().then((video) {
                    if (video != null) {
                      context.read<AddContentCubit>().videoChanged(video);
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: Text(
                  'Select a Video',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            );
          }
          if (state.video != null) {
            debugPrint(state.video!.path);
            return CustomVideoPlayer(
              assetPath: state.video!.path,
            );
          } else {
            return const Text('Something went wrong.');
          }
        },
      ),
    );
  }

  Future<File?> _handleVideo() async {
    XFile? uploadedVideo = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (uploadedVideo == null) {
      // return;
      return null;
    }

    final directory = await getApplicationDocumentsDirectory();
    final fileName = p.basename(uploadedVideo.path);
    final savedVideo =
        await File(uploadedVideo.path).copy('${directory.path}/$fileName');
    debugPrint(savedVideo.toString());
    return savedVideo;
  }
}
