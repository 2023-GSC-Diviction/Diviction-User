import 'package:diviction_user/screen/community/new_post_screen.dart';
import 'package:diviction_user/service/community_service.dart';
import 'package:diviction_user/widget/appbar.dart';
import 'package:diviction_user/widget/profile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/style.dart';
import '../../model/post.dart';
import '../../widget/profile_image.dart';
import '../day_check_screen.dart';

final communityProvider = FutureProvider<List<Post>>((ref) async {
  return await CommunityService().getPost();
});

class CommunityScreen extends ConsumerStatefulWidget {
  const CommunityScreen({super.key});

  @override
  CommunityScreenState createState() => CommunityScreenState();
}

class CommunityScreenState extends ConsumerState<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    // final post = ref.watch(communityProvider).when(
    //     data: (value) => value,
    //     loading: () => null,
    //     error: (error, stackTrace) => null);

    final post = <Post>[
      Post(
          content:
              'How r u? Today is a good day to study flutter and dart. I\'m so surprised! Copilot is so good. I can\'t believe. Maybe you love it',
          date: '1020',
          image: null,
          category: 'category',
          comment: [],
          id: 'jeong'),
      Post(
          content: 'How r u? Today is a good day to study flutter and dart. ',
          date: '1020',
          image: 'null',
          category: 'category',
          comment: [],
          id: 'jeong'),
      Post(
          content:
              'How r u? Today is a good day to study flutter and dart. I\'m so surprised! Copilot is so good. I can\'t believe. Maybe you love it',
          date: '1020',
          image: null,
          category: 'category',
          comment: [],
          id: 'jeong'),
      Post(
          content:
              'How r u? Today is a good day to study flutter and dart. I\'m so surprised! Copilot is so good. I can\'t believe. Maybe you love it. How r u? Today is a good day to study flutter and dart. How r u? Today is a good day to study flutter and dart.',
          date: '1020',
          image: null,
          category: 'category',
          comment: [],
          id: 'jeong'),
      Post(
          content:
              'How r u? Today is a good day to study flutter and dart. I\'m so surprised! Copilot is so good. I can\'t believe. Maybe you love it',
          date: '1020',
          image: null,
          category: 'category',
          comment: [],
          id: 'jeong'),
      Post(
          content:
              'How r u? Today is a good day to study flutter and dart. I\'m so surprised! Copilot is so good. I can\'t believe',
          date: '1020',
          image: null,
          category: 'category',
          comment: [],
          id: 'jack')
    ];

    return Scaffold(
      appBar: const MyAppbar(
          isMain: false, hasBack: false, title: 'DIVICTION COMMUNITY'),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NewPostScreen()));
        },
        label: const Text('new post'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: MediaQuery.of(context).size.height,
          child: postListView(post)),
    );
  }

  Widget postListView(List<Post>? postList) {
    switch (postList) {
      case null:
        return loadingWidget();
      case []: // empty list
        return emptyWidget();
      default:
        return SingleChildScrollView(
            child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 10, top: 15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200]),
                child: const Text(
                    'Welcome to DIVICTION community😁 You can share your experience and get help from other people🫶',
                    style: TextStyles.chatNicknameTextStyle)),
            const SizedBox(
              height: 10,
            ),
            Column(
                children:
                    postList!.map((e) => PostItemWidget(post: e)).toList())
          ],
        ));
    }
  }

  Widget loadingWidget() => const Center(child: CircularProgressIndicator());
  Widget failWidget() => const Center(child: Text('fail'));
  Widget emptyWidget() => const Center(
          child: Text(
        'There is no post',
      ));
}

class PostItemWidget extends StatelessWidget {
  const PostItemWidget({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ProfileButton(nickname: post.id, id: 'id'),
      Container(
          margin:
              const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 15),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
          child: post.image != null
              ? Column(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width - 82,
                        height: MediaQuery.of(context).size.width - 82,
                        child: Image.network(post.image!,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset('assets/images/test.png',
                                    fit: BoxFit.cover))),
                    const SizedBox(height: 10),
                    Text(post.content, style: TextStyles.chatNicknameTextStyle),
                  ],
                )
              : Text(post.content, style: TextStyles.chatNicknameTextStyle)),
      Container(
        alignment: Alignment.centerRight,
        width: double.infinity,
        margin: const EdgeInsets.only(right: 10),
        height: 25,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('comment', style: TextStyles.commentBtnTextStyle),
              const SizedBox(width: 5),
              Icon(
                Icons.comment,
                size: 25,
                color: Colors.grey[400],
              ),
            ]),
      ),
    ]);
  }
}
