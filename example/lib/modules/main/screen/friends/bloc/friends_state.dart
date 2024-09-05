part of 'friends_bloc.dart';

sealed class FriendsState extends Equatable {
  const FriendsState();
  
  @override
  List<Object> get props => [];
}

final class FriendsInitial extends FriendsState {}
