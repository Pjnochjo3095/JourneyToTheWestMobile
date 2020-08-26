import 'package:flutter/material.dart';
import 'package:journey_to_west/view_models/ToolViewModel.dart';
import 'package:journey_to_west/views/tool/detail/tool_detail_body.dart';
import 'package:scoped_model/scoped_model.dart';

class ToolDetailScreen extends StatelessWidget {
  ToolViewModel model;
  String id;
  ToolDetailScreen({this.model,this.id});

  @override
  Widget build(BuildContext context) {
    model.fetchById(id);
    return ScopedModel<ToolViewModel>(
      model: model,
      child: ToolDetailBody(),
    );
  }
}
