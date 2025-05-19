import 'package:evntas/presentation/feature/issue_list/widgets/issue_card_list_tile.dart';
import 'package:evntas/presentation/values/dimens.dart';
import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_ui_state.dart';
import 'package:evntas/presentation/feature/issue_list/issue_list_view_model.dart';

class IssueListMobilePortrait extends StatefulWidget {
  final IssueListViewModel viewModel;

  const IssueListMobilePortrait({required this.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => IssueListMobilePortraitState();
}

class IssueListMobilePortraitState
    extends BaseUiState<IssueListMobilePortrait> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _buildFloatingActionButton(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Issue List"),
      leading: IconButton(
        onPressed: () => widget.viewModel.onBackPressed(),
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => widget.viewModel.onAddIssueButtonClicked(),
      backgroundColor: Theme.of(context).colorScheme.primary,
      shape: const CircleBorder(),
      child: Icon(
        Icons.add,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return valueListenableBuilder(
      listenable: widget.viewModel.issues,
      builder: (context, value) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: Dimens.dimen_16,
            vertical: Dimens.dimen_16,
          ),
          child: ListView.separated(
            itemCount: value.length,
            itemBuilder: (context, index) => valueListenableBuilder(
              listenable: widget.viewModel.issueVotedByCurrentUser,
              builder: (context, issueVotedByCurrentUser) => IssueCardListTile(
                issue: value[index],
                isLiked: issueVotedByCurrentUser.any((issue) =>
                    issue.id == value[index].id && issue.isLiked == true),
                isDisliked: issueVotedByCurrentUser.any((issue) =>
                    issue.id == value[index].id && issue.isDisliked == true),
                onTap: (id) => widget.viewModel.onIssueClicked(id),
                onLikeTap: (index) => widget.viewModel.onLikeTap(index),
                onDislikeTap: (index) => widget.viewModel.onDislikeTap(index),
              ),
            ),
            separatorBuilder: (context, index) => SizedBox(
              height: Dimens.dimen_16,
            ),
          ),
        );
      },
    );
  }
}
