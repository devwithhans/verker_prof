part of 'outreach_bloc.dart';

enum OutreachStatus { initial, succes, pop, failed }

class OutreachState extends Equatable {
  final OutreachStatus status;
  final String message;

  const OutreachState(
      {this.message = '', this.status = OutreachStatus.initial});

  OutreachState copyWith({
    OutreachStatus? status,
    String? message,
  }) {
    return OutreachState(
        message: message ?? this.message, status: status ?? this.status);
  }

  @override
  List<Object> get props => [status, message];
}
