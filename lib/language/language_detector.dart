import 'package:flutter/cupertino.dart';

// class LanguageDetector extends StatefulWidget {
//   const LanguageDetector({
//     Key? key,
//     required this.child,
//   }) : super(key: key);
//   final Widget child;

//   @override
//   _LanguageDetectorState createState() => _LanguageDetectorState();
// }

// class _LanguageDetectorState extends State<LanguageDetector> {
//   LanguageDetectorBloc bloc;
//   @override
//   void initState() {
//     bloc = LanguageDetectorBloc(
//       context.backend.userRepository,
//     );

//     super.initState();
//   }

//   @override
//   void dispose() {
//     bloc?.close();

//     super.dispose();
//   }

//   @override
//   void didChangeDependencies() {
//     final locale = Localizations.localeOf(context);

//     bloc?.add(LanguageDetectorEvent.setLocale(locale));

//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: widget.child,
//     );
//   }
// }
