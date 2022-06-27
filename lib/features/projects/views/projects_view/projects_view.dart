import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/features/projects/bloc/projects_bloc/projects_cubit.dart';
import 'package:verker_prof/features/projects/bloc/projects_bloc/projects_event.dart';

import 'package:verker_prof/features/projects/models/outreach.dart';
import 'package:verker_prof/features/projects/views/projects_view/projects_widgets/project_tile.dart';
import 'package:verker_prof/utils/theme/constants/textstyle.dart';
import 'package:verker_prof/utils/theme/widgets/components.dart';
import 'package:verker_prof/utils/theme/widgets/loading_indicator.dart';

class ProjectsView extends StatelessWidget {
  const ProjectsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        title: const Text(
          'Projekter',
          style: kSmallBold,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ProjectsBloc>().add(FetchMyProjects());
        },
        child: BlocBuilder<ProjectsBloc, ProjectsState>(
          builder: (context, state) {
            print(state.projects.length);
            if (state.status == ProjectsStatus.succes) {
              return tabList(
                  state.projects,
                  'Du har endnu ingen projekter. Begynd at swipe nogle nye projekter',
                  context);
            }
            if (state.status == ProjectsStatus.failed) {
              return const CenterText('Vi stødte desværre på en fejl');
            }
            return const Center(
              child: LoadingIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget tabList(
      List<Outreach> outreaches, String besked, BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 20),
        itemCount: outreaches.isEmpty ? 1 : outreaches.length,
        itemBuilder: ((context, index) {
          return outreaches.isEmpty
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CenterText(
                      besked,
                    ),
                  ))
              : ProjectTile(outreach: outreaches[index]);
        }));
  }
}
