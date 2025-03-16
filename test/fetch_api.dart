import 'dart:convert';
import 'package:ecommerce_app/presentation/mainhomescreen/bloc/mainscreen_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'fetch_api.mocks.dart';

@GenerateMocks([http.Client])

void main() {
  //evaluate targetd function//what dose function do//
  //write group test//
  late MainscreenBloc mainscreenBloc;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    mainscreenBloc = MainscreenBloc(client: mockClient);
  });

  tearDown(() {
    mainscreenBloc.close();
  });

  group('MainscreenBloc', () {
    //1sucessfull test//
    test('sucessfully fetchapi', () async {
      when(mockClient.get(Uri.parse('https://fakestoreapi.com/products/')))
          .thenAnswer((_) async => http.Response(
              jsonEncode([
                {"id": 1, "title": "Test Product"}
              ]),
              200));

      expectLater(
          mainscreenBloc.stream,
          emitsInOrder([
            isA<MainScreenLoadingState>(),
            isA<MainScreenLoadedSuccessfullyState>()
          ]));
      mainscreenBloc.add(MainScreenInitialEvent());
    });
    //2failure test//
    test('not sucessfully fetchapi', () async {
      when(mockClient.get(Uri.parse('https://fakestoreapi.com/products/')))
          .thenAnswer((_) async => http.Response('not found', 400));
      expectLater(
          mainscreenBloc.stream,
          emitsInOrder([
            isA<MainScreenLoadingState>(),
            isA<MainScreenLoadedSuccessfullyState>()
          ]));

      mainscreenBloc.add(MainScreenInitialEvent());
    });
  });
}
