import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/presentation/components/buttons.dart';
import 'package:social/presentation/components/general.dart';
import 'package:social/presentation/const.dart';
import 'package:social/presentation/screens/bottom_screens/settings_screen/setting_cubit/setting_cubit.dart';
import 'package:social/presentation/screens/home_screen/home_cubit/home_cubit.dart';

import '../../../const/Pallet.dart';
import '../../../const/objects.dart';
import '../../components/text_field.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SettingCubit()
          ..getUserEdit(
            bio: bioController,
            name: nameController,
            phone: phoneController,
          ),
        child: Scaffold(
          appBar: MyAppBar(
              title: 'Edit Profile',
              leading: IconButton(
                onPressed: () {
                  print('lll');
                  HomeCubit.get(context).disposeEdit();
                  Navigator.pop(context, true);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Update'),
                  ),
                )
              ]),
          body: BlocConsumer<SettingCubit, SettingState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              var cubit = SettingCubit.get(context);
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    children: [
                      if (state is EditLoading)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3.0),
                          child: Container(
                              height: 5, child: LinearProgressIndicator()),
                        ),
                      SizedBox(
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
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: cubit.pickedCoverPic != null
                                              ? FileImage(cubit.pickedCoverPic!)
                                                  as ImageProvider
                                              : NetworkImage(
                                                  currentUser!.coverImage!),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        top: 10,
                                        right: 10,
                                        child: EditingButton(
                                          onPressed: () async {
                                            await cubit.uploadCoverImage();
                                          },
                                        )),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Stack(
                                      alignment: Alignment.center,
                                      fit: StackFit.passthrough,
                                      children: [
                                        const CircleAvatar(
                                          backgroundColor: Pallet.clearColor,
                                        ),
                                        Positioned(
                                            height: 115,
                                            width: 115,
                                            child: ClipOval(
                                              child: cubit.pickedProfilePic !=
                                                      null
                                                  ? Image.file(
                                                      cubit.pickedProfilePic!)
                                                  : Image.network(
                                                      currentUser!.image!,
                                                      height:
                                                          getHeight(context),
                                                      width: getWidth(context),
                                                      fit: BoxFit.fill,
                                                    ),
                                            )),
                                        Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: EditingButton(
                                              onPressed: () async {
                                                await cubit
                                                    .uploadProfileImage();
                                              },
                                            ))
                                      ]),
                                ),
                              )
                            ]),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              if (cubit.pickedProfilePic != null)
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: double.maxFinite,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            await cubit
                                                .uploadProfileImageButton();
                                          },
                                          child: Text('upload profile'),
                                        ),
                                      ),
                                      if (state
                                          is EditUploadingProfilePictureLoading)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: LinearProgressIndicator(),
                                        ),
                                    ],
                                  ),
                                ),
                              if (cubit.pickedCoverPic != null &&
                                  cubit.pickedProfilePic != null)
                                SizedBox(
                                  width: 15,
                                ),
                              if (cubit.pickedCoverPic != null)
                                Expanded(
                                    child: Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: double.maxFinite,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          await cubit.uploadCoverImageButton();
                                        },
                                        child: Text('upload Cover'),
                                      ),
                                    ),
                                    if (state
                                        is EditUploadingCoverPictureLoading)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: const LinearProgressIndicator(),
                                      ),
                                  ],
                                ))
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ProfileEditingTextField(
                            bioController: nameController,
                            currentUser: currentUser!,
                            labelText: 'user name',
                            prefixIcon: Icon(Icons.perm_identity),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          ProfileEditingTextField(
                            bioController: bioController,
                            currentUser: currentUser!,
                            labelText: 'Bio',
                            prefixIcon: Icon(Icons.menu_book_rounded),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          ProfileEditingTextField(
                            bioController: phoneController,
                            currentUser: currentUser!,
                            labelText: 'Phone Number',
                            prefixIcon: Icon(Icons.call),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      AppFlatButton(
                          padding: 0,
                          height: getHeight(context),
                          onPressed: () async {
                            await cubit.updateUser(
                              context: context,
                              name: nameController,
                              phone: phoneController,
                              bio: bioController,
                            );
                          },
                          title: 'Save')
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
