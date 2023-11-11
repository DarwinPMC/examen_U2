import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'finca_event.dart';
part 'finca_state.dart';

class FincaBloc extends Bloc<FincaEvent, FincaState> {
  FincaBloc() : super(FincaInitial()) {
    on<FincaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
