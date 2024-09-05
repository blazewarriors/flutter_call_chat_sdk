part of 'chats_bloc.dart';

sealed class ChatsEvent extends Equatable {
  const ChatsEvent();

  @override
  List<Object> get props => [];
}

class InitialChatsEvent extends ChatsEvent {}

class OpenConnection extends ChatsEvent {}
