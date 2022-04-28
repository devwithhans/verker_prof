import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/projects_bloc/projects_cubit.dart';
import 'package:verker_prof/blocs/projects_bloc/projects_event.dart';
import 'package:verker_prof/models/outreach.dart';
import 'package:verker_prof/theme/constants/textstyle.dart';
import 'package:verker_prof/theme/widgets/components.dart';
import 'package:verker_prof/theme/widgets/loading_indicator.dart';
import 'package:verker_prof/views/projects_view/projects_widgets/project_tile.dart';

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
      body: BlocBuilder<ProjectsBloc, ProjectsState>(
        builder: (context, state) {
          if (state.status == ProjectsStatus.succes) {
            return tabList(state.projects,
                'Du har endnu ingen færdige projekter', context);
          }
          if (state.status == ProjectsStatus.failed) {
            return CenterText('Vi stødte desværre på en fejl');
          }
          return const Center(
            child: LoadingIndicator(),
          );
        },
      ),
    );
  }

  Widget tabList(
      List<Outreach> outreaches, String besked, BuildContext context) {
    return outreaches.isNotEmpty
        ? RefreshIndicator(
            onRefresh: () async {
              context.read<ProjectsBloc>().add(FetchMyProjects());
            },
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 20),
              itemCount: outreaches.length,
              itemBuilder: ((context, index) {
                return ProjectTile(outreach: outreaches[index]);
              }),
            ),
          )
        : CenterText(besked);
  }
}
