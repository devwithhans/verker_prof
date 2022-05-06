import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/outreach_bloc/outreach_bloc.dart';
import 'package:verker_prof/blocs/projects_bloc/projects_cubit.dart';
import 'package:verker_prof/blocs/projects_bloc/projects_event.dart';
import 'package:verker_prof/blocs/swipe_bloc/swipe_bloc.dart';
import 'package:verker_prof/models/project.dart';
import 'package:verker_prof/services/variables.dart';
import 'package:verker_prof/theme/constants/textstyle.dart';
import 'package:verker_prof/theme/widgets/buttons.dart';
import 'package:verker_prof/theme/widgets/components.dart';
import 'package:verker_prof/theme/widgets/loading_indicator.dart';
import 'package:verker_prof/views/project_details_view/project_details_widgets/image_inspect.dart';
import 'package:verker_prof/views/project_details_view/project_details_widgets/send_outreach.dart';

// ignore: must_be_immutable
class ProjectDetailsView extends StatelessWidget {
  final ProjectModel project;
  final bool outreach;

  ProjectDetailsView({Key? key, required this.project, this.outreach = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List media = [];
    media = project.images;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          splashRadius: 20,
          focusColor: Colors.black,
          splashColor: Colors.black,
          highlightColor: Colors.black,
          icon: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(20)),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            children: [
              SizedBox(
                  height: 500,
                  child: CarouselSlider.builder(
                      options: carouselOptions,
                      itemCount: media.length,
                      itemBuilder: (context, indexOne, indexTwo) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageInspect(
                                  image: imageUrl + project.images[indexOne],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    imageUrl + project.images[indexOne]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      })),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      project.title!,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: kMediumBold,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      outreach
                          ? '${project.address!['zip']}'
                          : '${project.address!['zip']} ( ${project.distance!.toInt()} Km )',
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Text(
                      project.description!,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
          outreach ? const SizedBox() : OutreachButton(project: project)
        ],
      ),
    );
  }

  CarouselOptions carouselOptions = CarouselOptions(
    autoPlay: false,
    viewportFraction: 1,
    enableInfiniteScroll: false,
    height: double.infinity,
    enlargeCenterPage: true,
    enlargeStrategy: CenterPageEnlargeStrategy.height,
  );
}

class OutreachButton extends StatelessWidget {
  const OutreachButton({
    Key? key,
    required this.project,
  }) : super(key: key);

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    SwipeBloc swipeBloc = context.read<SwipeBloc>();
    ProjectsBloc projectsCubit = context.read<ProjectsBloc>();
    return Positioned(
      bottom: 40,
      left: 20,
      right: 20,
      child: ContinueButton(
        onPressed: () async {
          showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => BlocProvider<OutreachBloc>(
              create: (context) => OutreachBloc(swipeBloc),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: BlocBuilder<OutreachBloc, OutreachState>(
                    builder: (context, state) {
                      if (state.status == OutreachStatus.succes) {
                        Future.delayed(Duration.zero, () {
                          Navigator.of(context)
                              .popUntil(ModalRoute.withName('/'));
                        });
                        projectsCubit.add(FetchMyProjects());
                      }
                      if (state.status == OutreachStatus.failed) {
                        return const CenterText(
                            'Vi kunne ikke sende din besked, prøv igen senere');
                      }
                      if (state.status == OutreachStatus.initial) {
                        return SendOutreachSheet(
                          projectId: project.id!,
                        );
                      }
                      return const Center(
                        child: LoadingIndicator(),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
        backgroundColor: Colors.black,
        textColor: Colors.white,
        text: 'Giv et bud',
      ),
    );
  }
}
