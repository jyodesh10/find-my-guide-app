import 'package:findmyguide/constants/font_constants.dart';
import 'package:findmyguide/controllers/message_controller.dart';
import 'package:findmyguide/models/message_model.dart';
import 'package:findmyguide/utils/shared_pref.dart';
import 'package:findmyguide/widgets/custom_appbar.dart';
import 'package:findmyguide/widgets/loading_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/color_constants.dart';

class MessageDetailsView extends StatefulWidget {
  const MessageDetailsView({super.key, required this.id, required this.guideId, required this.title});

  final String id;
  final String guideId;
  final String title;

  @override
  State<MessageDetailsView> createState() => _MessageDetailsViewState();
}

class _MessageDetailsViewState extends State<MessageDetailsView> {

  final controller = Get.put(MessageController());

  @override
  void initState() {
    super.initState();
    fetch();
    
  }

  fetch() async {
    await controller.getMessagesbyChatId(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryClr,
      // resizeToAvoidBottomInset: false,
      appBar: customAppbar(
        title: widget.title
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => controller.chatloading.isTrue
              ? const LoadingGif()
              : ListView.separated(
                itemCount: controller.chatList.length,
                reverse: true,
                padding: EdgeInsets.all(15.sp),
                itemBuilder: (context, index) {
                  controller.chatList.reversed;
                  Message message = controller.chatList[index];
                  return Container(
                    padding: EdgeInsets.symmetric(vertical:  14.sp, horizontal: 12.sp),
                    margin: EdgeInsets.only(
                      left: message.senderId.toString() == SharedPref.read('id').toString() ? 45.w: 0,
                      right: message.senderId.toString() == SharedPref.read('id').toString() ? 0: 45.w,
                    ),
                    alignment: message.senderId.toString() == SharedPref.read('id').toString() ? Alignment.centerRight : Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: message.senderId.toString() == SharedPref.read('id').toString() ? greyblue: green.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Text("${message.content}", style: midTextStyle,),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 15.sp,),
              ),
            ),
          ),
          Container(
            height: 37.sp,
            width: double.infinity,
            padding: EdgeInsets.all(12.sp),
            color: white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Write a message",
                      hintStyle: midTextStyle.copyWith(color: black.withOpacity(0.5)),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: white
                    ),
                    controller: controller.messageCon,
                  ) 
                ),
                IconButton(
                  onPressed: () {
                    controller.sendMessage(widget.guideId, widget.id);
                  }, 
                  icon: const Icon(Icons.send, color: blue,)
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}