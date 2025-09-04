// Package imports:
import 'package:logger/logger.dart';

class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  final Logger _logger;

  AppLogger._internal()
      : _logger = Logger(
          // Setting the logging level to be verbose during development
          // can be dynamically adjusted based on the app's environment or build mode.
          level: Level.debug, // Consider Level.verbose for detailed logs

          printer: PrettyPrinter(
            methodCount:
                5, // Displaying method calls can help trace the log origin
            errorMethodCount:
                8, // Extensive method calls for error logs for better debugging
            lineLength: 120, // Adjust line length for readability
            colors: true, // Enables colored log messages for easier distinction
            printEmojis:
                true, // Emoji inclusion for visual emphasis on log severity
            dateTimeFormat: DateTimeFormat
                .onlyTimeAndSinceStart, // Timestamps for correlating logs with events
          ),
        );

  factory AppLogger() => _instance;

  void trace(dynamic message) => _logger.t(message);
  void debug(dynamic message) => _logger.d(message);
  void info(dynamic message) => _logger.i(message);
  void warning(dynamic message) => _logger.w(message);
  void error(dynamic message, [Object? error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
