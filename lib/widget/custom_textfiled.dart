import 'package:flutter/material.dart';

import '../config/style.dart';

class CustomTextEditor extends StatefulWidget {
  final String TitleContent;
  final TextEditingController textEditingController;
  final bool isreadOnly;
  // final VoidCallback onPressedEditButton;

  const CustomTextEditor({
    Key? key,
    required this.TitleContent,
    required this.textEditingController,
    required this.isreadOnly,
    // required this.onPressedEditButton,
  }) : super(key: key);

  @override
  State<CustomTextEditor> createState() => _CustomTextEditorState();
}

class _CustomTextEditorState extends State<CustomTextEditor> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            width: MediaQuery.of(context).size.width,
            child: Text(
              widget.TitleContent,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: TextField(
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              maxLines: null,
              readOnly: widget.isreadOnly,
              controller: widget.textEditingController,
              cursorColor: Colors.grey,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true, // 이걸 true로 해야 색상을 넣어줄 수 있음
                fillColor: Palette.appColor.withOpacity(0.2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
