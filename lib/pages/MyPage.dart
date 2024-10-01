// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class Mypage extends StatefulWidget {
//   const Mypage({super.key});
//
//   @override
//   State<Mypage> createState() => _MypageState();
// }
//
// class _MypageState extends State<Mypage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [SingleCoice(),
//           MultipleChoice(),
//         Text("Slider"),
//         ],
//       ),
//     );
//   }
// }
//
// enum Calendar { day, week, moths, year }
//
// class SingleCoice extends StatefulWidget {
//   const SingleCoice({super.key});
//
//   @override
//   State<SingleCoice> createState() => _SingleCoiceState();
// }
//
// class _SingleCoiceState extends State<SingleCoice> {
//   Calendar calendarView = Calendar.day;
//
//   @override
//   Widget build(BuildContext context) {
//     return SegmentedButton(
//       multiSelectionEnabled: false,
//       segments: <ButtonSegment<Calendar>>[
//         ButtonSegment<Calendar>(
//             value: Calendar.day,
//             label: Text("Day"),
//             icon: Icon(Icons.calendar_view_day)),
//         ButtonSegment<Calendar>(
//             value: Calendar.week,
//             label: Text("week"),
//             icon: Icon(Icons.calendar_view_day)),
//         ButtonSegment<Calendar>(
//             value: Calendar.moths,
//             label: Text("month",overflow:TextOverflow.ellipsis,),
//             icon: Icon(Icons.calendar_month_rounded)),
//         ButtonSegment<Calendar>(
//             value: Calendar.year,
//             label: Text("year"),
//             icon: Icon(Icons.calendar_view_day))
//       ],
//       selected: <Calendar>{calendarView},
//       onSelectionChanged: (Set<Calendar> newSlection) {
//         setState(() {
//           calendarView = newSlection.first;
//         });
//       },
//     );
//   }
// }
//
//
// enum Sizes { extraSmall, small, medium, large, extraLarge }
//
// class MultipleChoice extends StatefulWidget {
//   const MultipleChoice({super.key});
//
//   @override
//   State<MultipleChoice> createState() => _MultipleChoiceState();
// }
//
// class _MultipleChoiceState extends State<MultipleChoice> {
//   Set<Sizes> selection = <Sizes>{Sizes.large, Sizes.extraLarge};
//
//   @override
//   Widget build(BuildContext context) {
//     return SegmentedButton<Sizes>(
//       segments: const <ButtonSegment<Sizes>>[
//         ButtonSegment<Sizes>(value: Sizes.extraSmall, label: Text('XS')),
//         ButtonSegment<Sizes>(value: Sizes.small, label: Text('S')),
//         ButtonSegment<Sizes>(value: Sizes.medium, label: Text('M')),
//         ButtonSegment<Sizes>(
//           value: Sizes.large,
//           label: Text('L'),
//         ),
//         ButtonSegment<Sizes>(value: Sizes.extraLarge, label: Text('XL')),
//       ],
//       selected: selection,
//       onSelectionChanged: (Set<Sizes> newSelection) {
//         setState(() {
//           selection = newSelection;
//         });
//       },
//       multiSelectionEnabled: true,
//     );
//   }
// }
