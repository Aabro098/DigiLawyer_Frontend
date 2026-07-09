import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:digi_lawyer/common/reusables/message_card.dart';
import 'package:digi_lawyer/common/reusables/search_text.dart';
import 'package:digi_lawyer/extensions/context_extensions.dart';
import 'package:digi_lawyer/providers/chatbot_provider.dart';
import 'package:digi_lawyer/utils/constants/image_strings.dart';
import 'package:digi_lawyer/utils/constants/sizes.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  // bool _isUnlocked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AutoSizeText(
          "DigiLawyer",
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: const ChatBootUI(),
    );
  }
}

class ChatBootUI extends StatefulWidget {
  const ChatBootUI({super.key});

  @override
  State<ChatBootUI> createState() => _ChatBootUIState();
}

class _ChatBootUIState extends State<ChatBootUI> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: Consumer<ChatbotProvider>(
          builder: (context, chatbotProvider, _) {
            final messages = chatbotProvider.messages;
            final isLoading =
                chatbotProvider.isLoading; // Add this to your provider

            // Auto-scroll when messages change or loading state changes
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (messages.isNotEmpty || isLoading) {
                _scrollToBottom();
              }
            });

            return Column(
              children: [
                Expanded(
                  child: messages.isEmpty && !isLoading
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Lottie.asset(
                              AppImages.robotHello,
                              height: context.screenHeight * 0.35,
                              width: context.screenWidth * 0.5,
                              fit: BoxFit.cover,
                            ),
                            Center(
                              child: AutoSizeText(
                                context.tr('no_messages'),
                                style: context.textTheme.bodyMedium,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount: messages.length + (isLoading ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == messages.length) {
                              return const MessageCard(
                                message: '',
                                isSentByMe: false,
                                isLoading: true,
                              );
                            }

                            final msg = messages[index];
                            return MessageCard(
                              message: msg.message,
                              isSentByMe: msg.isSentByMe,
                            );
                          },
                        ),
                ),
                const SizedBox(
                  height: AppSizes.sm,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Expanded(
                        child: RoundedTextField(
                          hintText: context.tr('ask_bot'),
                          fillColor: Colors.grey.shade200,
                          textColor: Colors.black,
                          controller: _controller,
                          enabled: isLoading ? false : true,
                        ),
                      ),
                      FittedBox(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: isLoading
                              ? null
                              : () async {
                                  final query = _controller.text.trim();
                                  if (query.isEmpty) return;
                                  _controller.clear();
                                  await chatbotProvider.getMessages(
                                    query: query,
                                  );
                                },
                          icon: const Icon(Iconsax.send_1,
                              color: Colors.blueGrey),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
