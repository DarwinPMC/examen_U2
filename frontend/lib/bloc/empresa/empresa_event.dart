// ignore_for_file: must_be_immutable

part of 'empresa_bloc.dart';

@immutable
abstract class EmpresaEvent {}

class ListarEmpresaEvent extends EmpresaEvent {
  ListarEmpresaEvent() {
    print("Evento si");
  }
//ListarEmpresaEvent({required EmpresaModelo Empresa}):super(Empresa:Empresa);
}

class DeleteEmpresaEvent extends EmpresaEvent {
  EmpresaModelo empresa;
  DeleteEmpresaEvent(this.empresa);
//DeleteEmpresaEvent({required EmpresaModelo Empresa}):super(Empresa:Empresa);
}

class UpdateEmpresaEvent extends EmpresaEvent {
  EmpresaModelo empresa;
  UpdateEmpresaEvent(this.empresa);
//UpdateEmpresaEvent({required EmpresaModelo Empresa}):super(Empresa:Empresa);
}

class CreateEmpresaEvent extends EmpresaEvent {
  EmpresaModelo empresa;
  CreateEmpresaEvent(this.empresa);
//CreateEmpresaEvent({required EmpresaModelo Empresa}):super(Empresa:Empresa);
}