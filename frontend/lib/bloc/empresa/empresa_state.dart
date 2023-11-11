// ignore_for_file: must_be_immutable

part of 'empresa_bloc.dart';

@immutable
abstract class EmpresaState {}

class EmpresaInitialState extends EmpresaState {}

class EmpresaLoadingState extends EmpresaState {}

class EmpresaLoadedState extends EmpresaState {
  List<EmpresaModelo> empresaList;
  EmpresaLoadedState(this.empresaList);
}

class EmpresaError extends EmpresaState {
  Error e;
  EmpresaError(this.e);
}
