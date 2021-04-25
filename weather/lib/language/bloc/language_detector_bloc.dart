import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'language_detector_event.dart';
part 'language_detector_state.dart';

// class LanguageDetectorBloc
//     extends Bloc<LanguageDetectorEvent, LanguageDetectorState> {
//   LanguageDetectorBloc(this._userRepository) : super(_Initial());

//   final UserRepository _userRepository;

//   @override
//   Stream<Transition<LanguageDetectorEvent, LanguageDetectorState>>
//       transformEvents(Stream<LanguageDetectorEvent> events, transitionFn) {
//     final nonDebounceStream = events.where((event) => event is! _SetLocale);

//     final debounceStream = events
//         .where((event) => event is _SetLocale)
//         .distinct((a, b) => a.locale.languageCode == b.locale.languageCode);

//     return super.transformEvents(
//       MergeStream([nonDebounceStream, debounceStream]),
//       transitionFn,
//     );
//   }

//   @override
//   Stream<LanguageDetectorState> mapEventToState(
//     LanguageDetectorEvent event,
//   ) async* {
//     yield* event.map(setLocale: _mapSetLocaleToState);
//   }

//   Stream<LanguageDetectorState> _mapSetLocaleToState(
//     _SetLocale event,
//   ) async* {
//     _userRepository.setUserLang(event.locale.languageCode);
//   }
// }
