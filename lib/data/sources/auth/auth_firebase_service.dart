import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_clone/data/models/auth/create_user_req.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserReq createUserReq);
  Future<void> signin();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserReq.email,
        password: createUserReq.password,
      );
      return Right('Signup was successful');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Left('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return Left('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        return Left('The email address is not valid.');
      } else if (e.code == 'operation-not-allowed') {
        return Left('Email/Password accounts are not enabled.');
      }
      return Left('An unknown error occurred: ${e.message}');
    }
  }

  @override
  Future<void> signin() {
    throw UnimplementedError('signin() has not been implemented yet.');
  }
}
