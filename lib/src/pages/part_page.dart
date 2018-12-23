import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/group_list_bloc.dart';
import 'package:cv/src/blocs/part_bloc.dart';
import 'package:cv/src/models/part_model.dart';
import 'package:cv/src/widgets/group_list_widget.dart';
import 'package:cv/src/widgets/loading_shadow_content_widget.dart';
import 'package:flutter/material.dart';

class PartPage extends StatelessWidget {
  PartPage(this.profilePartId);

  final String profilePartId;

  @override
  Widget build(BuildContext context) {
    PartBloc _partBloc = BlocProvider.of<PartBloc>(context);
    _partBloc.fetchPart(profilePartId);

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<PartModel>(
          stream: _partBloc.partStream,
          builder: (BuildContext context, AsyncSnapshot<PartModel> snapshot) {
            if (snapshot.hasError) {
              return Text("Error : ${snapshot.error.toString()}");
            } else if (snapshot.hasData) {
              PartModel partModel = snapshot.data;
              return Text(partModel.name);
            }
            return LoadingShadowContent(
              numberOfTitleLines: 1,
              numberOfContentLines: 0,
            );
          },
        ),
      ),
      body: _PartPagePartBody(),
    );
  }
}

class _PartPagePartBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PartBloc _partBloc = BlocProvider.of<PartBloc>(context);

    return Stack(
      children: <Widget>[
        StreamBuilder<bool>(
          stream: _partBloc.isFetchingPartStream,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data == true) {
              return LinearProgressIndicator();
            }
            return Container();
          },
        ),
        SingleChildScrollView(
          child: SafeArea(
            left: false,
            right: false,
            child: StreamBuilder<PartModel>(
              stream: _partBloc.partStream,
              builder:
                  (BuildContext context, AsyncSnapshot<PartModel> snapshot) {
                if (snapshot.hasError) {
                  return Card(
                      child: Text("Error : ${snapshot.error.toString()}"));
                } else if (snapshot.hasData) {
                  return BlocProvider<GroupListBloc>(
                    bloc: GroupListBloc(),
                    child: GroupListWidget(
                      fromPartModel: snapshot.data,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                    ),
                  );
                }
                return LoadingShadowContent(
                  numberOfContentLines: 2,
                  padding: EdgeInsets.all(10.0),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}