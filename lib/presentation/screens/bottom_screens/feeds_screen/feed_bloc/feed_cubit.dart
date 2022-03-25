import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:social/data/repo/firebase_auth_provider.dart';

import '../../../../../data/models/user.dart';

part 'feed_state.dart';

class FeedCubit extends Cubit<FeedState> {
  FeedCubit() : super(FeedInitial());

  static FeedCubit get(context) => BlocProvider.of(context);

  Users? currentUser;
  Users? getUser() {
    emit(FeedLoading());
    // print('print user : ' + FirebaseAuthRepository.userModel!.image!);

    currentUser = FirebaseAuthRepository.userModel;

    print(currentUser!.image);
    emit(FeedSuccess());
  }
}
