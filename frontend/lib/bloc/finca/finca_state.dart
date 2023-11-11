part of 'finca_bloc.dart';

sealed class FincaState extends Equatable {
  const FincaState();
  
  @override
  List<Object> get props => [];
}

final class FincaInitial extends FincaState {}
