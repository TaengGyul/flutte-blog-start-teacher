import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/constants/size.dart';
import 'package:flutter_blog/_core/utils/validator_util.dart';
import 'package:flutter_blog/ui/pages/post/list_page/post_list_vm.dart';
import 'package:flutter_blog/ui/pages/post/write_page/post_write_fm.dart';
import 'package:flutter_blog/ui/widgets/custom_elavated_button.dart';
import 'package:flutter_blog/ui/widgets/custom_text_area.dart';
import 'package:flutter_blog/ui/widgets/custom_text_form_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostWriteForm extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PostWriteFM fm = ref.read(postWriteProvider.notifier);
    PostListVM vm = ref.read(postListProvider.notifier); // List에 접근 해야 함
    PostWriteModel model =
        ref.watch(postWriteProvider); // read로 하고 post_list_vm에 Logger로 로그 확인하니 전달 안됨 -> watch로 수정 후 전달 됨

    return Form(
      child: ListView(
        shrinkWrap: true,
        children: [
          CustomTextFormField(
            hint: "Title",
            onChanged: (value) {
              fm.title(value);
            },
          ),
          const SizedBox(height: smallGap),
          CustomTextArea(
              hint: "Content",
              onChanged: (value) {
                fm.content(value);
              }),
          const SizedBox(height: largeGap),
          CustomElevatedButton(
            text: "글쓰기",
            click: () {
              vm.write(model.title, model.content);
            }, // 가장 가까운 뷰모델에서 가져 오면 됨 (ex. 글쓰기는 리스트에서 상태가 변경되는 거니까 리스트가 가까움)
          ),
        ],
      ),
    );
  }
}
