import 'package:data/service/supabase_service.dart';
import 'package:domain/repository/memory_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:hello_flutter/presentation/base/base_viewmodel.dart';
import 'package:hello_flutter/presentation/feature/memory_details/route/memory_details_argument.dart';
import 'package:hello_flutter/presentation/util/value_notifier_list.dart';

class MemoryDetailsViewModel extends BaseViewModel<MemoryDetailsArgument> {
  final MemoryRepository memoryRepository;
  final SupabaseService supabaseService;

  final ValueNotifierList<String> _uploadedImages = ValueNotifierList([]);

  ValueNotifierList<String> get uploadedImages => _uploadedImages;

  final ValueNotifier<int?> _currentIndex = ValueNotifier(null);

  ValueListenable<int?> get currentIndex => _currentIndex;

  final ValueNotifier<int?> _initialIndex = ValueNotifier(null);

  ValueListenable<int?> get initialIndex => _initialIndex;

  MemoryDetailsViewModel({
    required this.memoryRepository,
    required this.supabaseService,
  });

  @override
  void onViewReady({MemoryDetailsArgument? argument}) {
    super.onViewReady();
    _initialIndex.value = argument!.initialIndex;
    _currentIndex.value = argument.initialIndex;
    fetchImages();
  }

  void onPageChanged(int index) {
    _currentIndex.value = index;
  }

  Future<void> fetchImages() async {
    final images = await loadData(memoryRepository.fetchImages());

    if (images.isNotEmpty) {
      final List<String> urls = images
          .where((file) => file.name != '.emptyFolderPlaceholder')
          .map((file) {
        return supabaseService.supabaseClient.storage
            .from('photos')
            .getPublicUrl(file.name);
      }).toList();

      _uploadedImages.value = urls;
    }
  }
}
