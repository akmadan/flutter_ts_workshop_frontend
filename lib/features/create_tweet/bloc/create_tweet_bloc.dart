import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_workshop_tweet_app/features/create_tweet/repos/create_tweet_repo.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'create_tweet_event.dart';
part 'create_tweet_state.dart';

class CreateTweetBloc extends Bloc<CreateTweetEvent, CreateTweetState> {
  CreateTweetBloc() : super(CreateTweetInitial()) {
    on<CreateTweetPostEvent>(createTweetPostEvent);
  }

  FutureOr<void> createTweetPostEvent(
      CreateTweetPostEvent event, Emitter<CreateTweetState> emit) async {
    emit(CreateTweetLoadingState());
    String currUserId = FirebaseAuth.instance.currentUser?.uid ?? "";
    final uuid = Uuid().v1();
    bool success = await CreateTweetRepo.postTweetRepo(
        uuid, currUserId, event.content, DateTime.now());
    if (success) {
      emit(CreateTweetSuccessState());
    } else {
      emit(CreateTweetErrorState());
    }
  }
}
