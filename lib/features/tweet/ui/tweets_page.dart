import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_workshop_tweet_app/design/app_widgets.dart';
import 'package:flutter_workshop_tweet_app/features/create_tweet/ui/create_tweet_page.dart';
import 'package:flutter_workshop_tweet_app/features/tweet/bloc/tweet_bloc.dart';
import 'package:intl/intl.dart';

class TweetsPage extends StatefulWidget {
  const TweetsPage({super.key});

  @override
  State<TweetsPage> createState() => _TweetsPageState();
}

class _TweetsPageState extends State<TweetsPage> {
  TweetBloc tweetBloc = TweetBloc();

  @override
  void initState() {
    tweetBloc.add(TweetInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateTweetPage(
                        tweetBloc: tweetBloc,
                      )));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: BlocConsumer<TweetBloc, TweetState>(
        bloc: tweetBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case TweetsSuccessState:
              final successState = state as TweetsSuccessState;
              return Container(
                margin: const EdgeInsets.only(top: 60),
                child: Column(
                  children: [
                    // LOGO

                    Center(child: AppLogoWidget()),

                    // TWEETS
                    Expanded(
                        child: ListView.separated(
                      itemCount: successState.tweets.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 32,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(left: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                successState.tweets[index].tweet.content,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Tweeted by: " +
                                        successState
                                            .tweets[index].admin.firstName +
                                        " " +
                                        successState
                                            .tweets[index].admin.lastNAme,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    DateFormat("dd MMMM yyyy hh:mm a").format(
                                        successState
                                            .tweets[index].tweet.createdAt),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ))
                  ],
                ),
              );

            case TweetsLoadState:
              return Center(child: CircularProgressIndicator());
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
