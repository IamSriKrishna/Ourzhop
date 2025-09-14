// import 'package:customer_app/constants/otp_constant.dart';
// import 'package:customer_app/core/themes/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class OtpInputFieldConfig {
//   final int otpLength;
//   final double fieldWidth;
//   final double fieldHeight;
//   final double spacing;
//   final TextStyle? textStyle;
//   final InputDecoration? decoration;
//   final List<TextInputFormatter>? inputFormatters;
//   final bool autoFocus;
//   final TextInputType keyboardType;

//   const OtpInputFieldConfig({
//     this.otpLength = OtpConstants.defaultOtpLength,
//     this.fieldWidth = 56.0,
//     this.fieldHeight = 56.0,
//     this.spacing = OtpConstants.defaultSpacing,
//     this.textStyle,
//     this.decoration,
//     this.inputFormatters,
//     this.autoFocus = true,
//     this.keyboardType = TextInputType.number,
//   });
// }

// class ReusableOtpInputField extends StatefulWidget {
//   final TextEditingController? controller;
//   final String? Function(String?)? validator;
//   final ValueChanged<String>? onChanged;
//   final ValueChanged<String>? onCompleted;
//   final OtpInputFieldConfig config;
//   final String? errorText;
//   final bool enabled;

//   const ReusableOtpInputField({
//     super.key,
//     this.controller,
//     this.validator,
//     this.onChanged,
//     this.onCompleted,
//     this.config = const OtpInputFieldConfig(),
//     this.errorText,
//     this.enabled = true,
//   });

//   @override
//   State<ReusableOtpInputField> createState() => _ReusableOtpInputFieldState();
// }

// class _ReusableOtpInputFieldState extends State<ReusableOtpInputField> {
//   late TextEditingController _controller;
//   late List<FocusNode> _focusNodes;
//   late List<TextEditingController> _fieldControllers;

//   @override
//   void initState() {
//     super.initState();
//     _initializeControllers();
//     _initializeFocusNodes();
//     _setupMainController();
//   }

//   void _initializeControllers() {
//     _controller = widget.controller ?? TextEditingController();
//     _fieldControllers = List.generate(
//       widget.config.otpLength,
//       (index) => TextEditingController(),
//     );
//   }

//   void _initializeFocusNodes() {
//     _focusNodes = List.generate(
//       widget.config.otpLength,
//       (index) => FocusNode(),
//     );

//     // Auto focus first field
//     if (widget.config.autoFocus && _focusNodes.isNotEmpty) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         _focusNodes[0].requestFocus();
//       });
//     }
//   }

//   void _setupMainController() {
//     if (_controller.text.isNotEmpty) {
//       _distributeTextToFields(_controller.text);
//     }
//     _controller.addListener(_onMainControllerChanged);
//   }

//   void _onMainControllerChanged() {
//     final text = _controller.text;
//     if (text.length <= widget.config.otpLength) {
//       _distributeTextToFields(text);
//     }
//   }

//   void _distributeTextToFields(String text) {
//     for (int i = 0; i < widget.config.otpLength; i++) {
//       _fieldControllers[i].text = i < text.length ? text[i] : '';
//     }
//   }

//   void _handleFieldChange(String value, int index) {
//     final cleanValue = value.replaceAll(RegExp(r'\D'), '');

//     if (cleanValue.length > 1) {
//       // Handle pasting multiple digits
//       _handlePastedText(cleanValue, index);
//     } else {
//       _fieldControllers[index].text = cleanValue;
//       _updateMainController();

//       if (cleanValue.isNotEmpty && index < widget.config.otpLength - 1) {
//         _focusNodes[index + 1].requestFocus();
//       }
//     }
//   }

//   void _handlePastedText(String text, int startIndex) {
//     for (int i = 0;
//         i < text.length && (startIndex + i) < widget.config.otpLength;
//         i++) {
//       _fieldControllers[startIndex + i].text = text[i];
//     }
//     _updateMainController();

//     // Focus on the next empty field or last field
//     final nextIndex =
//         (startIndex + text.length).clamp(0, widget.config.otpLength - 1);
//     _focusNodes[nextIndex].requestFocus();
//   }

//   void _handleFieldKeyEvent(RawKeyEvent event, int index) {
//     if (event is RawKeyDownEvent &&
//         event.logicalKey == LogicalKeyboardKey.backspace) {
//       if (_fieldControllers[index].text.isEmpty && index > 0) {
//         _focusNodes[index - 1].requestFocus();
//         _fieldControllers[index - 1].clear();
//         _updateMainController();
//       }
//     }
//   }

//   void _updateMainController() {
//     final combinedText =
//         _fieldControllers.map((controller) => controller.text).join();

//     if (_controller.text != combinedText) {
//       _controller.text = combinedText;
//       widget.onChanged?.call(combinedText);

//       if (combinedText.length == widget.config.otpLength) {
//         widget.onCompleted?.call(combinedText);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final appColors = context.appColors;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List.generate(
//             widget.config.otpLength,
//             (index) => _buildOtpField(context, index, theme, appColors),
//           ),
//         ),
//         if (widget.errorText != null)
//           Padding(
//             padding: const EdgeInsets.only(top: 8.0),
//             child: Text(
//               widget.errorText!,
//               style: theme.textTheme.bodySmall?.copyWith(color: Colors.red),
//               textAlign: TextAlign.center,
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildOtpField(
//     BuildContext context,
//     int index,
//     ThemeData theme,
//     dynamic appColors,
//   ) {
//     return Container(
//       margin: EdgeInsets.only(
//         right: index < widget.config.otpLength - 1 ? widget.config.spacing : 0,
//       ),
//       child: SizedBox(
//         width: widget.config.fieldWidth,
//         height: widget.config.fieldHeight,
//         child: RawKeyboardListener(
//           focusNode: FocusNode(),
//           onKey: (event) => _handleFieldKeyEvent(event, index),
//           child: TextFormField(
//             controller: _fieldControllers[index],
//             focusNode: _focusNodes[index],
//             enabled: widget.enabled,
//             keyboardType: widget.config.keyboardType,
//             textAlign: TextAlign.center,
//             maxLength: 1,
//             inputFormatters: widget.config.inputFormatters ??
//                 [
//                   FilteringTextInputFormatter.digitsOnly,
//                   LengthLimitingTextInputFormatter(1),
//                 ],
//             style: widget.config.textStyle ??
//                 theme.textTheme.headlineSmall?.copyWith(
//                   color: appColors.onSurface,
//                   fontWeight: FontWeight.bold,
//                 ),
//             decoration: widget.config.decoration ??
//                 InputDecoration(
//                   counterText: '',
//                   contentPadding: EdgeInsets.zero,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                     borderSide: BorderSide(color: appColors.outline),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                     borderSide: BorderSide(color: appColors.outline),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                     borderSide:
//                         BorderSide(color: appColors.primary, width: 2.0),
//                   ),
//                   errorBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                     borderSide: const BorderSide(color: Colors.red, width: 2.0),
//                   ),
//                   filled: true,
//                   fillColor: widget.enabled
//                       ? appColors.surface
//                       : appColors.surface.withOpacity(0.6),
//                 ),
//             onChanged: (value) => _handleFieldChange(value, index),
//             validator: index == 0 ? widget.validator : null,
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.removeListener(_onMainControllerChanged);
//     if (widget.controller == null) {
//       _controller.dispose();
//     }

//     for (final controller in _fieldControllers) {
//       controller.dispose();
//     }

//     for (final focusNode in _focusNodes) {
//       focusNode.dispose();
//     }

//     super.dispose();
//   }
// }
