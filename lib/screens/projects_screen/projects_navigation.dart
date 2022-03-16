import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/projects_bloc/projects_cubit.dart';
import 'package:verker_prof/models/outreach.dart';
import 'package:verker_prof/screens/projects_screen/project_tile.dart';
import 'package:verker_prof/theme/constants/textstyle.dart';
import 'package:verker_prof/widgets/components.dart';

class ProjectTab extends StatelessWidget {
  const ProjectTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ProjectsCubit>().getMyProjects();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Projekter',
            style: kTextSmallBold,
          ),
          bottom: const TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            labelStyle: kTextSmallBold,
            unselectedLabelStyle: kTextSmallNormal,
            tabs: [
              Tab(text: 'Salg'),
              Tab(text: 'Aktive'),
              Tab(text: 'Afsluttede'),
            ],
          ),
        ),
        body: BlocBuilder<ProjectsCubit, ProjectsState>(
          builder: (context, state) {
            if (state.status == ProjectsStatus.succes) {
              List<Outreach> pendingOutreaches = state.projects
                  .where((element) => element.status == 'PENDING')
                  .toList();
              List<Outreach> activeProjects = state.projects
                  .where((element) => element.status == 'ACTIVE')
                  .toList();
              List<Outreach> doneProjects = state.projects
                  .where((element) => element.status == 'DONE')
                  .toList();

              return TabBarView(
                children: [
                  tabList(pendingOutreaches,
                      'Du har endnu ingen færdige projekter'),
                  tabList(
                      activeProjects, 'Du har endnu ingen færdige projekter'),
                  tabList(doneProjects, 'Du har endnu ingen færdige projekter'),
                ],
              );
            }
            if (state.status == ProjectsStatus.failed) {
              return CenterText('CenterText');
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget tabList(List<Outreach> outreaches, String besked) {
    return outreaches.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.only(top: 20),
            itemCount: outreaches.length,
            itemBuilder: ((context, index) {
              return ProjectTile(outreach: outreaches[index]);
            }),
          )
        : CenterText(besked);
  }
}
