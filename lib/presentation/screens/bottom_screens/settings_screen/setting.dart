import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/presentation/screens/bottom_screens/settings_screen/setting_cubit/setting_cubit.dart';
import 'package:social/presentation/screens/home_screen/home_cubit/home_cubit.dart';
import 'package:social/routes.dart';

import '../../../../const/Pallet.dart';
import '../../../../const/objects.dart';
import '../../../components/general.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener

        if (state is HomeUserDispose) {
          HomeCubit.get(context).getUser();
        }
      },
      builder: (context, state) {
        return BlocProvider<SettingCubit>(
          create: (_) => SettingCubit()..getUser(),
          child: BlocConsumer<SettingCubit, SettingState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              var cubit = SettingCubit.get(context);
              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Container(
                        height: 250,
                        child: Stack(
                            fit: StackFit.loose,
                            alignment: Alignment.bottomCenter,
                            children: [
                              Positioned(
                                bottom: 45,
                                top: 0,
                                // width: double.maxFinite,
                                left: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          currentUser!.coverImage!),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  height: 120,
                                  width: 120,
                                  child: Stack(
                                      alignment: Alignment.center,
                                      fit: StackFit.passthrough,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Pallet.clearColor,
                                        ),
                                        Positioned(
                                          height: 115,
                                          width: 115,
                                          child: CircleClip(
                                            radius: 120,
                                            picture: currentUser!.image!,
                                          ),
                                        ),
                                      ]),
                                ),
                              )
                            ]),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Column(
                        children: [
                          Text(currentUser!.userName!),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            currentUser!.bio!,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 14),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          ProfileInfoButton(),
                          ProfileInfoButton(),
                          ProfileInfoButton(),
                          ProfileInfoButton(),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              height: 50,
                              child: OutlinedButton(
                                style: ButtonStyle(
                                  side: MaterialStateProperty.all(
                                    BorderSide(color: Pallet.mainColor),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  'Add Photos',
                                  style: TextStyle(color: Pallet.mainColor),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 50,
                              child: OutlinedButton(
                                style: ButtonStyle(
                                  side: MaterialStateProperty.all(
                                    BorderSide(color: Pallet.mainColor),
                                  ),
                                ),
                                onPressed: () {
                                  cubit.close();
                                  Navigator.of(context).pushNamed(Screens.edit);
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: Pallet.mainColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class ProfileInfoButton extends StatelessWidget {
  const ProfileInfoButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: SizedBox(
          height: 50,
          child: Column(
            children: [
              Text('100'),
              SizedBox(height: 12),
              Text(
                'Posts',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
