import 'package:ai_grammer_app/controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _chatTextEditingController =
      TextEditingController();

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        backgroundColor: Color.fromRGBO(26, 24, 24, 1),
        automaticallyImplyLeading: false,
        title: const Text(
          "AI GrammarSense",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ChatController>(
                context,
                listen: false,
              ).deleteConversation();
            },
            icon: Icon(Icons.refresh_outlined, color: Colors.white),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<ChatController>(
              builder: (context, value, child) {
                return value.chatList.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemCount: value.isLoading
                              ? value.chatList.length + 1
                              : value.chatList.length,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (index == value.chatList.length &&
                                value.isLoading) {
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF252525),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: LoadingAnimationWidget.waveDots(
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return value.chatList[index].isUser
                                ? Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 10,
                                      ),
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                            0.65,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: value.chatList[index].isLoading
                                              ? const Color.fromRGBO(
                                                  106,
                                                  83,
                                                  231,
                                                  0.4,
                                                )
                                              : value
                                                    .chatList[index]
                                                    .isCorrectCheck
                                              ? const Color.fromRGBO(
                                                  83,
                                                  177,
                                                  117,
                                                  0.4,
                                                )
                                              : const Color.fromRGBO(
                                                  237,
                                                  66,
                                                  94,
                                                  0.4,
                                                ),
                                        ),
                                        color: value.chatList[index].isLoading
                                            ? const Color.fromRGBO(
                                                106,
                                                83,
                                                231,
                                                0.1,
                                              )
                                            : value
                                                  .chatList[index]
                                                  .isCorrectCheck
                                            ? const Color.fromRGBO(
                                                83,
                                                177,
                                                117,
                                                0.2,
                                              )
                                            : const Color.fromRGBO(
                                                222,
                                                72,
                                                97,
                                                0.2,
                                              ),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Text(
                                        value.chatList[index].message,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  )
                                : Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 5),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 15,
                                          ),
                                          child: Image.asset(
                                            "assets/Union.png",
                                            height: 15,
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 10,
                                          ),
                                          constraints: BoxConstraints(
                                            maxWidth:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.65,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.white.withValues(
                                                alpha: 0.3,
                                              ),
                                            ),
                                            color: const Color(0xFF252525),
                                            borderRadius: BorderRadius.circular(
                                              18,
                                            ),
                                          ),
                                          child: Text(
                                            value.chatList[index].message,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                          },
                        ),
                      )
                    : Expanded(child: Center(child: dataNotPresent()));
              },
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: TextField(
                      controller: _chatTextEditingController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Check Grammer  ....",
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(125, 124, 130, 1),
                        ),
                        filled: true,
                        fillColor: Color.fromRGBO(25, 25, 27, 1),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(11.30),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () async {
                      FocusScope.of(context).unfocus();

                      await context.read<ChatController>().postUserRequest(
                        userInputText: _chatTextEditingController.text.trim(),
                      );

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _scrollToBottom();
                      });

                      _chatTextEditingController.clear();
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(106, 83, 231, 1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.send_outlined, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget dataNotPresent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF6A53E7).withOpacity(0.35),
                    const Color(0xFF6A53E7).withOpacity(0.0),
                  ],
                ),
              ),
            ),
            Container(
              height: 108,
              width: 108,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF7B63F0), Color(0xFF5B3FD3)],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6A53E7).withOpacity(0.5),
                    blurRadius: 32,
                    spreadRadius: 4,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Image.asset("assets/Icon.png", fit: BoxFit.none),
            ),
            Positioned(
              right: 16,
              top: 16,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF0A0A0F).withAlpha(250),
                ),
                child: Image.asset("assets/Union.png"),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          "What can I do to help?",
          style: TextStyle(
            color: Color.fromRGBO(125, 124, 130, 1),
            fontSize: 22,
          ),
        ),
      ],
    );
  }
}
