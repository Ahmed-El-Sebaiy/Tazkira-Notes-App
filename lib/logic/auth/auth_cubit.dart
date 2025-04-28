import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  AuthCubit() : super(AuthInitialState(),);

  togglePasswordVisibilityIcon(){
    if (state is PasswordHiddenState){
      emit(PasswordVisibilityState(),);
    } else{
      emit(PasswordHiddenState(),);
    }
  }

  Future<void> signUp({required String email, required String password,}) async{
    emit(AuthLoaingState(),);
    try {
      await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
      );
      emit(AuthSuccessState(),);
    } catch (error) {
      emit(AuthErrorState(
        errMessage : error.toString(),
      ),
      );
    }
  }

  Future<void> signIn({required String email,required String password,}) async{
    emit(AuthLoaingState(),);
    try {
      await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
      );
      emit(AuthSuccessState(),);
    } catch (error) {
      emit(AuthErrorState(
          errMessage: error.toString(),
      ),
      );
    }
  }

  Future<void> signInWithGoogle() async{
    emit(AuthLoaingState(),);
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null){
        emit(AuthErrorState(
            errMessage: 'Google Sign-In Failed',
        ),
        );
        return;
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await auth.signInWithCredential(credential);
      emit(AuthSuccessState(),);
    } catch (error) {
      emit(AuthErrorState(
          errMessage: error.toString(),
      ),
      );
    }
  }
}
