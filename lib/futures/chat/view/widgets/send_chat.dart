import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:socialapp/controller/chat_controller.dart';
import 'package:socialapp/core/extension/padding_extension.dart';
import 'package:socialapp/core/widgets/custom_text_field.dart';
import 'package:socialapp/model/user_model.dart';
import 'package:socialapp/service/user_service.dart';

// ignore: must_be_immutable
class SendChat extends StatelessWidget {
  SendChat({super.key, required this.user});
  ChatController controller = Get.find();
  UserModel user;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(builder: (controller) {
      return Column(
        children: [
          SizedBox(
            child: controller.messageImage == null
                ? const SizedBox()
                : Image.file(
                    controller.messageImage!,
                    height: 100.h,
                    width: 100.w,
                    fit: BoxFit.fill,
                  ),
          ),
          Row(
            children: [
              StreamBuilder(
                  stream: UserService().getCurrentUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Something went wrong!'),
                      );
                    }
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(50.sp),
                      child: Image.network(snapshot.data!.profileImage,
                          height: 45, width: 45, fit: BoxFit.fill),
                    );
                  }),
              SizedBox(width: 10.sp),
              Expanded(
                child: CustomTextField(
                  hintText: 'comment',
                  textController: controller.messageController,
                  obsecureText: false,
                  textInputType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your comment';
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.pickMessageImage();
                    },
                    icon: const Icon(Icons.photo_library),
                  ),
                ),
              ),
              GetBuilder<ChatController>(builder: (controller) {
                return SizedBox(
                  child: controller.isLoading
                      ? const CircularProgressIndicator().padding(4.w, 4.h)
                      : IconButton(
                          onPressed: () {
                            controller.sendMessage(user.uid);
                          },
                          icon: const Icon(Icons.send),
                        ),
                );
              })
            ],
          ),
        ],
      );
    });
  }
}
