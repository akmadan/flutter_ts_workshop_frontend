import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_tweet_event.dart';
part 'create_tweet_state.dart';

class CreateTweetBloc extends Bloc<CreateTweetEvent, CreateTweetState> {
  CreateTweetBloc() : super(CreateTweetInitial()) {
    on<CreateTweetEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
