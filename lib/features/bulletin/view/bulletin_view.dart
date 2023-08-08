import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:academix/components/custom_material_icon_button.dart';
import 'package:academix/configs/themes/colors/dark_theme_colors.dart';
import 'package:academix/configs/themes/colors/light_theme_colors.dart';
import 'package:academix/configs/themes/colors/mirage_theme_colors.dart';
import 'package:academix/configs/themes/provider/theme_options.dart';
import 'package:academix/configs/themes/provider/theme_provider.dart';
import 'package:academix/configs/themes/styles/button_style.dart';
import 'package:academix/constants/image_placeholder.dart';
import 'package:academix/features/authentication/sign_in/widgets/authenticating_spinner_widget.dart';
import 'package:academix/features/bulletin/helper/select_images_web_helper.dart';
import 'package:academix/features/bulletin/services/bulletin_update_services.dart';

class BulletinView extends ConsumerStatefulWidget {
  const BulletinView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BulletinViewState();
}

class _BulletinViewState extends ConsumerState<BulletinView> {
  CollectionReference users = FirebaseFirestore.instance.collection('students');

  final isControllersEmpty = StateProvider<bool>((ref) => true);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController descriptionController;
  late final TextEditingController titleController;

  final selectedImagesStateProvider =
      StateProvider<List<Uint8List>>((ref) => []);

  final resultStateProvider = StateProvider<FilePickerResult?>((ref) => null);

  final isUploadingStateProvider = StateProvider<bool>((ref) => false);

  @override
  void initState() {
    super.initState();
    descriptionController = TextEditingController();
    titleController = TextEditingController();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeStateProvider);

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Expanded(
              child: Center(child: Text("SOMETING WENT WRONG")));
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Expanded(
              child: Center(child: Text("CANT FIND DOCUMENT")));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: bulletinPadding(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'WELCOME TO CAMPUS BULLETIN',
                          textScaleFactor:
                              MediaQuery.of(context).size.width >= 1080
                                  ? 1.5
                                  : 1,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Visibility(
                          visible: MediaQuery.of(context).size.width >= 1080
                              ? true
                              : false,
                          replacement: IconButton(
                            splashRadius: 15,
                            icon: Icon(
                              Icons.add_box,
                              color: themeState == ThemeOptions.darkTheme
                                  ? DarkThemeColors.foregroundSecondColor
                                  : themeState == ThemeOptions.mirageTheme
                                      ? MirageThemeColors.foregroundSecondColor
                                      : LightThemeColors.foregroundSecondColor,
                            ),
                            onPressed: () async =>
                                createBulletinUpdateDialogWidget(
                                    context, data, themeState),
                          ),
                          child: ElevatedButton.icon(
                            style:
                                elevatedButtonStyle(ref: ref, buttonHeight: 45),
                            label: const Text('Create'),
                            icon: const Icon(
                              FluentIcons.add_12_regular,
                            ),
                            onPressed: () async =>
                                createBulletinUpdateDialogWidget(
                                    context, data, themeState),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: PinnedNewsStream(
                        themeState: themeState,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Latest Updates',
                          textScaleFactor: 2,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('See all'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: LatestUpdateStream(
                        themeState: themeState,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const Expanded(child: Center(child: Text("LOADING...")));
      },
    );
  }

  EdgeInsets bulletinPadding() {
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    if (mediaQueryWidth >= 1080) {
      return const EdgeInsets.only(
        left: 50,
        right: 50,
        top: 20,
      );
    } else if (mediaQueryWidth >= 480 && mediaQueryWidth <= 1080) {
      return const EdgeInsets.only(
        left: 40,
        right: 40,
        top: 0,
      );
    } else {
      return const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 0,
      );
    }
  }

  Future<dynamic> createBulletinUpdateDialogWidget(
      BuildContext context, Map<String, dynamic> data, String themeState) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          width: MediaQuery.of(context).size.width * 0.5,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Image.network(
                          'https://i.redd.it/6j35ora2u8g51.png',
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            FirebaseAuth.instance.currentUser!.displayName
                                .toString(),
                            textScaleFactor: 1.1,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            data['college'],
                            textScaleFactor: 0.9,
                            style: TextStyle(
                              color: themeState == ThemeOptions.darkTheme
                                  ? DarkThemeColors.foregroundSecondColor
                                  : themeState == ThemeOptions.mirageTheme
                                      ? MirageThemeColors.foregroundSecondColor
                                      : LightThemeColors.foregroundSecondColor,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.topCenter,
                        child: customMaterialIconButton(
                          ref: ref,
                          themeState: themeState,
                          onPressed: () => context.pop(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    onChanged: isCreateNewsControllersEmptyFunction,
                    child: Column(
                      children: [
                        CustomCreateUpdateTextFormFieldWidget(
                          minLines: 1,
                          maxLines: 2,
                          hint: 'Title......',
                          themeState: themeState,
                          controller: titleController,
                        ),
                        const SizedBox(height: 10),
                        CustomCreateUpdateTextFormFieldWidget(
                          themeState: themeState,
                          hint: 'Description......',
                          controller: descriptionController,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Consumer(
                    builder: (context, ref, child) {
                      return ref.watch(selectedImagesStateProvider).isEmpty
                          ? Container()
                          : CustomImageGridViewWidget(
                              ref: ref,
                              selectedImagesProvider:
                                  selectedImagesStateProvider,
                            );
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('Add Media'),
                          customMaterialIconButton(
                            ref: ref,
                            themeState: themeState,
                            iconData: FluentIcons.image_add_20_regular,
                            onPressed: () async => selectImagesWebHelper(
                              ref: ref,
                              selectedImagesStateProvider:
                                  selectedImagesStateProvider,
                              resultStateProvider: resultStateProvider,
                            ),
                          )
                        ],
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          if (ref.watch(isControllersEmpty)) {
                            return disabledUploadButtonWidget(ref)
                                .animate()
                                .fadeIn()
                                .slide();
                          } else {
                            if (ref.watch(isUploadingStateProvider)) {
                              return AuthenticatingSpinnerWidget(
                                themeState: themeState,
                              );
                            } else {
                              return activeUploadButtonWidget(ref, context)
                                  .animate()
                                  .fadeIn()
                                  .slideY(begin: 0.5)
                                  .then()
                                  .shake();
                            }
                          }
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  RepaintBoundary disabledUploadButtonWidget(WidgetRef ref) {
    return RepaintBoundary(
      child: ElevatedButton(
        style: elevatedButtonStyle(ref: ref),
        onPressed: null,
        child: const Text('Upload News'),
      ),
    );
  }

  RepaintBoundary activeUploadButtonWidget(
      WidgetRef ref, BuildContext context) {
    return RepaintBoundary(
      child: ElevatedButton(
        style: elevatedButtonStyle(ref: ref),
        onPressed: () async {
          if (kIsWeb && ref.read(selectedImagesStateProvider).isNotEmpty) {
            await uploadUpdateWithImagesWebFunction(ref, context);
          } else {
            await uploadUpdateWithoutImagesFunction(ref, context);
          }
        },
        child: const Text('Upload'),
      ),
    );
  }

  Future<void> uploadUpdateWithoutImagesFunction(
      WidgetRef ref, BuildContext context) async {
    ref.read(isUploadingStateProvider.notifier).update((state) => true);
    await UploadBulletinUpdate()
        .uploadNewsWithoutImages(
          creatorName:
              FirebaseAuth.instance.currentUser!.displayName.toString(),
          title: titleController.value.text,
          description: descriptionController.value.text,
          context: context,
          ref: ref,
        )
        .whenComplete(() => {
              ref
                  .read(isUploadingStateProvider.notifier)
                  .update((state) => false),
              titleController.clear(),
              descriptionController.clear(),
              ref.invalidate(selectedImagesStateProvider),
              context.pop(),
            });
  }

  Future<void> uploadUpdateWithImagesWebFunction(
      WidgetRef ref, BuildContext context) async {
    ref.read(isUploadingStateProvider.notifier).update((state) => true);
    await UploadBulletinUpdate()
        .uploadUpdateWithImagesWeb(
          listOfImagesWeb: ref.read(selectedImagesStateProvider),
          result: ref.read(resultStateProvider),
          creatorName:
              FirebaseAuth.instance.currentUser!.displayName.toString(),
          title: titleController.value.text,
          description: descriptionController.value.text,
          context: context,
          ref: ref,
        )
        .whenComplete(() => {
              ref
                  .read(isUploadingStateProvider.notifier)
                  .update((state) => false),
              titleController.clear(),
              descriptionController.clear(),
              ref.invalidate(selectedImagesStateProvider),
              context.pop(),
            });
  }

  void isCreateNewsControllersEmptyFunction() {
    if (titleController.value.text.isNotEmpty &&
        descriptionController.value.text.isNotEmpty) {
      ref.read(isControllersEmpty.notifier).update((state) => false);
    } else {
      ref.read(isControllersEmpty.notifier).update((state) => true);
    }
  }
}

Widget buildGridView({required selectedImagesStateProvider}) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
    ),
    itemCount: selectedImagesStateProvider.length,
    itemBuilder: (context, index) {
      return Image.file(
        selectedImagesStateProvider[index],
        fit: BoxFit.cover,
      );
    },
  );
}

class CustomImageGridViewWidget extends StatelessWidget {
  const CustomImageGridViewWidget({
    Key? key,
    required this.selectedImagesProvider,
    required this.ref,
  }) : super(key: key);

  final StateProvider<List<Uint8List>> selectedImagesProvider;

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
        itemCount: ref.read(selectedImagesProvider).length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.memory(
              ref.read(selectedImagesProvider)[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}

class CustomCreateUpdateTextFormFieldWidget extends StatelessWidget {
  const CustomCreateUpdateTextFormFieldWidget({
    Key? key,
    required this.controller,
    required this.themeState,
    required this.hint,
    this.minLines,
    this.maxLines,
  }) : super(key: key);

  final TextEditingController controller;
  final String themeState;
  final String hint;
  final int? minLines;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: false,
      autocorrect: false,
      minLines: minLines ?? 10,
      maxLines: maxLines ?? 30,
      cursorRadius: const Radius.circular(5.0),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: themeState == ThemeOptions.darkTheme
              ? DarkThemeColors.foregroundColor.withAlpha(150)
              : themeState == ThemeOptions.mirageTheme
                  ? MirageThemeColors.foregroundColor.withAlpha(150)
                  : LightThemeColors.foregroundColor.withAlpha(150),
        ),
        filled: true,
        fillColor: themeState == ThemeOptions.darkTheme
            ? DarkThemeColors.buttonBackgroundColor
            : themeState == ThemeOptions.mirageTheme
                ? MirageThemeColors.buttonBackgroundColor
                : LightThemeColors.buttonBackgroundColor,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyle(
        color: themeState == ThemeOptions.darkTheme
            ? DarkThemeColors.foregroundColor
            : themeState == ThemeOptions.mirageTheme
                ? MirageThemeColors.foregroundColor
                : LightThemeColors.foregroundColor,
      ),
      cursorColor: themeState == ThemeOptions.darkTheme
          ? DarkThemeColors.foregroundColor
          : themeState == ThemeOptions.mirageTheme
              ? MirageThemeColors.foregroundColor
              : LightThemeColors.foregroundColor,
    );
  }
}

class PinnedNewsStream extends ConsumerStatefulWidget {
  const PinnedNewsStream({
    super.key,
    required this.themeState,
  });

  final String themeState;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => PinNewsStreamState();
}

class PinNewsStreamState extends ConsumerState<PinnedNewsStream> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('bulletin-update')
      .where('is-pinned', isEqualTo: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        final List<QueryDocumentSnapshot<Object?>> data = snapshot.data!.docs;
        return FlutterCarousel(
          options: CarouselOptions(
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            autoPlay: true,
            showIndicator: false,
            autoPlayInterval: const Duration(seconds: 10),
          ),
          items: data.map((mapData) {
            if (MediaQuery.of(context).size.width >= 1080) {
              return DesktopPinnedCard(
                data: mapData,
                themeState: widget.themeState,
              );
            } else {
              return TabletPinnedCard(
                data: mapData,
                themeState: widget.themeState,
              );
            }
          }).toList(),
        );
      },
    );
  }
}

class DesktopPinnedCard extends StatelessWidget {
  const DesktopPinnedCard({
    Key? key,
    required this.data,
    required this.themeState,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> data;
  final String themeState;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: data['image-url'].isEmpty
                  ? ImagePlaceholder.network
                  : data['image-url'][0],
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.3,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  LinearProgressIndicator(
                value: downloadProgress.progress,
              ),
              errorWidget: (context, url, error) =>
                  const Icon(FluentIcons.error_circle_12_regular),
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text(
                        data['created-by'],
                        textScaleFactor: 1.2,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      ClipOval(
                        child: Container(
                          width: 5,
                          height: 5,
                          color: themeState == ThemeOptions.darkTheme
                              ? DarkThemeColors.foregroundColor
                              : themeState == ThemeOptions.mirageTheme
                                  ? MirageThemeColors.foregroundColor
                                  : LightThemeColors.foregroundColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        timeago.format(data['created-time'].toDate()),
                        style: TextStyle(
                          color: themeState == ThemeOptions.darkTheme
                              ? DarkThemeColors.foregroundSecondColor
                              : themeState == ThemeOptions.mirageTheme
                                  ? MirageThemeColors.foregroundSecondColor
                                  : LightThemeColors.foregroundSecondColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    data['title'],
                    textScaleFactor: 3,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    data['description'],
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}

class TabletPinnedCard extends StatelessWidget {
  const TabletPinnedCard({
    Key? key,
    required this.data,
    required this.themeState,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> data;
  final String themeState;

  @override
  Widget build(BuildContext context) {
    TextStyle textStye = const TextStyle(
      color: Colors.white,
    );
    return Builder(
      builder: (context) {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: data['image-url'].isEmpty
                    ? ImagePlaceholder.network
                    : data['image-url'][0],
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    LinearProgressIndicator(
                  value: downloadProgress.progress,
                ),
                errorWidget: (context, url, error) =>
                    const Icon(FluentIcons.error_circle_12_regular),
                fit: BoxFit.cover,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                color: Colors.black45,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data['title'],
                    textScaleFactor: 2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: textStye,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    data['description'],
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: textStye,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    data['created-by'],
                    style: const TextStyle(color: Colors.white70),
                  ),
                  Text(
                    timeago.format(data['created-time'].toDate()),
                    textScaleFactor: 0.8,
                    style: const TextStyle(color: Colors.white54),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class LatestUpdateStream extends ConsumerStatefulWidget {
  const LatestUpdateStream({
    super.key,
    required this.themeState,
  });

  final String themeState;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      LatestUpdateStreamState();
}

class LatestUpdateStreamState extends ConsumerState<LatestUpdateStream> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('bulletin-update')
          .limit(8)
          .orderBy('created-time', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        final data = snapshot.data!.docs;

        final Size mediaQuerySize = MediaQuery.of(context).size;
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: mediaQuerySize.width > 1700
                ? 4
                : mediaQuerySize.width < 1700 && mediaQuerySize.width >= 1400
                    ? 3
                    : 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: data.length,
          itemBuilder: (context, index) {
            if (data[index]['image-url'].isNotEmpty) {
              return GridViewChildWidget(
                index: index,
                data: data,
                widget: widget,
              );
            } else {
              return GridViewChildWidget(
                index: index,
                data: data,
                widget: widget,
                alternativeImageUrl: ImagePlaceholder.network,
              );
            }
          },
        );
      },
    );
  }
}

class GridViewChildWidget extends StatelessWidget {
  const GridViewChildWidget({
    Key? key,
    required this.data,
    required this.widget,
    required this.index,
    this.alternativeImageUrl,
  }) : super(key: key);

  final List<QueryDocumentSnapshot<Object?>> data;
  final LatestUpdateStream widget;
  final int index;
  final String? alternativeImageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 180,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              imageUrl: alternativeImageUrl ?? data[index]['image-url'][0],
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  LinearProgressIndicator(
                value: downloadProgress.progress,
              ),
              errorWidget: (context, url, error) =>
                  const Icon(FluentIcons.error_circle_12_regular),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          data[index]['created-by'],
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            height: 0.8,
          ),
        ),
        Text(
          timeago.format(data[index]['created-time'].toDate()),
          style: TextStyle(
            color: widget.themeState == ThemeOptions.darkTheme
                ? DarkThemeColors.foregroundSecondColor
                : widget.themeState == ThemeOptions.mirageTheme
                    ? MirageThemeColors.foregroundSecondColor
                    : LightThemeColors.foregroundSecondColor,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          data[index]['title'],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(height: 5),
        Text(
          data[index]['description'],
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
