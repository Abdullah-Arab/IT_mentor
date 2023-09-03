import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itmentor/blocs/about/about_cubit.dart';
import 'package:itmentor/blocs/news/news_cubit.dart';
import 'package:itmentor/screens/dashboard/dashboard_item.dart';
import 'package:itmentor/screens/widgets/loading_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../services/locator.dart';
import '../../../utilities/consts.dart';

class InfoDashboard extends StatelessWidget {
  const InfoDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => locator<AboutCubit>(),
        child: BlocBuilder<AboutCubit, AboutState>(
          builder: (context, state) {
            return state.when(
              initial: () => const LoadingWidget(),
              loading: () => const LoadingWidget(),
              loaded: (about) => Stack(
                children: [
               SingleChildScrollView(
              child: Padding(
              padding: const EdgeInsets.symmetric(
              horizontal: Consts.paddingMedium,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...about.sections.entries
                      .map((e) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e.key,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium,
                      ),
                      const SizedBox(
                        height: Consts.paddingSmall,
                      ),
                      Text(
                        e.value,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium,
                      ),
                      const SizedBox(height: Consts.paddingLarge,)
                    ],
                  ))
                      .toList(),

                  const SizedBox(
                    height: Consts.paddingSmall,
                  ),
                  ExpansionTile(
                    title: Text("روابط", style:  Theme.of(context).textTheme.titleMedium,),
                    children: [
                      for(var link in about.socialMedia.entries )
                        Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: Consts.paddingMedium),
                              child: Divider(),
                            ),
                            ListTile(
                              trailing: const Icon(
                                Icons.link,
                                size: Consts.defaultIconSizeSmall,
                                color: Color(0xff898F9B),
                              ),
                              title: Text(link.key,
                                  style:  Theme.of(context).textTheme.bodyMedium),
                              onTap: () async {
                                // launch url
                                launchUrl(Uri.parse(link.value),
                                    mode: LaunchMode.externalApplication);
                                //    : throw 'Could not launch $e.value';
                              },
                            ),
                            if (about.socialMedia.entries.last.key == link.key)
                              const SizedBox(
                                height: Consts.paddingMedium,
                              ),
                          ],
                        )
                    ],
                  ),
                  const SizedBox(
                    height: Consts.paddingLarge*2,
                  ),
                  Text(
                    "الفريق",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: Consts.paddingSmall,
                  ),
                  ...about.team
                      .map((member) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: Consts.paddingSmall),
                        child: ExpansionTile(
                          title: Text(
                            member.name,
                            style:  Theme.of(context).textTheme.titleMedium,
                          ),
                          subtitle: Text(member.role,
                              style: Theme.of(context).textTheme.bodyMedium),
                          children: [
                            for (var link in member.links.entries)
                              Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                        Consts.paddingMedium),
                                    child: Divider(),
                                  ),
                                  ListTile(
                                    trailing: const Icon(
                                      Icons.link,
                                      size: Consts
                                          .defaultIconSizeSmall,
                                      color: Color(0xff898F9B),
                                    ),
                                    title: Text(link.key,
                                        style:  Theme.of(context).textTheme.bodyMedium),
                                    onTap: () async {
                                      // launch url
                                      launchUrl(
                                          Uri.parse(link.value),
                                          mode: LaunchMode
                                              .externalApplication);
                                      //    : throw 'Could not launch $e.value';
                                    },
                                  ),
                                  if (member.links.entries.last
                                      .key ==
                                      link.key)
                                    const SizedBox(
                                      height:
                                      Consts.paddingMedium,
                                    ),
                                ],
                              )
                          ],
                        ),
                      ),
                    ],
                  ))
                      .toList(),

                ],
              ),
            ),
            ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: FloatingActionButton.extended(
                      heroTag: 'addNews',
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: const Text('إضافة'),
                    ),
                  )
                ],
              ),
              error: (message) => ErrorWidget(message),
            );
          },
        ));
  }
}
