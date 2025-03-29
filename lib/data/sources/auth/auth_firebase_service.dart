import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_clone/data/models/auth/create_user_req.dart';
import 'package:spotify_clone/data/models/auth/signin_user_req.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserReq createUserReq);
  Future<Either> signin(SigninUserReq signinUserReq);
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserReq.email,
        password: createUserReq.password,
      );

      FirebaseFirestore.instance.collection('Users').add({
        'name': createUserReq.fullName,
        'email': data.user?.email,
      });

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
  Future<Either> signin(SigninUserReq signinUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signinUserReq.email,
        password: signinUserReq.password,
      );
      return Right('Signin was successful');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return Left('The email address is not valid.');
      } else if (e.code == 'invalid-credential') {
        return Left('Wrong password provided for that user.');
      }
      return Left('An unknown error occurred: ${e.message}');
    }
  }
}
