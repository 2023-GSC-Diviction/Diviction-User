import 'dart:io';

import 'package:diviction_user/provider/image_pick_provider.dart';
import 'package:diviction_user/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../config/style.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({super.key});

  @override
  NewPostScreenState createState() => NewPostScreenState();
}

class NewPostScreenState extends State<NewPostScreen> {
  String text = '';
  final textFieldController = TextEditingController();

  @override
  void dispose() {
    textFieldController.dispose();
    // ref.invalidate(imagePickerProvider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // 키보드 닫기 이벤트
        },
        child: Scaffold(
          appBar:
              const MyAppbar(isMain: false, hasBack: true, title: 'New Post'),
          body: Container(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 20, top: 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const ProfileButton(
                      //   nickname: 'nickname',
                      //   id: 'id',
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      const ImageWidget(),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'The maximum count of images is 5.',
                        style: TextStyles.descriptionTextStyle,
                      ),
                      textFieldBox(),
                    ],
                  ),
                  addPostButton(context),
                ],
              )),
        ));
  }

  Widget textFieldBox() => Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
        child: TextField(
            onChanged: (value) => text = value,
            controller: textFieldController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            maxLength: 1000,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              focusedBorder:
                  const UnderlineInputBorder(borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.all(16),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
              focusColor: Colors.transparent,
              hintText: 'What is your problem?',
              hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 14.0,
              ),
            )),
      );

  Widget addPostButton(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        alignment: Alignment.center,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'Upload',
          style: TextStyles.dialogConfirmTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
      onTap: () {
        Navigator.pop(context, true);
      },
    );
  }
}

final imagePickerProvider =
    StateNotifierProvider<ImageState, List<File>>((ref) {
  return ImageState();
});

class ImageWidget extends ConsumerWidget {
  const ImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = ref.watch(imagePickerProvider);

    Widget imageBox(File img) {
      double imgBoxSize = ((MediaQuery.of(context).size.width - 32) / 5) - 4;

      return GestureDetector(
          onTap: () => ref.read(imagePickerProvider.notifier).delImage(img),
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: imgBoxSize,
              height: imgBoxSize,
              child: Stack(children: [
                Center(
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.file(File(img.path)).image),
                            borderRadius: BorderRadius.circular(10)),
                        width: imgBoxSize,
                        height: imgBoxSize)),
                Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(Icons.close,
                            size: 15, color: Colors.grey[400])))
              ])));
    }

    Widget imageRow() {
      return Row(children: [
        if (images.length == 5) ...[
          ...images.map((e) => imageBox(e)).toList(),
        ] else ...[
          ...images.map((e) => imageBox(e)).toList(),
          InkWell(
              onTap: () => ref.read(imagePickerProvider.notifier).getImage(),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: MediaQuery.of(context).size.width * 0.17,
                height: MediaQuery.of(context).size.width * 0.17,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image, color: Colors.grey[400]!),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'image',
                      style: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0),
                    )
                  ],
                ),
              ))
        ]
      ]);
    }

    return imageRow();
  }
}
