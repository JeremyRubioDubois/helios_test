import 'package:flutter/material.dart';
import 'package:helios_test/pages/user_list/user_list_presenter.dart';

class UserListPage extends StatefulWidget {
  final UserListPresenter presenter;

  const UserListPage({super.key, required this.presenter});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage>
    implements UserListDelegate {
  @override
  void initState() {
    super.initState();
    widget.presenter.init();
  }

  @override
  void dispose() {
    widget.presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.presenter.delegate = this;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        title: const Text('Utilisateurs'),
        actions: [
          IconButton(
            onPressed: () {
              return widget.presenter.goToUserAlgoPage(context: context);
            },
            icon: const Icon(Icons.local_shipping),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              autocorrect: false,
              autofocus: false,
              autofillHints: const [AutofillHints.name],
              controller: widget.presenter.searchController,
              onChanged: widget.presenter.search,
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).primaryColor,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                hintText: 'Rechercher un utilisateur',
                hintStyle: const TextStyle(fontSize: 14),
                suffixIcon:
                    widget.presenter.searchController.text.isNotEmpty
                        ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            widget.presenter.searchController.clear();
                            widget.presenter.clearSearch();
                          },
                        )
                        : null,

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(child: _buildUserList()),
        ],
      ),
    );
  }

  Widget _buildUserList() {
    if (widget.presenter.isLoading && widget.presenter.filteredUsers.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else if (widget.presenter.filteredUsers.isEmpty) {
      return const Center(child: Text('Aucun utilisateur trouvé'));
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (scroll) {
        if (scroll.metrics.pixels >= scroll.metrics.maxScrollExtent) {
          widget.presenter.onScrollEnd();
        }
        return false;
      },
      child: Stack(
        children: [
          ListView.builder(
            itemCount: widget.presenter.filteredUsers.length,
            itemBuilder: (context, index) {
              final user = widget.presenter.filteredUsers[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.pictureUrl),
                ),
                title: Text(user.fullName),
                onTap: () {
                  widget.presenter.goToUserDetailPage(
                    context: context,
                    user: user,
                  );
                },
              );
            },
          ),
          if (widget.presenter.isLoading)
            const Positioned(
              right: 32,
              bottom: 52,
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  @override
  void refreshView() {
    if (mounted) setState(() {});
  }
}
