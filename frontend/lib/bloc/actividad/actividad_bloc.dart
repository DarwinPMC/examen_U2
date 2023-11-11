import 'package:asistenciaupeu_frontend/modelo/ActividadModelo.dart';
import 'package:asistenciaupeu_frontend/repository/ActividadRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'actividad_event.dart';
part 'actividad_state.dart';

class ActividadBloc extends Bloc<ActividadEvent, ActividadState> {
  late final ActividadRepository _actividadRepository;
  ActividadBloc(this._actividadRepository) : super(ActividadInitialState()) {
    on<ActividadEvent>((event, emit) async {
      print("Bloc x");
      if (event is ListarActividadEvent) {
        emit(ActividadLoadingState());
        try {
          print("pasox!!");
          List<ActividadModelo> personaList =
              await _actividadRepository.getActividad();
          emit(ActividadLoadedState(personaList));
        } catch (e) {
          emit(ActividadError(e as Error));
        }
      } else if (event is DeleteActividadEvent) {
        try {
          await _actividadRepository.deleteActividad(event.actividad.id);
          emit(ActividadLoadingState());
          List<ActividadModelo> personaList =
              await _actividadRepository.getActividad();
          emit(ActividadLoadedState(personaList));
        } catch (e) {
          emit(ActividadError(e as Error));
        }
      } else if (event is CreateActividadEvent) {
        try {
          await _actividadRepository.createActividad(event.actividad);
          emit(ActividadLoadingState());
          List<ActividadModelo> personaList =
              await _actividadRepository.getActividad();
          emit(ActividadLoadedState(personaList));
        } catch (e) {
          emit(ActividadError(e as Error));
        }
      } else if (event is UpdateActividadEvent) {
        try {
          await _actividadRepository.updateActividad(
              event.actividad.id, event.actividad);
          emit(ActividadLoadingState());
          List<ActividadModelo> personaList =
              await _actividadRepository.getActividad();
          emit(ActividadLoadedState(personaList));
        } catch (e) {
          emit(ActividadError(e as Error));
        }
      }
    });
  }
}
