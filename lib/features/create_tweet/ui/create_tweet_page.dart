import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_workshop_tweet_app/features/create_tweet/bloc/create_tweet_bloc.dart';
import 'package:flutter_workshop_tweet_app/features/tweet/bloc/tweet_bloc.dart';

class CreateTweetPage extends StatefulWidget {
  final TweetBloc tweetBloc;
  const CreateTweetPage({super.key, required this.tweetBloc});

  @override
  State<CreateTweetPage> createState() => _CreateTweetPageState();
}

class _CreateTweetPageState extends State<CreateTweetPage> {
  TextEditingController contentController = TextEditingController();
  bool loader = false;

  CreateTweetBloc createTweetBloc = CreateTweetBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CreateTweetBloc, CreateTweetState>(
        bloc: createTweetBloc,
        listenWhen: (previous, current) => current is CreateTweetActionState,
        buildWhen: (previous, current) => current is! CreateTweetActionState,
        listener: (context, state) {
          if (state is CreateTweetLoadingState) {
            setState(() {
              loader = true;
            });
          } else if (state is CreateTweetSuccessState) {
            widget.tweetBloc.add(TweetInitialFetchEvent());
            setState(() {
              loader = false;
            });
            Navigator.pop(context);
          } else if (state is CreateTweetErrorState) {
            setState(() {
              loader = false;
            });
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Something went wrong")));
          }
        },
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.only(top: 80, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create Tweet",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: contentController,
                  maxLines: 30,
                  minLines: 1,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w400),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Write whats in your mind🤯",
                    hintStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                    height: 48,
                    width: double.maxFinite,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        onPressed: () {
                          createTweetBloc.add(
                              CreateTweetPostEvent(contentController.text));
                        },
                        child: const Text(
                          "POST",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )))
              ],
            ),
          );
        },
      ),
    );
  }
}
