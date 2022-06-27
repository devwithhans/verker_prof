import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql/client.dart';
import 'package:verker_prof/features/projects/data/queries/outreach.dart';
import 'package:verker_prof/features/swipe/bloc/swipe_bloc/swipe_bloc.dart';
import 'package:verker_prof/utils/services/graphql_service.dart';

part 'outreach_event.dart';
part 'outreach_state.dart';

class OutreachBloc extends Bloc<OutreachEvent, OutreachState> {
  SwipeBloc swipeBloc;

  OutreachBloc(this.swipeBloc) : super(const OutreachState()) {
    on<SendOutreach>(_sendOutreach);
  }

  Future<void> _sendOutreach(SendOutreach event, Emitter emit) async {
    QueryResult result =
        await GraphQLService().performMutation(createOutreach, variables: {
      "initialMessage": event.message,
      "projectId": event.projectId,
    });

    if (result.hasException) {
      return emit(state.copyWith(status: OutreachStatus.failed));
    }

    emit(state.copyWith(status: OutreachStatus.succes));
    swipeBloc.add(RemoveProject(event.projectId));
  }
}
