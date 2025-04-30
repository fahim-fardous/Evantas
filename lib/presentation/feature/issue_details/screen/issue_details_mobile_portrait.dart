import 'package:cached_network_image/cached_network_image.dart';
import 'package:evntas/presentation/common/widget/outlined_text_field.dart';
import 'package:evntas/presentation/common/widget/primary_button.dart';
import 'package:evntas/presentation/feature/issue_details/widgets/comment_box.dart';
import 'package:evntas/presentation/feature/issue_details/widgets/share_button.dart';
import 'package:evntas/presentation/feature/issue_details/widgets/vote_box.dart';
import 'package:evntas/presentation/util/helper_function.dart';
import 'package:evntas/presentation/values/dimens.dart';
import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_ui_state.dart';
import 'package:evntas/presentation/feature/issue_details/issue_details_view_model.dart';

class IssueDetailsMobilePortrait extends StatefulWidget {
  final IssueDetailsViewModel viewModel;
  final int issueId;

  const IssueDetailsMobilePortrait({
    required this.viewModel,
    super.key,
    required this.issueId,
  });

  @override
  State<StatefulWidget> createState() => IssueDetailsMobilePortraitState();
}

class IssueDetailsMobilePortraitState
    extends BaseUiState<IssueDetailsMobilePortrait> {
  final answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Issue Details"),
      leading: IconButton(
        onPressed: () => widget.viewModel.onBackPressed(),
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.dimen_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserInfo(context),
          SizedBox(height: Dimens.dimen_16),
          _buildIssueDetails(context),
          SizedBox(height: Dimens.dimen_16),
          _buildVoteAndComment(context),
        ],
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        valueListenableBuilder(
          listenable: widget.viewModel.userData,
          builder: (context, value) => value?.photoUrl != null
              ? ClipOval(
                  child: CachedNetworkImage(
                    width: Dimens.dimen_36,
                    height: Dimens.dimen_36,
                    imageUrl: value?.photoUrl ?? "",
                    fit: BoxFit.cover,
                  ),
                )
              : Container(),
        ),
        SizedBox(width: Dimens.dimen_8),
        valueListenableBuilder(
          listenable: widget.viewModel.userData,
          builder: (context, value) => Text(
            value?.name.split(" ").first ?? "",
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        SizedBox(width: Dimens.dimen_4),
        Text(
          ".",
          style: Theme.of(context).textTheme.labelMedium,
          textAlign: TextAlign.start,
        ),
        SizedBox(width: Dimens.dimen_4),
        valueListenableBuilder(
          listenable: widget.viewModel.issue,
          builder: (context, value) => Text(
            HelperFunction.timeAgo(value?.createdAt ?? DateTime.now()),
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }

  Widget _buildIssueDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        valueListenableBuilder(
          listenable: widget.viewModel.issue,
          builder: (context, value) => Text(
            value?.title ?? "",
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        SizedBox(height: Dimens.dimen_8),
        valueListenableBuilder(
          listenable: widget.viewModel.issue,
          builder: (context, value) => Text(
            value?.description ?? "",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildVoteAndComment(BuildContext context) {
    return Row(
      children: [
        VoteBox(vote: 12),
        SizedBox(width: Dimens.dimen_12),
        CommentBox(commentCount: 12),
        SizedBox(width: Dimens.dimen_16),
        ShareButton(),
      ],
    );
  }
}
