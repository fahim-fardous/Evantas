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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: _buildAppBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _buildFloatingActionButton(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 0,
      centerTitle: true,
      title: Text("Issue List",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              )),
      leading: IconButton(
        onPressed: () => widget.viewModel.onBackPressed(),
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).colorScheme.primary,
        ),
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
    return SafeArea(
      child: valueListenableBuilder(
        listenable: widget.viewModel.issueVotedByCurrentUser,
        builder: (context, issueVotedByCurrentUser) {
          return valueListenableBuilder(
            listenable: widget.viewModel.issues,
            builder: (context, issues) {
              if (issues.isEmpty) {
                return _buildEmptyState(context);
              }

              return ListView.separated(
                padding: EdgeInsets.fromLTRB(
                  Dimens.dimen_16,
                  Dimens.dimen_16,
                  Dimens.dimen_16,
                  Dimens.dimen_80,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: issues.length,
                itemBuilder: (context, index) {
                  final issue = issues[index];
                  return IssueCardListTile(
                    issue: issue,
                    isLiked: issueVotedByCurrentUser.any((votedIssue) =>
                        votedIssue.id == issue.id && votedIssue.isLiked == true),
                    isDisliked: issueVotedByCurrentUser.any((votedIssue) =>
                        votedIssue.id == issue.id &&
                        votedIssue.isDisliked == true),
                    onTap: (id) => widget.viewModel.onIssueClicked(id),
                    onLikeTap: (id) => widget.viewModel.onLikeTap(id),
                    onDislikeTap: (id) => widget.viewModel.onDislikeTap(id),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: Dimens.dimen_16,
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimens.dimen_24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.inbox_outlined,
              color: Theme.of(context).colorScheme.primary,
              size: Dimens.dimen_48,
            ),
            SizedBox(height: Dimens.dimen_12),
            Text(
              "No issues yet",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            SizedBox(height: Dimens.dimen_8),
            Text(
              "Tap + to add the first issue.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
