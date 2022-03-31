import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:verker_prof/blocs/swipe_bloc/swipe_bloc.dart';
import 'package:verker_prof/services/graphql/GrapgQLService.dart';
import 'package:verker_prof/services/graphql/queries/outreach.dart';

part 'outreach_event.dart';
part 'outreach_state.dart';

class OutreachBloc extends Bloc<OutreachEvent, OutreachState> {
  SwipeBloc swipeBloc;

  OutreachBloc(this.swipeBloc) : super(const OutreachState()) {
    on<SendOutreach>(_sendOutreach);
  }

  Future<void> _sendOutreach(SendOutreach event, Emitter emit) async {
    try {
      await GraphQLService().performMutation(createOutreach, variables: {
        "initialMessage": event.message,
        "projectId": event.projectId,
      });
      swipeBloc.add(RemoveProject(event.projectId));
    } catch (e) {
      return emit(state.copyWith(status: OutreachStatus.failed));
    }

    emit(state.copyWith(status: OutreachStatus.succes));
  }
}
