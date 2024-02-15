import 'package:flutter/material.dart';
import 'package:HappyLink/Models/MessageModel.dart';
import 'package:HappyLink/User_View/views/call.dart';
import 'package:HappyLink/User_View/views/chatRoom/ownMessageCart.dart';
import 'package:HappyLink/User_View/views/chatRoom/reply_cart.dart';
import 'package:HappyLink/data/baseApi.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends StatefulWidget {
  final String? sourceId;
  final String? targetId;
  final String TargetName;

  ChatPage({super.key, this.sourceId, this.targetId, required this.TargetName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  FocusNode focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();
  late IO.Socket socket;
  bool sendbutton = false;

  List<MessageModel> messages = [];
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
  }

  void sendmessage(String msg, String sourceId, String? targetId) {
    if (targetId != null && targetId.isNotEmpty) {
      setMessage("source", msg);
      socket.emit("message",
          {"message": msg, "sourceId": sourceId, "targetId": targetId});
    } else {
      print("Cannot send message: Target ID is null or empty");
    }
  }

  void setMessage(String type, String message) {
    if (mounted) {
      MessageModel messageModel = MessageModel(types: type, message: message);
      setState(() {
        messages.add(messageModel);
      });
    }
  }

  void connect() {
    socket = IO.io(Urls.mainurl, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();

    print(socket.connected);
    socket.emit("signin", widget.sourceId);
    socket.onConnect((data) {
      print("Connected");
    });
    socket.on("message", (dynamic msg) {
      if (msg is String) {
        print(msg);
        setMessage("destination", msg);
      } else if (msg is Map<String, dynamic>) {
        String message = msg['message'] ?? '';
        setMessage("destination", message);
      } else {
        print("Received unexpected message format: $msg");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[18],
      appBar: AppBar(
        leadingWidth: 80,
        toolbarHeight: 70,
        backgroundColor: Color.fromRGBO(140, 140, 216, 1),
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.pink),
              )
            ],
          ),
        ),
        title: Column(
          children: [
            Text(
              widget.TargetName,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            Text(
              TimeOfDay.now().toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyCall(
                              callID: widget.targetId!,
                            )));
              },
              icon: Icon(Icons.video_call)),
          PopupMenuButton<String>(itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: Text("Block user"),
                value: "Block User",
              ),
              PopupMenuItem(
                child: Text("Call"),
                value: "Call",
              )
            ];
          })
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                physics: BouncingScrollPhysics(),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  // if (index == messages.length) {
                  //   return Container(
                  //     height: 70,
                  //   );
                  // }
                  if (messages[index].types == "source") {
                    return OwnMessageCart(
                      message: messages[index].message!,
                    );
                  } else {
                    return ReplyCart(
                      message: messages[index].message!,
                    );
                  }
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width - 55,
                        child: Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: TextFormField(
                              onChanged: (value) {
                                if (value.length > 0) {
                                  setState(() {
                                    sendbutton = true;
                                  });
                                } else {
                                  setState(() {
                                    sendbutton = false;
                                  });
                                }
                              },
                              controller: _controller,
                              focusNode: focusNode,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              minLines: 1,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: "type something..."),
                            ))),
                    CircleAvatar(
                      child: IconButton(
                          onPressed: () {
                            if (sendbutton) {
                              _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeOut);
                              sendmessage(_controller.text, widget.sourceId!,
                                  widget.targetId!);

                              _controller.clear();
                            }
                          },
                          icon: Icon(Icons.send)),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
