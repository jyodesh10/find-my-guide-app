


import "package:findmyguide/constants/url_constants.dart";
import "package:findmyguide/utils/http_handler.dart";
import "package:findmyguide/utils/shared_pref.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

import "../models/message_model.dart";

class MessageController extends GetxController {
  Map<String, String>? headers = {
    "Content-Type":"application/json",
    "Authorization": "Bearer ${SharedPref.read("accessToken")}"
  };

  var loading = false.obs;
  List<MessageModel> messageList = [];
  getUserMessages() async {
    loading(true);
    List data = await handleRequest(method: "get", url: "${baseUrl}api/chat/user?user=${SharedPref.read('id')}", headers: headers);
    
    messageList = data.map((e) => MessageModel.fromMap(e)).toList();

    loading(false);
  }

  var chatloading = false.obs;
  List<Message> chatList = [];
  getMessagesbyChatId(id) async {
    chatloading(true);
    var data = await handleRequest(method: "get", url: "${baseUrl}api/chat/$id", headers: headers);
    List messages = data['messages'];
    chatList = messages.map((e) => Message.fromMap(e)).toList();
    chatList = chatList.reversed.toList();
    chatloading(false);
  }

  TextEditingController messageCon = TextEditingController();
  sendMessage(guideId, chatId, {bool? fromGuide = false}) async {
    var body = {
        "user": SharedPref.read("id").toString(),
        "guide": guideId,
        "messages": [
            {
                "content": messageCon.text,
                "senderID": SharedPref.read("id").toString()
            }
        ]
    };
    await handleRequest(method: "post", url: "${baseUrl}api/chat", headers: headers, body: body);
    messageCon.clear();
    if(fromGuide == false) {
      getMessagesbyChatId(chatId);
    } else {
      Get.back();
    }
  }

}