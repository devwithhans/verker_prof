part of 'outreach_bloc.dart';

abstract class OutreachEvent extends Equatable {
  const OutreachEvent();

  @override
  List<Object> get props => [];
}

class SendOutreach extends OutreachEvent {
  final String message;
  final String projectId;

  const SendOutreach({
    required this.message,
    required this.projectId,
  });
}
