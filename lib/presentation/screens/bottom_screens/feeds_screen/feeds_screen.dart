import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/const/strings.dart';
import 'package:social/presentation/const.dart';
import 'package:social/presentation/screens/bottom_screens/feeds_screen/feed_bloc/feed_cubit.dart';

import '../../../components/general.dart';
import 'components.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeedCubit>(
      create: (context) => FeedCubit()..getUser(),
      child: BlocConsumer<FeedCubit, FeedState>(
        listener: (context, state) {
          if (state is FeedInitial) {
            // FeedCubit.get(context).getUser();
            // print('my user :' + FeedCubit.get(context).currentUser!.image!);
          }
        },
        builder: (context, state) {
          var cubit = FeedCubit.get(context);
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image(
                      image: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLiDt3lCIYNIXKAOkdLsPnXgM620egW67IHQ&usqp=CAU',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                PostItem(
                  userName: cubit.currentUser!.userName!,
                  picture: postPic,
                  profPic: cubit.currentUser?.image ?? '',
                ),
                PostItem(
                  userName: cubit.currentUser!.userName!,
                  picture: postPic,
                  profPic: cubit.currentUser?.image ?? '',
                ),
                PostItem(
                  userName: cubit.currentUser!.userName!,
                  picture: postPic,
                  profPic: cubit.currentUser?.image ?? '',
                ),

                // Container(
                //   child: ListView.builder(
                //     itemBuilder: (context, index) {
                //       return PostItem();
                //     },
                //     physics: NeverScrollableScrollPhysics(),
                //     shrinkWrap: true,
                //   ),
                // )
              ],
            ),
          );
        },
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  PostItem({
    required this.userName,
    required this.picture,
    required this.profPic,
    Key? key,
  }) : super(key: key);

  String picture;
  String profPic;
  String userName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        child: Card(
          // margin: EdgeInsets.all(10),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleClip(radius: 50, picture: profPic),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              userName,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(fontSize: 13),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            const Icon(
                              Icons.verified,
                              color: Colors.blue,
                              size: 18,
                            )
                          ],
                        ),
                        Text(
                          'January 21, 2022 at 11:00PM ',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 11, height: 1.3),
                        )
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.linear_scale_rounded),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                    'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text.'),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                    width: double.infinity,
                    child: Wrap(
                      children: [
                        Container(
                          height: 20,
                          child: MaterialButton(
                            padding: const EdgeInsets.only(right: 5),
                            minWidth: 1,
                            onPressed: () {},
                            child: Text(
                              '#flutter',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: Colors.blue),
                            ),
                          ),
                        ),
                        Container(
                          height: 20,
                          child: MaterialButton(
                            padding: const EdgeInsets.only(right: 5),
                            minWidth: 1,
                            onPressed: () {},
                            child: Text(
                              '#flutter',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: Colors.blue),
                            ),
                          ),
                        ),
                        Container(
                          height: 20,
                          child: MaterialButton(
                            padding: const EdgeInsets.only(right: 5),
                            minWidth: 1,
                            onPressed: () {},
                            child: Text(
                              '#flutter',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: Colors.blue),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(picture),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 30,
                  child: Row(
                    children: [
                      Expanded(
                        child: postBarItemButton(
                          icon: like,
                          title: '120',
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: postBarItemButton(
                          main: MainAxisAlignment.end,
                          icon: comment,
                          title: '120 Comments',
                          onTap: () {
                            print('tapped');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Container(
                    height: 35,
                    width: double.maxFinite,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleClip(radius: 40, picture: profPic),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                hintText: 'Write Comment...',
                                hintStyle: Theme.of(context).textTheme.caption),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Container(
                            width: 60,
                            child: postBarItemButton(
                              icon: like,
                              onTap: () {},
                              title: 'Like',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Container(
                            width: 60,
                            child: postBarItemButton(
                              icon: comment,
                              onTap: () {},
                              title: 'Share',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
