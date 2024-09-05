import 'package:equatable/equatable.dart';
import 'package:example/utils/app_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_call_chat_sdk/services/signalR_service_chat.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final _hubConnection = SignalRServiceChat.instance.hubChat;

  ChatsBloc() : super(ChatsInitial()) {
    on<OpenConnection>(_openConnection);
  }

  Future<void> _openConnection(
    OpenConnection event,
    Emitter<ChatsState> emit,
  ) async {
    try {
      _hubConnection?.on('UpdateListConversation', (List<dynamic>? args) {
        log("[home_page] UpdateUserOnline: ${args}");
        if (args != null) {
          log("[home_page] UpdateUserOnline: ${args[0]}");
        }
      });
      emit(ConnectionOpened());
    } catch (e) {
      emit(ConnectionFailed(e.toString()));
    }
  }
}
