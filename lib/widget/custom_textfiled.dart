import 'package:flutter/material.dart';

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
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                widget.TitleContent,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: TextField(
                maxLines: null,
                readOnly: widget.isreadOnly,
                controller: widget.textEditingController,
                cursorColor: Colors.grey,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true, // 이걸 true로 해야 색상을 넣어줄 수 있음
                  fillColor: Colors.grey[100],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
