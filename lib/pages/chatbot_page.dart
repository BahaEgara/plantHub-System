import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

// === Gemini API key ===
const String geminiApiKey = "AIzaSyDfeJ3G5FBb83BluzmokQW8LGQBdCkEzIY";

class ChatMessage {
  String text;
  final bool isUser;
  final String time;
  final bool isTyping;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.time,
    this.isTyping = false,
  });
}

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});
  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  final List<ChatMessage> messages = [
    ChatMessage(
      text: "Habari! Mimi ni PlantHub Assistant 🌿. Nawezaje kusaidia leo?",
      isUser: false,
      time: "09:30 am",
    )
  ];

  final List<List<ChatMessage>> pastConversations = [];

  // === Send Text ===
  void send() async {
    if (controller.text.isNotEmpty) {
      final userMessage = ChatMessage(
        text: controller.text,
        isUser: true,
        time: _formatTime(),
      );

      setState(() {
        messages.add(userMessage);
        messages.add(ChatMessage(
          text: "...",
          isUser: false,
          time: _formatTime(),
          isTyping: true,
        ));
      });

      final userText = controller.text;
      controller.clear();

      try {
        final reply = await _getGeminiResponse(userText);
        _simulateStreamingResponse(reply);
      } catch (e) {
        setState(() {
          messages.removeWhere((msg) => msg.isTyping);
          messages.add(ChatMessage(
            text: "Samahani kuna tatizo: $e",
            isUser: false,
            time: _formatTime(),
          ));
        });
      }
    }
  }

  // === Gemini API Request ===
  Future<String> _getGeminiResponse(String prompt) async {
    const model = "gemini-1.5-flash-latest";
    final url = Uri.parse(
        "https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$geminiApiKey");

    final history = messages
        .where((m) => m.text.isNotEmpty)
        .map((m) => {
              "role": m.isUser ? "user" : "model",
              "parts": [
                {"text": m.text}
              ]
            })
        .toList();

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": history + [
          {
            "role": "user",
            "parts": [
              {"text": prompt}
            ]
          }
        ],
        "generationConfig": {
          "temperature": 0.7,
          "maxOutputTokens": 512,
        }
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["candidates"]?[0]?["content"]?["parts"]?[0]?["text"] ??
          "Samahani, sijapata jibu kutoka AI.";
    } else {
      throw "Server error (${response.statusCode}): ${response.reasonPhrase}";
    }
  }

  // === Image and Notes Handling ===
  void _showMediaOptions() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Take Photo"),
              onTap: () async {
                Navigator.pop(ctx);
                final picked = await _picker.pickImage(source: ImageSource.camera);
                if (picked != null) _processImage(File(picked.path));
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Choose from Gallery"),
              onTap: () async {
                Navigator.pop(ctx);
                final picked = await _picker.pickImage(source: ImageSource.gallery);
                if (picked != null) _processImage(File(picked.path));
              },
            ),
            ListTile(
              leading: const Icon(Icons.note_add),
              title: const Text("Add Notes"),
              onTap: () {
                Navigator.pop(ctx);
                _askForNotes();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _processImage(File image) {
    setState(() {
      messages.add(ChatMessage(
        text: "[📷 Image attached: ${image.path.split('/').last}]",
        isUser: true,
        time: _formatTime(),
      ));
      messages.add(ChatMessage(
        text: "...",
        isUser: false,
        time: _formatTime(),
        isTyping: true,
      ));
    });

    // Future enhancement: integrate Gemini Vision model
    Future.delayed(const Duration(seconds: 2), () {
      _simulateStreamingResponse(
        "Tunachambua picha yako ya mimea... 🚜\n\n"
        "⚠️ Inaonekana kama dalili za *Maize Lethal Necrosis (MLN)*.\n\n"
        "👉 Sababu: Virusi vya MCMD + Potyviruses.\n"
        "👉 Suluhisho: Tumia mbegu zilizoidhinishwa, dhibiti wadudu (thrips, aphids), "
        "fanya crop rotation, na ondoa mimea iliyoathirika.\n"
        "💡 Ushauri: Kagua mashamba mara kwa mara kudhibiti kuenea.",
      );
    });
  }

  void _askForNotes() {
    final noteController = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Notes"),
        content: TextField(
          controller: noteController,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: "Describe your issue...",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                messages.add(ChatMessage(
                  text: "[📝 Note]: ${noteController.text}",
                  isUser: true,
                  time: _formatTime(),
                ));
                messages.add(ChatMessage(
                  text: "...",
                  isUser: false,
                  time: _formatTime(),
                  isTyping: true,
                ));
              });
              Future.delayed(const Duration(seconds: 2), () {
                _simulateStreamingResponse(
                  "Asante kwa taarifa zako. AI inashughulikia "
                  "na itakupa ushauri hivi karibuni...",
                );
              });
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }

  // === Streaming effect ===
  void _simulateStreamingResponse(String fullResponse) {
    setState(() {
      messages.removeWhere((msg) => msg.isTyping);
      messages.add(ChatMessage(
        text: "",
        isUser: false,
        time: _formatTime(),
      ));
    });

    int index = 0;
    Timer.periodic(const Duration(milliseconds: 40), (timer) {
      if (index < fullResponse.length) {
        setState(() {
          messages.last.text += fullResponse[index];
        });
        index++;
      } else {
        timer.cancel();
      }
    });
  }

  String _formatTime() {
    final now = TimeOfDay.now();
    final hour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
    final minute = now.minute.toString().padLeft(2, '0');
    final suffix = now.period == DayPeriod.am ? "am" : "pm";
    return "$hour:$minute $suffix";
  }

  void _saveConversation() {
    if (messages.isNotEmpty) {
      pastConversations.add(List.from(messages));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text("Previous Conversations",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: pastConversations.length,
                  itemBuilder: (context, index) {
                    final convo = pastConversations[index];
                    final preview = convo.isNotEmpty ? convo.first.text : "";
                    return ListTile(
                      title: Text("Chat ${index + 1}"),
                      subtitle: Text(preview,
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          messages
                            ..clear()
                            ..addAll(convo);
                        });
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage("assets/profile.png"),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("PlantHub Assistant",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text("online", style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: _saveConversation,
            icon: const Icon(Icons.save_alt),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return Align(
                  alignment:
                      msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: msg.isUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(12),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7),
                        decoration: BoxDecoration(
                          color: msg.isUser
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: msg.isTyping
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  _TypingDot(),
                                  SizedBox(width: 4),
                                  _TypingDot(),
                                  SizedBox(width: 4),
                                  _TypingDot(),
                                ],
                              )
                            : Text(
                                msg.text,
                                style: TextStyle(
                                  color: msg.isUser
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Text(
                          msg.time,
                          style: const TextStyle(
                              fontSize: 11, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                IconButton(
                  onPressed: _showMediaOptions,
                  icon: const Icon(Icons.add_circle_outline),
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "Write your request...",
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: send,
                  icon: Icon(Icons.send,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// === Typing animation ===
class _TypingDot extends StatefulWidget {
  const _TypingDot();

  @override
  State<_TypingDot> createState() => _TypingDotState();
}

class _TypingDotState extends State<_TypingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(milliseconds: 600), vsync: this)
          ..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween(begin: 0.7, end: 1.2).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      ),
      child: Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black54,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
