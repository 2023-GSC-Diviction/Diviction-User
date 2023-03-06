import 'package:diviction_user/config/style.dart';
import 'package:diviction_user/screen/community/community_screen.dart';
import 'package:diviction_user/widget/profile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/post.dart';
import '../../service/community_service.dart';
import '../../widget/appbar.dart';

final communityProvider = FutureProvider<List<Post>>((ref) async {
  return await CommunityService().getPost();
});

class CommentScreen extends ConsumerStatefulWidget {
  const CommentScreen({super.key, required this.post});

  final Post post;

  @override
  CommentScreenState createState() => CommentScreenState();
}

class CommentScreenState extends ConsumerState<CommentScreen> {
  final _controller = TextEditingController();
  String newComment = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // 키보드 닫기 이벤트
        },
        child: Scaffold(
            appBar: const MyAppbar(
                isMain: false, hasBack: true, title: 'DIVICTION COMMUNITY'),
            body: Stack(children: [
              Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: SingleChildScrollView(
                      child: Column(children: [
                    PostItem(post: widget.post),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Divider(
                            color: Color.fromRGBO(234, 234, 234, 1),
                            thickness: 1.0)),
                    const Text('comment',
                        style: TextStyles.descriptionTextStyle),
                    const SizedBox(
                      height: 8,
                    ),
                    widget.post.comment.isNotEmpty
                        ? Column(
                            children: widget.post.comment
                                .map((e) => CommentItem(comment: e))
                                .toList())
                        : Container(
                            padding: const EdgeInsets.only(top: 10),
                            child: const Text('댓글이 없습니다.',
                                style: TextStyles.descriptionTextStyle),
                          )
                  ]))),
              Positioned(child: addComment(), bottom: 0, left: 0, right: 0)
            ])));
  }

  Widget addComment() => Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Color.fromARGB(35, 0, 0, 0), blurRadius: 10)
        ],
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        maxLines: null,
        controller: _controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.upload_rounded),
            color: Colors.blue,
          ),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          labelText: 'add a comment...',
        ),
        onChanged: (value) {
          newComment = value;
        },
      ));
}

class CommentItem extends StatefulWidget {
  const CommentItem({super.key, required this.comment});

  final Comment comment;

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileButton(
          nickname: widget.comment.id,
          id: widget.comment.id,
        ),
        Container(
          margin:
              const EdgeInsets.only(bottom: 10, top: 15, left: 30, right: 10),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.zero,
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              color: Colors.grey[200]),
          child: Text(widget.comment.content,
              style: TextStyles.chatNicknameTextStyle),
        )
      ],
    );
  }
}
