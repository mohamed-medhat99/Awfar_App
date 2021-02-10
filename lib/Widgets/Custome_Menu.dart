
import 'package:flutter/material.dart';


class mypopupitem<T> extends PopupMenuItem<T>
{
  final Widget child ;
  final Function onclick;
  mypopupitem({@required this.child ,@required this.onclick}):
        super(child : child);
  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return mypopupitemstate();
  }
}
class mypopupitemstate <T, PopMenuItem> extends PopupMenuItemState<T , mypopupitem<T>>
{

  @override
  void handleTap() {
    widget.onclick();
  }
}