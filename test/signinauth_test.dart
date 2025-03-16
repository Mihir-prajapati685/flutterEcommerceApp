import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce_app/presentation/authentication/Signuppageauth/bloc/signin_bloc.dart';
import 'package:http/http.dart' as http;
import 'signinauth_test.mocks.dart';
import 'package:firebase_core/firebase_core.dart';

@GenerateMocks([
  FirebaseFirestore,
  CollectionReference,
  QuerySnapshot,
  DocumentReference,
  QueryDocumentSnapshot<Map<String, dynamic>>
])
void main() {
  late SigninBloc signinBloc;
  late MockFirebaseFirestore mockFirebase;
  late MockCollectionReference<Map<String, dynamic>> mockcollectionreference;
  late MockQuerySnapshot<Map<String, dynamic>> mockquerysnapshot;
  late MockDocumentReference<Map<String, dynamic>> mockdocumentreference;
  late MockQueryDocumentSnapshot<Map<String, dynamic>>
      mockQueryDocumentSnapshot;

  setUp(() async {
    signinBloc = SigninBloc();
    mockFirebase = MockFirebaseFirestore();
    mockcollectionreference = MockCollectionReference<Map<String, dynamic>>();
    mockquerysnapshot = MockQuerySnapshot<Map<String, dynamic>>();
    mockdocumentreference = MockDocumentReference();
    mockQueryDocumentSnapshot =
        MockQueryDocumentSnapshot<Map<String, dynamic>>();
  });
  tearDown(() {
    signinBloc.close();
  });

  group('Authentication signin', () {
    test('if username is empty then', () {
      expectLater(
        signinBloc.stream,
        emits(isA<UsernamefieldIsEmpty>()), // ✅ Use emits()
      );
      signinBloc.add(SignInButtonClickedEvent(
          username: '', email: 'mihir@gmail.com', password: '12345'));
    });
    test('if email is empty then', () {
      expectLater(
        signinBloc.stream,
        emits(isA<EmailfieldIsEmpty>()), // ✅ Use emits()
      );
      signinBloc.add(SignInButtonClickedEvent(
          username: 'mihir', email: '', password: '12345'));
    });
    test('if password is empty then', () {
      expectLater(
        signinBloc.stream,
        emits(isA<PasswordfieldIsEmpty>()), // ✅ Use emits()
      );
      signinBloc.add(SignInButtonClickedEvent(
          username: 'mihir', email: 'mihir@gmail.com', password: ''));
    });
    test('if email not contain @  then', () {
      expectLater(
        signinBloc.stream,
        emits(isA<AtTheRateNotContainState>()), // ✅ Use emits()
      );
      signinBloc.add(SignInButtonClickedEvent(
          username: 'mihir', email: 'mihirgmail.com', password: '34567'));
    });

    test('if email already exist', () async {
      when(mockFirebase.collection('signincollection'))
          .thenReturn(mockcollectionreference);
      when(mockcollectionreference.where('email', isEqualTo: 'test@gmail.com'))
          .thenReturn(mockcollectionreference);
      when(mockquerysnapshot.docs).thenReturn([(MockQueryDocumentSnapshot())]);

      expectLater(
        signinBloc.stream,
        emits(isA<AlreadyEmailExistState>()),
      );
      signinBloc.add(SignInButtonClickedEvent(
          username: 'John', email: 'test@gmail.com', password: '123456'));
    });

    test('if user successfully signs in', () async {
      // Mock Firestore collection reference
      when(mockFirebase.collection('signincollection'))
          .thenReturn(mockcollectionreference);

      final mockQuery = MockCollectionReference<Map<String, dynamic>>();
      when(mockcollectionreference.where('email', isEqualTo: 'test@gmail.com'))
          .thenReturn(mockQuery);
      when(mockQuery.get()).thenAnswer((_) async => mockquerysnapshot);
      when(mockquerysnapshot.docs).thenReturn([mockQueryDocumentSnapshot]);
      when(mockcollectionreference.add({
        'username': 'mihir',
        'email': 'mihir@123gmail.com',
        'password': '12346y',
      })).thenAnswer((_) async => MockDocumentReference());

      // Expect SuccessfullSignInState to be emitted
      expectLater(
        signinBloc.stream,
        emits(isA<SuccessfullSignInState>()),
      );

      // Dispatch sign-in event
      signinBloc.add(SignInButtonClickedEvent(
        username: 'John',
        email: 'test@gmail.com',
        password: '123456',
      ));
    });
  });
}
