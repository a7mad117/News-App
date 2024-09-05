import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../modules/business/business_screen.dart';
import '../../../modules/science/science_screen.dart';
import '../../../modules/sports/sports_screen.dart';
import '../../../shared/network/remote/dio_helper.dart';
import 'states.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);

  ///
  ///Bottom Navigation Bar Code
  int currentIndex = 0;

  final List<Widget> newsScreen = const [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    // SettingsScreen(),
  ];

  final List<String> titles = [
    'Business News',
    'Sports News',
    'Science News',
    // 'Settings',
  ];

  List<BottomNavigationBarItem> bottomNavItems = const [
    BottomNavigationBarItem(
      label: 'Business',
      icon: Icon(Icons.business),
    ),
    BottomNavigationBarItem(
      label: 'Sports',
      icon: Icon(Icons.sports),
    ),
    BottomNavigationBarItem(
      label: 'Science',
      icon: Icon(Icons.science),
    ),
    // BottomNavigationBarItem(
    //   label: 'Settings',
    //   icon: Icon(Icons.settings),
    // ),
  ];

  void changeIndex(int index)
  {
    currentIndex =index;
    if(index==1) {
      getSports();
    }
    if(index==2) {
      getScience();
    }
      emit(NewBottomNavStates());
  }


  ///
  ///business Code
  List<dynamic> business = [];

  void getBusiness(){
    if(business.isEmpty){
      emit(NewGetBusinessLoadingStates());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apiKey':'d7a7d49d1cfa42c9a54aa645bc58cf8e',
        },
      ).then((value){
          business = value.data['articles'];
        debugPrint(business[0]['title'].toString());
        emit(NewGetBusinessSuccessStates());
      }).catchError((err){
        debugPrint(err.toString());
        emit(NewGetBusinessErrorStates(err.toString()));
      });
    }else{
      emit(NewGetBusinessSuccessStates());
    }

  }


  ///
  ///Sports Code
  List<dynamic> sports = [];

  void getSports(){
    if(sports.isEmpty){
      emit(NewGetBusinessLoadingStates());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'sports',
          'apiKey':'d7a7d49d1cfa42c9a54aa645bc58cf8e',
        },
      ).then((value){
        sports = value.data['articles'];
        debugPrint(sports[0]['title'].toString());
        emit(NewGetSportsSuccessStates());
      }).catchError((err){
        debugPrint(err.toString());
        emit(NewGetSportsErrorStates(err.toString()));
      });
    }else{
      emit(NewGetSportsSuccessStates());
    }
  }


  ///
  ///Science Code
  List<dynamic> science = [];

  void getScience(){
    if(science.isEmpty){
      emit(NewGetScienceLoadingStates());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apiKey':'d7a7d49d1cfa42c9a54aa645bc58cf8e',
        },
      ).then((value){
        science = value.data['articles'];
        debugPrint(science[0]['title'].toString());
        emit(NewGetScienceSuccessStates());
      }).catchError((err){
        debugPrint(err.toString());
        emit(NewGetScienceErrorStates(err.toString()));
      });
    }else{
      emit(NewGetScienceSuccessStates());
    }
  }


///
///Search Code
  List<dynamic> search = [];

  void getSearch(String value){
    emit(NewGetSearchLoadingStates());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q':value,
        'apiKey':'d7a7d49d1cfa42c9a54aa645bc58cf8e',
      },
    ).then((value){
      search = value.data['articles'];
      debugPrint(search[0]['title'].toString());
      emit(NewGetSearchSuccessStates());
    }).catchError((err){
      debugPrint(err.toString());
      emit(NewGetSearchErrorStates(err.toString()));
    });
  }

}
