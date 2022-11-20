part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<Restaurant> data;
  const SearchSuccess({
    required this.data,
  });

  @override
  List<Object> get props => [data];
}

class SearchFailure extends SearchState {
  final String message;
  const SearchFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
