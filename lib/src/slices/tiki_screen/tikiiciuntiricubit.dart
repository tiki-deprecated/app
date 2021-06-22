/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

// class HomeCounterCubit extends Cubit<HomeCounterState> {
//   final RepoApiWebsiteUsers _repoApiWebsiteUsers;
//
//   HomeCounterCubit(this._repoApiWebsiteUsers) : super(HomeCounterInitial(0));
//
//   HomeCounterCubit.provide(BuildContext context)
//       : _repoApiWebsiteUsers =
//             RepositoryProvider.of<RepoApiWebsiteUsers>(context),
//         super(HomeCounterInitial(0));
//
//   Future<void> update() async {
//     HelperApiRsp<RepoApiWebsiteUsersRsp> apiRsp =
//         await _repoApiWebsiteUsers.total();
//     if (apiRsp.code == 200) {
//       RepoApiWebsiteUsersRsp rsp = apiRsp.data;
//       emit(HomeCounterSuccess(rsp.total));
//     } else
//       emit(HomeCounterFailure(state.count));
//   }
// }
