import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cook_app/providers/tags.dart' as tags_provider;
import 'package:flutter_tags/flutter_tags.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/tags';

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  tags_provider.Tags? _tagsProvider;
  bool _isLoading = true;

  @override
  void initState() {
    _tagsProvider = Provider.of<tags_provider.Tags>(context, listen: false);
    Future.delayed(Duration.zero).then((_) {
      _tagsProvider!.fetchTags().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _tags = GlobalKey<TagsState>();

    // return Scaffold(
    //   body: Center(
    //     child: Text('Dilters'),
    //   ),
    // );

    return _isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
              // child: Text('DUPA'),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Filters'),
            ),
            body: Container(
                padding: const EdgeInsets.all(20),
                child: Tags(
                  key: _tags,
                  itemCount: _tagsProvider!.allTags.length,
                  columns: 6,
                  itemBuilder: (index) {
                    final currentTag = _tagsProvider!.allTags[index];
                    return ItemTags(
                        key: Key(currentTag['id']!.toString()),
                        index: index,
                        title: currentTag['name']!,
                        activeColor: Theme.of(context).primaryColor,
                        combine: ItemTagsCombine.withTextAfter);
                  },
                )),
            // body: Center(
            //   child: Text('JEDNOROZEC'),
            // ),
          );
  }
}
