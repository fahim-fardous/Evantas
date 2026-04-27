import 'package:cached_network_image/cached_network_image.dart';
import 'package:evntas/presentation/base/base_ui_state.dart';
import 'package:evntas/presentation/feature/issue_details/issue_details_view_model.dart';
import 'package:evntas/presentation/feature/issue_details/widgets/comment_box.dart';
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
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      bottomNavigationBar: _buildCommentField(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 0,
      centerTitle: true,
      title: Text("Issue Details",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              )),
      leading: IconButton(
        onPressed: () => widget.viewModel.onBackPressed(),
        icon: Icon(Icons.arrow_back,
            color: Theme.of(context).colorScheme.primary),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: valueListenableBuilder(
        listenable: widget.viewModel.issue,
        builder: (context, issue) => issue == null
            ? _buildDetailsLoadingPlaceholder(context)
            : issue.id != widget.issueId
                ? _buildDetailsLoadingPlaceholder(context)
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(
                  Dimens.dimen_16,
                  Dimens.dimen_16,
                  Dimens.dimen_16,
                  Dimens.dimen_24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderCard(context),
                    SizedBox(height: Dimens.dimen_16),
                    _buildCommentSection(context),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildDetailsLoadingPlaceholder(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimens.dimen_16),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(Dimens.dimen_16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(Dimens.dimen_12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(Dimens.dimen_1 / Dimens.dimen_8),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: Dimens.dimen_36,
                  height: Dimens.dimen_36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary.withOpacity(
                          Dimens.dimen_1 / Dimens.dimen_10,
                        ),
                  ),
                ),
                SizedBox(width: Dimens.dimen_8),
                Container(
                  width: Dimens.dimen_120,
                  height: Dimens.dimen_16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.dimen_8),
                    color: Theme.of(context).colorScheme.primary.withOpacity(
                          Dimens.dimen_1 / Dimens.dimen_10,
                        ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimens.dimen_16),
            Container(
              width: double.infinity,
              height: Dimens.dimen_24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimens.dimen_8),
                color: Theme.of(context).colorScheme.primary.withOpacity(
                      Dimens.dimen_1 / Dimens.dimen_10,
                    ),
              ),
            ),
            SizedBox(height: Dimens.dimen_8),
            Container(
              width: double.infinity,
              height: Dimens.dimen_16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimens.dimen_8),
                color: Theme.of(context).colorScheme.primary.withOpacity(
                      Dimens.dimen_1 / Dimens.dimen_10,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Dimens.dimen_16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(Dimens.dimen_12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(Dimens.dimen_1 / Dimens.dimen_5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserInfo(context),
          SizedBox(height: Dimens.dimen_16),
          _buildIssueDetails(context),
        ],
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        valueListenableBuilder(
          listenable: widget.viewModel.isCreatorLoading,
          builder: (context, isCreatorLoading) => valueListenableBuilder(
            listenable: widget.viewModel.userData,
            builder: (context, value) => isCreatorLoading
                ? Container(
                    width: Dimens.dimen_36,
                    height: Dimens.dimen_36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primary.withOpacity(
                            Dimens.dimen_1 / Dimens.dimen_10,
                          ),
                    ),
                  )
                : value?.photoUrl != null && value!.photoUrl.isNotEmpty
                    ? ClipOval(
                        child: CachedNetworkImage(
                          width: Dimens.dimen_36,
                          height: Dimens.dimen_36,
                          imageUrl: value.photoUrl,
                          fit: BoxFit.cover,
                        ),
                      )
                    : CircleAvatar(
                        radius: Dimens.dimen_18,
                        backgroundColor:
                            Theme.of(context).colorScheme.primary.withOpacity(
                                  Dimens.dimen_1 / Dimens.dimen_10,
                                ),
                        child: Icon(
                          Icons.person,
                          color: Theme.of(context).colorScheme.primary,
                          size: Dimens.dimen_20,
                        ),
                      ),
          ),
        ),
        SizedBox(width: Dimens.dimen_8),
        valueListenableBuilder(
          listenable: widget.viewModel.isCreatorLoading,
          builder: (context, isCreatorLoading) => valueListenableBuilder(
            listenable: widget.viewModel.userData,
            builder: (context, userValue) => isCreatorLoading
                ? Container(
                    width: Dimens.dimen_120,
                    height: Dimens.dimen_16,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(
                            Dimens.dimen_1 / Dimens.dimen_10,
                          ),
                      borderRadius: BorderRadius.circular(Dimens.dimen_8),
                    ),
                  )
                : Text(
                    _creatorDisplayName(userValue?.name),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
          ),
        ),
        SizedBox(width: Dimens.dimen_4),
        Text(
          ".",
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        SizedBox(width: Dimens.dimen_4),
        valueListenableBuilder(
          listenable: widget.viewModel.issue,
          builder: (context, value) => Text(
            HelperFunction.timeAgo(value?.createdAt ?? DateTime.now()),
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
      ],
    );
  }

  String _creatorDisplayName(String? userName) {
    final cleanedName = userName?.trim() ?? "";
    if (cleanedName.isNotEmpty) {
      return cleanedName;
    }
    return "Unknown";
  }

  Widget _buildIssueDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        valueListenableBuilder(
          listenable: widget.viewModel.issue,
          builder: (context, value) => Text(
            value?.title ?? "",
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        SizedBox(height: Dimens.dimen_8),
        valueListenableBuilder(
          listenable: widget.viewModel.issue,
          builder: (context, value) => Text(
            value?.description ?? "",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
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
          builder: (context, users) {
            final visibleCommentCount =
                comments.length < users.length ? comments.length : users.length;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comments.isNotEmpty ? "Comments" : "Start a conversation",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: Dimens.dimen_8),
                visibleCommentCount > 0
                    ? ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: visibleCommentCount,
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
                    : Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(Dimens.dimen_16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(Dimens.dimen_12),
                          border: Border.all(
                            color:
                                Theme.of(context).colorScheme.primary.withOpacity(
                                      Dimens.dimen_1 / Dimens.dimen_10,
                                    ),
                          ),
                        ),
                        child: Text(
                          comments.isEmpty
                              ? "Be the first one to comment on this issue."
                              : "Comments are loading, please wait.",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onBackground,
                                  ),
                        ),
                      ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildCommentField(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          Dimens.dimen_16,
          Dimens.dimen_8,
          Dimens.dimen_16,
          Dimens.dimen_16,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextField(
                controller: answerController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimens.dimen_8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimens.dimen_8),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary.withOpacity(
                            Dimens.dimen_1 / Dimens.dimen_5,
                          ),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimens.dimen_8),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  hintText: "Enter your comment",
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                minLines: 1,
                maxLines: 2,
                onTapOutside: (_) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
              ),
            ),
            SizedBox(width: Dimens.dimen_8),
            IconButton(
              onPressed: () {
                widget.viewModel
                    .saveComment(answerController.text, widget.issueId);
                answerController.clear();
              },
              icon: Icon(
                Icons.send,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
