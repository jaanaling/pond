part of 'pond_bloc.dart';

sealed class PondEvent extends Equatable {
  const PondEvent();

  @override
  List<Object> get props => [];
}

class LoadPond extends PondEvent {}

class UpdatePond extends PondEvent {
  final double addSum;
  final Pond pond;

  const UpdatePond(this.pond, this.addSum);

  @override
  List<Object> get props => [pond, addSum];
}

class SavePond extends PondEvent {
  final Pond pond;

  const SavePond(this.pond);

  @override
  List<Object> get props => [pond];
}

class RemovePond extends PondEvent {
   final Pond pond;

  const RemovePond(this.pond);

  @override
  List<Object> get props => [pond];
}
