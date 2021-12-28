import 'package:cook_app/components/error_box.dart';
import 'package:cook_app/screens/recepies/categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:cook_app/providers/tags.dart' as tags_provider;
import 'package:cook_app/providers/recipe.dart';
import 'package:flutter_tags/flutter_tags.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/tags';

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  // tags_provider.Tags? _tagsProvider;
  Recipe? _tagsProvider;
  bool _isLoading = true;
  var _isInit = true;
  var _errorOccurred = false;
  Function? addOrRemove;

  @override
  void initState() {
    _tagsProvider = Provider.of<Recipe>(context, listen: false);
    Future.delayed(Duration.zero).then((_) {
      _tagsProvider!.fetchTags().then((value) {
        setState(() {
          _isLoading = false;
        });
      }).onError((error, stackTrace) {
        setState(() {
          _isLoading = false;
          _errorOccurred = true;
        });
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      addOrRemove = ModalRoute.of(context)!.settings.arguments as Function;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _tags = GlobalKey<TagsState>();

    return _isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ),
          )
        : _errorOccurred
            ? Scaffold(body: ErrorBox())
            : Scaffold(
                appBar: AppBar(
                  title: const Text('Filters'),
                ),
                bottomSheet: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 90, right: 90),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Apply',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                body: SingleChildScrollView(
                  child: Container(
                      margin: const EdgeInsets.only(bottom: 50),
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
                            active: _tagsProvider!.lisContainsTag(currentTag)
                                ? true
                                : false,
                            activeColor: Theme.of(context).primaryColor,
                            combine: ItemTagsCombine.withTextAfter,
                            onPressed: (i) {
                              addOrRemove!(currentTag);
                            },
                          );
                        },
                      )),
                ),
              );
  }
}
