part of 'tweet_bloc.dart';

@immutable
sealed class TweetState {}

final class TweetInitial extends TweetState {}

class TweetsLoadState extends TweetState {}

class TweetsSuccessState extends TweetState {
  final List<TweetModel> tweets;
  TweetsSuccessState({
    required this.tweets,
  });
}

class TweetsErrorState extends TweetState {}
