import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/features/swipe/bloc/swipe_bloc/swipe_bloc.dart';
import 'package:verker_prof/features/swipe/models/filter.dart';
import 'package:verker_prof/utils/theme/widgets/buttons.dart';
import 'package:verker_prof/utils/theme/widgets/standard_slider.dart';

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

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
        padding: const EdgeInsets.only(top: 7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        height: MediaQuery.of(context).size.height * 0.5,
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
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.close),
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
                  StandardSlider(
                    min: 10,
                    max: 500,
                    title: 'Aftandspræference',
                    initialValue: _distance.toDouble(),
                    onChanged: (v) {
                      _distance = v.toInt();
                    },
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: StandardButton(
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
