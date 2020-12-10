import 'package:flutter/material.dart';
import 'package:mine_sweeper/components/field_widget.dart';
import 'package:mine_sweeper/models/board.dart';
import 'package:mine_sweeper/models/field.dart';

class BoardWidget extends StatelessWidget {
  BoardWidget({
    @required this.board,
    @required this.onOpen,
    @required this.onToggleFlag,
  });

  final Board board;
  final Function(Field) onOpen;
  final Function(Field) onToggleFlag;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: board.cols,
        children: board.fields.map((field) {
          return FieldWidget(
            field: field,
            onOpen: onOpen,
            onToggleFlag: onToggleFlag,
          );
        }).toList(),
      ),
    );
  }
}
