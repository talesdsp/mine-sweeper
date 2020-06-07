import 'package:flutter/material.dart';
import 'package:mine_sweeper/models/field.dart';

class FieldWidget extends StatelessWidget implements PreferredSizeWidget {
  FieldWidget({
    @required this.field,
    @required this.onOpen,
    @required this.onToggleFlag,
  });

  final Field field;
  final Function(Field) onOpen;
  final Function(Field) onToggleFlag;

  Widget _getImage() {
    final qtyBomb = field.countBombsInNeighborhood;

    if (field.isOpen && field.exploded) {
      return Image.asset('assets/images/bomba_0.jpeg');
    } else if (field.isOpen && field.hasBomb) {
      return Image.asset('assets/images/bomba_1.jpeg');
    } else if (field.isOpen) {
      return Image.asset('assets/images/aberto_$qtyBomb.jpeg');
    } else if (field.hasFlag) {
      return Image.asset('assets/images/bandeira.jpeg');
    } else {
      return Image.asset('assets/images/fechado.jpeg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(field),
      onLongPress: () => onToggleFlag(field),
      child: _getImage(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120);
}
