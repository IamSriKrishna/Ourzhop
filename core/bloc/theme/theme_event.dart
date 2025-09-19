part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

class InitializeTheme extends ThemeEvent {
  const InitializeTheme();
}

class ThemeToggled extends ThemeEvent {
  const ThemeToggled();
}

class SystemThemeChanged extends ThemeEvent {
  final Brightness brightness;

  const SystemThemeChanged(this.brightness);

  @override
  List<Object> get props => [brightness];
}

class AutoThemeToggled extends ThemeEvent {
  const AutoThemeToggled();
}
