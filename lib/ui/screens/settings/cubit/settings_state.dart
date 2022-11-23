part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsSuccess extends SettingsState {
  final bool isEnableScheduleNotif;

  const SettingsSuccess({
    this.isEnableScheduleNotif = true,
  });

  @override
  List<Object> get props => [isEnableScheduleNotif];
}
