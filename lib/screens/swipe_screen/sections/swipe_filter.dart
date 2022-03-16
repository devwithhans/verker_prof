import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:verker_prof/blocs/swipe_bloc/swipe_bloc.dart';
import 'package:verker_prof/models/filter.dart';
import 'package:verker_prof/widgets/buttons.dart';

class Filter extends StatefulWidget {
  Filter();

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  late int _distance;
  late List<double> _position;
  late String _type;
  @override
  void initState() {
    SwipeState state = context.read<SwipeBloc>().state;
    super.initState();
    _distance = state.maxDistance ~/ 1000;
    _position = state.position;
    _type = state.type;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            const SizedBox(
              width: 40,
              child: Divider(
                color: Colors.grey,
                thickness: 4,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close),
                  ),
                  const Text(
                    'Filter',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const Icon(
                    Icons.close,
                    color: Colors.transparent,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              height: 0,
              thickness: 1,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Afstand',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            '${_distance.toInt()} Km',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      const Text(
                        'Søg på afstand fra virksomhedens addresse',
                        style: TextStyle(fontSize: 13),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Slider(
                        label: 'Km',
                        value: _distance.toDouble(),
                        min: 10,
                        max: 500,
                        onChanged: (v) {
                          setState(() {
                            _distance = v.toInt();
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  CommentBox(
                    title: 'Giv os din mening! 🙏',
                    message:
                        'Har du specifikt øsnke til hvad du skal kunne filterer efter, så vil vi elske at høre om det!',
                  )
                ],
              ),
            ),
            const Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: NavigationButton(
                onPressed: () {
                  BlocProvider.of<SwipeBloc>(context).add(
                    FetchProjects(
                      projectSearchFilter: ProjectSearchFilter(
                        maxDistance: _distance * 1000,
                        position: _position,
                        type: _type,
                      ),
                    ),
                  );
                  Navigator.pop(context);
                },
                text: 'Søg',
              ),
            ),
            const SizedBox(height: 40),
          ],
        ));
  }
}

class CommentBox extends StatelessWidget {
  String title;
  String message;

  CommentBox({this.title = "", this.message = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffEADCBC),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(title, style: TextStyle(fontSize: 20)),
          const SizedBox(
            height: 10,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          NavigationButton(
            text: 'Send besked til udvikleren',
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
