// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class ModernOtpInputField extends StatefulWidget {
//   final TextEditingController? controller;
//   final String? Function(String?)? validator;
//   final ValueChanged<String>? onChanged;
//   final ValueChanged<String>? onCompleted;
//   final String? errorText;
//   final bool enabled;
//   final int otpLength;
//   final bool autoFocus;

//   const ModernOtpInputField({
//     super.key,
//     this.controller,
//     this.validator,
//     this.onChanged,
//     this.onCompleted,
//     this.errorText,
//     this.enabled = true,
//     this.otpLength = 4,
//     this.autoFocus = true,
//   });

//   @override
//   State<ModernOtpInputField> createState() => _ModernOtpInputFieldState();
// }

// class _ModernOtpInputFieldState extends State<ModernOtpInputField> {
//   late TextEditingController _controller;
//   late List<FocusNode> _focusNodes;
//   late List<TextEditingController> _fieldControllers;
//   late List<bool> _fieldFocusStates;

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
//       widget.otpLength,
//       (index) => TextEditingController(),
//     );
//     _fieldFocusStates = List.generate(widget.otpLength, (index) => false);
//   }

//   void _initializeFocusNodes() {
//     _focusNodes = List.generate(widget.otpLength, (index) {
//       final focusNode = FocusNode();
//       focusNode.addListener(() {
//         setState(() {
//           _fieldFocusStates[index] = focusNode.hasFocus;
//         });
//       });
//       return focusNode;
//     });

//     // Auto focus first field
//     if (widget.autoFocus && _focusNodes.isNotEmpty) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (mounted) {
//           _focusNodes[0].requestFocus();
//         }
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
//     if (text.length <= widget.otpLength) {
//       _distributeTextToFields(text);
//     }
//   }

//   void _distributeTextToFields(String text) {
//     for (int i = 0; i < widget.otpLength; i++) {
//       final newValue = i < text.length ? text[i] : '';
//       if (_fieldControllers[i].text != newValue) {
//         _fieldControllers[i].text = newValue;
//       }
//     }
//   }

//   void _handleFieldChange(String value, int index) {
//     // Handle multiple character input (paste)
//     if (value.length > 1) {
//       final cleanValue = value.replaceAll(RegExp(r'\D'), '');
//       _handlePastedText(cleanValue, index);
//       return;
//     }

//     // Handle single character input
//     final cleanValue = value.replaceAll(RegExp(r'\D'), '');
//     _fieldControllers[index].text = cleanValue;

//     _updateMainController();

//     // Move to next field if value entered and not at last field
//     if (cleanValue.isNotEmpty && index < widget.otpLength - 1) {
//       _focusNodes[index + 1].requestFocus();
//     }
//   }

//   void _handlePastedText(String text, int startIndex) {
//     // Clear all fields first
//     for (int i = 0; i < widget.otpLength; i++) {
//       _fieldControllers[i].clear();
//     }

//     // Fill fields with pasted text
//     for (int i = 0; i < text.length && i < widget.otpLength; i++) {
//       _fieldControllers[i].text = text[i];
//     }

//     _updateMainController();

//     // Focus on the next empty field or last field
//     final nextIndex = text.length.clamp(0, widget.otpLength - 1);
//     if (nextIndex < widget.otpLength) {
//       _focusNodes[nextIndex].requestFocus();
//     }
//   }

//   void _handleKeyPress(RawKeyEvent event, int index) {
//     if (event is RawKeyDownEvent) {
//       if (event.logicalKey == LogicalKeyboardKey.backspace) {
//         if (_fieldControllers[index].text.isEmpty && index > 0) {
//           // Move to previous field and clear it
//           _focusNodes[index - 1].requestFocus();
//           _fieldControllers[index - 1].clear();
//           _updateMainController();
//         } else if (_fieldControllers[index].text.isNotEmpty) {
//           // Clear current field
//           _fieldControllers[index].clear();
//           _updateMainController();
//         }
//       }
//     }
//   }

//   void _updateMainController() {
//     final combinedText =
//         _fieldControllers.map((controller) => controller.text).join();

//     if (_controller.text != combinedText) {
//       _controller.text = combinedText;
//       widget.onChanged?.call(combinedText);

//       if (combinedText.length == widget.otpLength) {
//         widget.onCompleted?.call(combinedText);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List.generate(
//             widget.otpLength,
//             (index) => _buildOtpField(context, index),
//           ),
//         ),
//         if (widget.errorText != null)
//           Padding(
//             padding: const EdgeInsets.only(top: 12.0),
//             child: Text(
//               widget.errorText!,
//               style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                     color: Colors.red,
//                   ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildOtpField(BuildContext context, int index) {
//     final theme = Theme.of(context);
//     final isFocused = _fieldFocusStates[index];
//     final hasValue = _fieldControllers[index].text.isNotEmpty;

//     return Container(
//       margin: EdgeInsets.symmetric(
//         horizontal: index == 0 || index == widget.otpLength - 1 ? 0 : 8.0,
//       ),
//       child: SizedBox(
//         width: 64.0, // Slightly larger for better touch targets
//         height: 64.0,
//         child: RawKeyboardListener(
//           focusNode: FocusNode(),
//           onKey: (event) => _handleKeyPress(event, index),
//           child: TextFormField(
//             controller: _fieldControllers[index],
//             focusNode: _focusNodes[index],
//             enabled: widget.enabled,
//             keyboardType: TextInputType.number,
//             textAlign: TextAlign.center,
//             maxLength: 1,
//             style: theme.textTheme.headlineMedium?.copyWith(
//               color: hasValue ? Colors.black : Colors.grey[600],
//               fontWeight: FontWeight.w600,
//               fontSize: 24.0,
//             ),
//             inputFormatters: [
//               FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//               LengthLimitingTextInputFormatter(1),
//             ],
//             decoration: InputDecoration(
//               counterText: '',
//               contentPadding: EdgeInsets.zero,
//               filled: true,
//               fillColor: Colors.white,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12.0),
//                 borderSide: BorderSide(
//                   color: Colors.grey[300]!,
//                   width: 1.5,
//                 ),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12.0),
//                 borderSide: BorderSide(
//                   color: hasValue ? Colors.grey[400]! : Colors.grey[300]!,
//                   width: 1.5,
//                 ),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12.0),
//                 borderSide: BorderSide(
//                   color: Theme.of(context).primaryColor,
//                   width: 2.0,
//                 ),
//               ),
//               errorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12.0),
//                 borderSide: const BorderSide(
//                   color: Colors.red,
//                   width: 2.0,
//                 ),
//               ),
//               focusedErrorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12.0),
//                 borderSide: const BorderSide(
//                   color: Colors.red,
//                   width: 2.0,
//                 ),
//               ),
//             ),
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
