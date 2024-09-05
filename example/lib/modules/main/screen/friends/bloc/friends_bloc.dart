import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  FriendsBloc() : super(FriendsInitial()) {
    on<FriendsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
