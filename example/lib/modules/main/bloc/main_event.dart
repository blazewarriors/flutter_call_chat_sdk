part of 'main_bloc.dart';

sealed class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class InitializeMain extends MainEvent {}

class FetchNewTokenEvent extends MainEvent {}
