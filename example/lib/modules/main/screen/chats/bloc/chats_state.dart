part of 'chats_bloc.dart';

sealed class ChatsState extends Equatable {
  const ChatsState();

  @override
  List<Object> get props => [];
}

final class ChatsInitial extends ChatsState {}

class ConnectionOpened extends ChatsState {
  @override
  List<Object> get props => [];
}

class ConnectionFailed extends ChatsState {
  final String error;

  const ConnectionFailed(this.error);

  @override
  List<Object> get props => [error];
}
