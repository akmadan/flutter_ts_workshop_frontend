import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_workshop_tweet_app/core/local_db/shared_prefs_manager.dart';
import 'package:flutter_workshop_tweet_app/features/onboarding/ui/onboarding_screen.dart';
import 'package:flutter_workshop_tweet_app/features/tweet/ui/tweets_page.dart';

class DecidePage extends StatefulWidget {
  static StreamController<String?> authStream = StreamController.broadcast();
  const DecidePage({super.key});

  @override
  State<DecidePage> createState() => _DecidePageState();
}

class _DecidePageState extends State<DecidePage> {
  @override
  void initState() {
    getUid();
    super.initState();
  }

  getUid() async {
    String uid = await SharedPreferencesManager.getUid();

    if (uid.isEmpty) {
      DecidePage.authStream.add("");
    } else {
      DecidePage.authStream.add(uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
        stream: DecidePage.authStream.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return TweetsPage();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return OnboardingScreen();
          }
        });
  }
}
