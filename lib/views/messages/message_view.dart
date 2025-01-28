import 'package:findmyguide/constants/font_constants.dart';
import 'package:findmyguide/controllers/message_controller.dart';
import 'package:findmyguide/models/message_model.dart';
import 'package:findmyguide/utils/date_formatter.dart';
import 'package:findmyguide/utils/shared_pref.dart';
import 'package:findmyguide/views/messages/message_details_view.dart';
import 'package:findmyguide/widgets/custom_appbar.dart';
import 'package:findmyguide/widgets/custom_cacheimage.dart';
import 'package:findmyguide/widgets/empty_widget.dart';
import 'package:findmyguide/widgets/loading_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/color_constants.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {

  final controller = Get.put(MessageController());
  @override
  void initState() {
    super.initState();
    controller.getUserMessages();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryClr,
      resizeToAvoidBottomInset: false,
      appBar: customAppbar(
        title: "My messages"
      ),
      body: Obx(() => controller.loading.isTrue
        ? const LoadingGif()
        : controller.messageList.isNotEmpty 
          ? ListView.separated(
            itemCount: controller.messageList.length,
            itemBuilder: (context, index) {
              MessageModel message = controller.messageList[index];
              return ListTile(
                leading: SizedBox(
                  height: 30.sp,
                  width: 30.sp,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CustomCachedNetworkImage(imageUrl: message.guide!.image.toString()),
                  ),
                ),
                isThreeLine: true,
                title: Text("${message.guide!.firstname} ${message.guide!.lastname}", style: midTextStyle,),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateTimeFormatter.formatDate(message.messages!.last.createdAt.toString()), style: smallTextStyle.copyWith(fontSize: 13.sp),),
                    Text("${message.messages!.last.senderId.toString()==SharedPref.read('id').toString()?"You":message.guide!.firstname}: ${message.messages!.last.content}", style: subtitleStyle.copyWith(color: black.withOpacity(0.5),fontWeight: FontWeight.w500),),                 ],
                ),
                onTap: () => Get.to(()=> MessageDetailsView(title: "${message.guide!.firstname} ${message.guide!.lastname}", id: message.id.toString(), guideId: message.guide!.id.toString(),)),
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 15.sp,),
          )
          : const EmptyWidget(text: "No messages",)
      ),
    );
  }
}