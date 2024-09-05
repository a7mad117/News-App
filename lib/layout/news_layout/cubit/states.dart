abstract class  NewsStates{}

/// Initial States
class NewsInitialStates extends NewsStates{}

/// Bottom Navigation Bar States
class NewBottomNavStates extends NewsStates{}


/// Business States
class NewGetBusinessLoadingStates extends NewsStates{}
class NewGetBusinessSuccessStates extends NewsStates{}
class NewGetBusinessErrorStates extends NewsStates{
  final String error;

  NewGetBusinessErrorStates(this.error);
}


/// Sports States
class NewGetSportsLoadingStates extends NewsStates{}
class NewGetSportsSuccessStates extends NewsStates{}
class NewGetSportsErrorStates extends NewsStates{
  final String error;

  NewGetSportsErrorStates(this.error);
}


/// Science States
class NewGetScienceLoadingStates extends NewsStates{}
class NewGetScienceSuccessStates extends NewsStates{}
class NewGetScienceErrorStates extends NewsStates{
  final String error;

  NewGetScienceErrorStates(this.error);
}


/// Search States
class NewGetSearchLoadingStates extends NewsStates{}
class NewGetSearchSuccessStates extends NewsStates{}
class NewGetSearchErrorStates extends NewsStates{
  final String error;

  NewGetSearchErrorStates(this.error);
}