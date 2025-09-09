
part of 'theme_bloc.dart';

@immutable
class ThemeState extends Equatable {
  final ThemeData theme;
  final bool isAutoTheme;

  const ThemeState({
    required this.theme,
    this.isAutoTheme = true,
  });

  @override
  List<Object> get props => [theme, isAutoTheme];

  ThemeState copyWith({
    ThemeData? theme,
    bool? isAutoTheme,
  }) {
    return ThemeState(
      theme: theme ?? this.theme,
      isAutoTheme: isAutoTheme ?? this.isAutoTheme,
    );
  }
}