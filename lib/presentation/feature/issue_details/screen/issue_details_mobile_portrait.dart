import 'package:cached_network_image/cached_network_image.dart';
import 'package:evntas/presentation/base/base_ui_state.dart';
import 'package:evntas/presentation/feature/issue_details/issue_details_view_model.dart';
import 'package:evntas/presentation/feature/issue_details/widgets/comment_box.dart';
import 'package:evntas/presentation/theme/color/app_colors.dart';
import 'package:evntas/presentation/util/helper_function.dart';
import 'package:evntas/presentation/values/dimens.dart';
import 'package:flutter/material.dart';

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
      bottomNavigationBar: _buildCommentField(context),
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
      child: valueListenableBuilder(
        listenable: widget.viewModel.issue,
        builder: (context, value) => value == null
            ? const SizedBox.shrink()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildUserInfo(context),
                    SizedBox(height: Dimens.dimen_16),
                    _buildIssueDetails(context),
                    SizedBox(height: Dimens.dimen_8),
                    Divider(color: Colors.grey.shade400),
                    SizedBox(height: Dimens.dimen_8),
                    _buildCommentSection(context),
                    SizedBox(height: Dimens.dimen_8),
                  ],
                ),
              ),
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
        ),
        SizedBox(width: Dimens.dimen_4),
        valueListenableBuilder(
          listenable: widget.viewModel.issue,
          builder: (context, value) => Text(
            HelperFunction.timeAgo(value?.createdAt ?? DateTime.now()),
            style: Theme.of(context).textTheme.bodySmall,
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

  Widget _buildCommentSection(BuildContext context) {
    return valueListenableBuilder(
      listenable: widget.viewModel.comments,
      builder: (context, comments) {
        return valueListenableBuilder(
          listenable: widget.viewModel.users,
          builder: (context, users) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comments.isNotEmpty ? "Comments" : "Start a conversation",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              SizedBox(height: Dimens.dimen_8),
              comments.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        return CommentBox(
                          comment: comments[index],
                          user: users[index],
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: Dimens.dimen_16,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCommentField(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(Dimens.dimen_16),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: answerController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimens.dimen_8),
                  ),
                  hintText: "Enter your comment",
                ),
                minLines: 1,
                maxLines: 2,
                onTapOutside: (_) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
              ),
            ),
            SizedBox(height: Dimens.dimen_16),
            IconButton(
              onPressed: () {
                widget.viewModel
                    .saveComment(answerController.text, widget.issueId);
                answerController.clear();
              },
              icon: Icon(Icons.send, color: AppColors.of(context).mainColor),
            ),
          ],
        ),
      ),
    );
  }
}
