// import 'package:app/screens/history/history_model.dart';
// import 'package:flutter/material.dart';

// import '../../shareds/utils/app_colors.dart';
// import '../../shareds/utils/border_radius.dart';
// import '../../widgets/app_styles.dart';

// class HistoryListItem extends StatefulWidget {
//   final HistoryModel history;

//   // ignore: use_key_in_widget_constructors
//   const HistoryListItem(this.history);

//   @override
//   State<StatefulWidget> createState() {
//     return HistoryListItemState();
//   }
// }

// class HistoryListItemState extends State<HistoryListItem> {
//   @override
//   Widget build(BuildContext context) {
//     var transactionType = widget.history.transactionType;
//     var color = transactionType == TransactionType.credit ? successColor : validationErrorColor;

//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           width: double.infinity,
//           // height: 64,
//           decoration: BoxDecoration(
//             color: background,
//             borderRadius: BorderRadius.circular(cardBorderRadius),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 5,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           padding: const EdgeInsets.all(14),
//           child: Row(
//             children: <Widget>[
//               Image.asset(
//                 widget.history.image,
//                 width: 50,
//                 height: 50,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 18),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       widget.history.name,
//                       style: appStyles(14, titleActive, FontWeight.bold),
//                     ),
//                     Text(
//                       widget.history.time,
//                       style: appStyles(12, gray, FontWeight.normal),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: <Widget>[
//                     Text(
//                       widget.history.amount,
//                       style: appStyles(14, color, FontWeight.w400),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void onTap() {}
// }
