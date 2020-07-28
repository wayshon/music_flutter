import 'package:flutter/material.dart';
import 'package:music_flutter/model/audio.dart';
import 'package:provider/provider.dart';
import 'store/common.dart';
import './detail.dart';

class FavorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('我的收藏'),
      ),
      body: buildContent(context),
    );
  }

  buildContent(context) {
    return new Container(
        child: buildList(context),
        decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage('assets/images/paperbg.jpeg'),
              fit: BoxFit.fill),
        ));
  }

  Widget buildList(context) {
    final Model = Provider.of<CommonModel>(context);
    final showList = Model.favorites.toList();
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: showList.length,
        itemBuilder: (context, i) {
          final model = showList[i];
          final List<Widget> renderList = [
            new Dismissible(
              key: Key('${model.id}_$i'),
              direction: DismissDirection.endToStart,
              child: new Cell(model),
              background: new Container(
                  color: Colors.red,
                  child: new ListTile(
                    trailing: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  )),
              onDismissed: (direction) {
                Model.remove(model);
              },
            )
          ];
          if (i > 0) {
            renderList.insert(0, new Divider());
          }
          return new Column(children: renderList);
        });
  }
}

class Cell extends StatelessWidget {
  final AudioModel model;

  Cell(this.model);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(
        model.name,
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
          return new Detail(model);
        }));
      },
    );
  }
}
