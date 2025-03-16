import 'package:app_front_talearnt/data/model/respone/pagination.dart';
import 'package:flutter/material.dart';

import '../../constants/global_value_constants.dart';
import '../../data/model/respone/community_board.dart';
import '../../view_model/board_view_model.dart';
import '../common/custom_ticker_provider.dart';

class CommunityBoardProvider extends ChangeNotifier {
  CommunityBoardProvider() : _tickerProvider = CustomTickerProvider() {
    _communityTabController = TabController(
        length: GlobalValueConstants.communityCategoryTypes.length,
        vsync: _tickerProvider);
    _scrollController.addListener(_onScroll);
  }

  bool _isFetching = false;
  String _selectedPostType = '';
  String _selectedOrderType = 'recent';
  String _lastNo = '-1';
  Pagination _communityPage = Pagination.empty();
  final ScrollController _scrollController = ScrollController();
  late TabController _communityTabController;
  final CustomTickerProvider _tickerProvider;
  final List<CommunityBoard> _communityBoardList = [];

  late BoardViewModel _viewModel;

  String get selectedPostType => _selectedPostType;

  String get selectedOrderType => _selectedOrderType;

  List<CommunityBoard> get communityBoardList => _communityBoardList;

  Pagination get communityPage => _communityPage;

  ScrollController get scrollController => _scrollController;

  TabController get communityTabController => _communityTabController;

  void setViewModel(BoardViewModel viewModel) {
    _viewModel = viewModel;
  }

  void updateOrderType(String newType) {
    _selectedOrderType = newType;
    notifyListeners();
  }

  void updatePostType(String newType) {
    _selectedPostType = newType;
    notifyListeners();
  }

  void addCommunityBoardList(List<CommunityBoard> addCommunityBoards) {
    _communityBoardList.addAll(addCommunityBoards);
    updateCommunityBoardListLastNo();
    notifyListeners();
  }

  void updateCommunityBoardList(List<CommunityBoard> addCommunityBoards) {
    _communityBoardList.clear();
    _communityBoardList.addAll(addCommunityBoards);
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
    updateCommunityBoardListLastNo();
    notifyListeners();
  }

  void updateCommunityBoardListPage(Pagination paging) {
    _communityPage = paging;
    notifyListeners();
  }

  void updateCommunityBoardListLastNo() {
    _lastNo = _communityBoardList.last.communityPostNo.toString();
    notifyListeners();
  }

  void resetFilter() {
    _selectedOrderType = 'recent';
    notifyListeners();
  }

  void _onScroll() {
    if (!_isFetching &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
      _fetchMoreData();
    }
  }

  Future<void> _fetchMoreData() async {
    _isFetching = true;
    await _viewModel.addCommunityBoardList(
        _selectedPostType, _selectedOrderType, null, null, null, _lastNo);
    _isFetching = false;
  }
}
