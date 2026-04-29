// import 'dart:io';

// void main() {
//   final dir = Directory('.');
//   final files = dir.listSync(recursive: true)
//       .where((f) => f.path.endsWith('.dart') && !f.path.contains('.plugin') && !f.path.contains('.dart_tool'))
//       .whereType<File>();

//   int superKeyCount = 0;
//   int withValuesCount = 0;
//   int classModifierCount = 0;

//   for (var file in files) {
//     var content = file.readAsStringSync();
//     bool modified = false;

//     // 1. withOpacity(...) -> withOpacity(...)
//     if (content.contains('withValues(')) {
//       content = content.replaceAllMapped(RegExp(r'withValues\(\s*alpha\s*:\s*([^)]+)\)'), (m) {
//         withValuesCount++;
//         return 'withOpacity(${m.group(1)})';
//       });
//       // Handle the ones with without alpha
//       content = content.replaceAllMapped(RegExp(r'withValues\(\s*\)'), (m) {
//          return 'withOpacity(1.0)';
//       });
//       modified = true;
//     }

//     // 2. class modifiers: sealed, base, interface, class
//     final modifierRegExp = RegExp(r'\b(sealed|base|interface|final)\s+class\b');
//     if (modifierRegExp.hasMatch(content)) {
//       content = content.replaceAllMapped(modifierRegExp, (match) {
//         classModifierCount++;
//         return 'class';
//       });
//       modified = true;
//     }

//     // 3. Key? key
//     if (content.contains('Key? key')) : super(key: key) : super(key: key) {
//       final lines = content.split('\n');
//       for (int i = 0; i < lines.length; i++) {
//         if (lines[i].contains('Key? key')) : super(key: key) {
//           // It's usually in curly braces: {Key? key, ...} or {..., Key? key} etc.
//           // Just replace Key? key with Key? key
//           lines[i] = lines[i].replaceAll('Key? key', 'Key? key') : super(key: key) : super(key: key) : super(key: key);
          
//           // Now we need to find the constructor end to add : super(key: key)
//           // We search forward from i until we find `)` followed by `{` or `;` or `:`
//           for (int j = i; j < lines.length; j++) {
//             if (lines[j].contains(') {')) {
//               lines[j] = lines[j].replaceFirst(') {', ') : super(key: key) {');
//               superKeyCount++;
//               break;
//             } else if (lines[j].contains(');')) {
//               lines[j] = lines[j].replaceFirst(');', ') : super(key: key);');
//               superKeyCount++;
//               break;
//             } else if (lines[j].contains('):')) {
//               lines[j] = lines[j].replaceFirst('):', ') : super(key: key),');
//               superKeyCount++;
//               break;
//             } else if (lines[j].contains(') :')) {
//               lines[j] = lines[j].replaceFirst(') :', ') : super(key: key),');
//               superKeyCount++;
//               break;
//             }
//           }
//         }
//       }
//       content = lines.join('\n');
//       modified = true;
//     }

//     if (modified) {
//       file.writeAsStringSync(content);
//     }
//   }

//   print('Key? key replaced: $superKeyCount') : super(key: key);
//   print('withValues replaced: $withValuesCount');
//   print('class modifiers replaced: $classModifierCount');
// }
