// ignore_for_file: must_be_immutable

part of 'actividad_bloc.dart';

@immutable
abstract class ActividadState {}

class ActividadInitialState extends ActividadState {}
class ActividadLoadingState extends ActividadState{}
class ActividadLoadedState extends ActividadState{
  List<ActividadModelo> actividadList;
  ActividadLoadedState(this.actividadList);
}
class ActividadError extends ActividadState{
  Error e;
  ActividadError(this.e);
}
