import 'package:amatta_front/common/const/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class TextEditor extends StatefulWidget {
  const TextEditor({super.key});

  @override
  State<TextEditor> createState() => _EditorState();
}

class _EditorState extends State<TextEditor> {
  late QuillController quillController;
  late ScrollController scrollController;
  @override
  void initState() {
    // TODO: implement initState
    quillController = QuillController.basic();
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    quillController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // color: Colors.blue,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: QuillToolbar.simple(
            controller: quillController,
            configurations: QuillSimpleToolbarConfigurations(
              multiRowsDisplay: false,
              showIndent: false,
              showSearchButton: false,
              showClipboardCopy: false,
              showClipboardCut: false,
              showClipboardPaste: false,
              sharedConfigurations: const QuillSharedConfigurations(
                  // locale: Locale('ko_KR'),
                  ),
            ),
          ),
        ),
        Container(
          height: 200,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          color: BACK_GROUND_COLOR_LIGHT,
          child: QuillEditor.basic(
            controller: quillController,
            configurations: QuillEditorConfigurations(
              // readOnly: false,
              sharedConfigurations: const QuillSharedConfigurations(
                  // locale: Locale('ko_KR'),
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
