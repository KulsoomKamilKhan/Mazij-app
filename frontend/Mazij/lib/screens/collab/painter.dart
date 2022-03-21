import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:Mazaj/data/models/collab_model.dart';
import 'package:Mazaj/data/models/library_model.dart';
import 'package:Mazaj/data/models/post_model.dart';
import 'package:Mazaj/data/models/user_model.dart';
import 'package:Mazaj/data/repositories/collab_repo.dart';
import 'package:Mazaj/data/repositories/post_repo.dart';
import 'package:Mazaj/data/repositories/profile_repo.dart';
import 'package:Mazaj/data/repositories/user_repo.dart';
import 'package:Mazaj/screens/posts/create_posts.dart';
import 'package:Mazaj/screens/posts/create_posts_collab.dart';
import 'package:Mazaj/screens/search/search_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_painter/flutter_painter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:file_saver/file_saver.dart';

late PainterController controller;
ui.Image? backgroundImage;

class FlutterPainterExample extends StatefulWidget {
  const FlutterPainterExample({Key? key}) : super(key: key);

  @override
  _FlutterPainterExampleState createState() => _FlutterPainterExampleState();
}

class _FlutterPainterExampleState extends State<FlutterPainterExample> {
  static const Color red = Color(0xFFFF0000);
  FocusNode textFocusNode = FocusNode();
  // late PainterController controller;
  // ui.Image? backgroundImage;
  Paint shapePaint = Paint()
    ..strokeWidth = 5
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  String img = ''; //default img
  final UserRepository _userRepository = UserRepository();
  final PostRepository _postRepository = PostRepository();
  final CollabRepository collabrepo = CollabRepository();

  var storage = const FlutterSecureStorage();

  // add stickers here
  static const List<String> imageLinks = [
    "https://assets.website-files.com/5e51c674258ffe10d286d30a/5e535800e35d38d2f1674cab_peep-54.png",
    "https://cdn-icons-png.flaticon.com/512/6028/6028631.png",
    "https://cdn-icons-png.flaticon.com/256/6028/6028602.png",
    "https://cdn-icons-png.flaticon.com/256/6028/6028584.png",
    "https://cdn-icons-png.flaticon.com/256/6028/6028668.png",
    "https://cdn-icons-png.flaticon.com/256/6028/6028722.png",
    "https://cdn-icons-png.flaticon.com/256/6028/6028744.png",
    "https://cdn-icons-png.flaticon.com/256/6028/6028768.png",
    "https://cdn-icons-png.flaticon.com/256/6028/6028545.png",
    "https://cdn-icons-png.flaticon.com/256/6028/6028779.png",
    "https://cdn-icons-png.flaticon.com/256/6028/6028775.png",
    "https://cdn-icons-png.flaticon.com/512/4105/4105443.png",
    "https://cdn-icons-png.flaticon.com/512/4359/4359757.png",
    "https://cdn-icons-png.flaticon.com/512/4383/4383912.png",
    "https://cdn-icons-png.flaticon.com/512/4383/4383923.png",
    "https://cdn-icons-png.flaticon.com/512/4383/4383917.png",
    "https://cdn-icons-png.flaticon.com/512/4193/4193251.png",
    "https://cdn-icons-png.flaticon.com/512/4193/4193256.png",
    "https://cdn-icons-png.flaticon.com/512/4193/4193303.png",
    "https://cdn-icons-png.flaticon.com/512/4193/4193308.png",
    "https://cdn-icons-png.flaticon.com/512/4193/4193315.png",
    "https://cdn-icons-png.flaticon.com/512/4193/4193351.png",
    "https://cdn-icons-png.flaticon.com/512/4359/4359706.png",
    "https://cdn-icons-png.flaticon.com/512/4383/4383823.png",
    "https://cdn-icons-png.flaticon.com/512/4383/4383819.png",
    "https://cdn-icons-png.flaticon.com/512/4383/4383844.png",
    "https://cdn-icons-png.flaticon.com/512/4228/4228682.png",
    "https://cdn-icons-png.flaticon.com/512/4228/4228714.png",
    "https://cdn-icons-png.flaticon.com/512/4228/4228693.png",
    "https://cdn-icons-png.flaticon.com/512/4359/4359681.png",
    "https://cdn-icons-png.flaticon.com/512/4359/4359618.png",
    "https://cdn-icons-png.flaticon.com/512/4359/4359857.png",
    "https://cdn-icons-png.flaticon.com/512/4651/4651962.png",
    "https://cdn-icons-png.flaticon.com/512/4651/4651965.png",
    "https://cdn-icons-png.flaticon.com/512/4392/4392461.png",
    "https://cdn-icons-png.flaticon.com/512/4392/4392479.png",
    "https://cdn-icons-png.flaticon.com/512/4392/4392494.png",
    "https://cdn-icons-png.flaticon.com/512/4228/4228711.png",
    "https://cdn-icons-png.flaticon.com/512/4359/4359754.png",
    "https://cdn-icons-png.flaticon.com/512/4433/4433215.png",
    "https://cdn-icons-png.flaticon.com/512/4433/4433218.png",
    "https://cdn-icons-png.flaticon.com/512/4433/4433224.png",
    "https://cdn-icons-png.flaticon.com/512/4433/4433227.png",
    "https://cdn-icons-png.flaticon.com/512/4433/4433231.png",
    "https://cdn-icons-png.flaticon.com/512/4433/4433235.png",
    "https://cdn-icons-png.flaticon.com/512/4433/4433249.png",
    "https://cdn-icons-png.flaticon.com/512/4433/4433265.png",
    //months
    "https://cdn-icons-png.flaticon.com/512/4213/4213605.png",
    "https://cdn-icons-png.flaticon.com/512/4213/4213612.png",
    "https://cdn-icons-png.flaticon.com/512/4213/4213512.png",
    "https://cdn-icons-png.flaticon.com/512/4213/4213515.png",
    "https://cdn-icons-png.flaticon.com/512/4213/4213517.png",
    "https://cdn-icons-png.flaticon.com/512/4213/4213521.png",
    "https://cdn-icons-png.flaticon.com/512/4213/4213526.png",
    "https://cdn-icons-png.flaticon.com/512/4213/4213529.png",
    "https://cdn-icons-png.flaticon.com/512/4213/4213536.png",
    "https://cdn-icons-png.flaticon.com/512/4213/4213540.png",
    "https://cdn-icons-png.flaticon.com/512/4213/4213546.png",
    "https://cdn-icons-png.flaticon.com/512/4213/4213551.png",
    //days
    "https://cdn-icons-png.flaticon.com/512/4213/4213558.png",
    "https://cdn-icons-png.flaticon.com/512/4213/4213580.png",
    "https://cdn-icons-png.flaticon.com/512/4213/4213584.png",
    "https://cdn-icons-png.flaticon.com/512/4213/4213588.png",
    "https://cdn-icons-png.flaticon.com/512/4213/4213596.png",
    "https://cdn-icons-png.flaticon.com/512/4213/4213600.png",
    "https://cdn-icons-png.flaticon.com/512/4213/4213602.png",
    //summer
    "https://cdn-icons-png.flaticon.com/512/4497/4497627.png",
    "https://cdn-icons-png.flaticon.com/512/4497/4497520.png",
    "https://cdn-icons-png.flaticon.com/512/4497/4497528.png",
    "https://cdn-icons-png.flaticon.com/512/4497/4497537.png",
    "https://cdn-icons-png.flaticon.com/512/4497/4497541.png",
    "https://cdn-icons-png.flaticon.com/512/4497/4497547.png",
    "https://cdn-icons-png.flaticon.com/512/4497/4497554.png",
    "https://cdn-icons-png.flaticon.com/512/4497/4497569.png",
    "https://cdn-icons-png.flaticon.com/512/4497/4497582.png",
    "https://cdn-icons-png.flaticon.com/512/4497/4497599.png",
    "https://cdn-icons-png.flaticon.com/512/4497/4497656.png",
    //celebration
    "https://cdn-icons-png.flaticon.com/512/4193/4193244.png",
    "https://cdn-icons-png.flaticon.com/512/4213/4213686.png",
    "https://cdn-icons-png.flaticon.com/512/4213/4213704.png",
    "https://cdn-icons-png.flaticon.com/512/4213/4213719.png",
    "https://cdn-icons-png.flaticon.com/512/4213/4213723.png",
    "https://cdn-icons-png.flaticon.com/512/4213/4213726.png",
    "https://cdn-icons-png.flaticon.com/512/4329/4329940.png",
    "https://cdn-icons-png.flaticon.com/512/4359/4359611.png"
  ];

  // List<User> users = [];
  List<Collab> drafts = [];
  //List<Library> posts = [];
  //List<dynamic> profiles = [];
  //List<User> _foundUsers = [];
  List<Library> _foundPosts = [];
  String username = '';

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      username = (await storage.read(key: 'username')).toString();
      // posts = await _postRepository.GetPosts();
      // _foundPosts = posts;
      drafts = await collabrepo.getDraftsByUsername(username);
      if (mounted) setState(() {});
    });

    super.initState();
    controller = PainterController(
        settings: PainterSettings(
            text: TextSettings(
              focusNode: textFocusNode,
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold, color: red, fontSize: 18),
            ),
            freeStyle: const FreeStyleSettings(
              color: red,
              strokeWidth: 5,
            ),
            shape: ShapeSettings(
              paint: shapePaint,
            ),
            scale: const ScaleSettings(
              enabled: true,
              minScale: 1,
              maxScale: 5,
            )));
    // Listen to focus events of the text field
    textFocusNode.addListener(onFocus);

    // Initialize background
    initBackground();
  }

  dynamic galleryFile;
  final ImagePicker _picker = ImagePicker();

  Future imageSelectorGallery() async {
    var image = (await _picker.pickImage(
      source: ImageSource.gallery,
    ));
    if (image != null) {
      Uint8List imageBytes = await image
          .readAsBytes(); // A fixed-length list of 8-bit unsigned integers which is the file read as bytes
      String baseimage = base64Encode(imageBytes);
      if (mounted) setState(() {});
      var _bytesImage = const Base64Decoder().convert(baseimage);
      ui.Image bgImg = await Image.memory(_bytesImage).image.image;
      backgroundImage = bgImg;
      controller.background = bgImg.backgroundDrawable;
    }
  }

  /// Fetches image from an [ImageProvider] (in this example, [NetworkImage])
  /// to use it as a background
  void initBackground() async {
    // Extension getter (.image) to get [ui.Image] from [ImageProvider]
    final image = await const NetworkImage("assets/BG.jpg").image; //BG

    setState(() {
      backgroundImage = image;
      controller.background = image.backgroundDrawable;
    });
  }

  /// Updates UI when the focus changes
  void onFocus() {
    setState(() {});
  }

  Widget buildDefault(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          // Listen to the controller and update the UI when it updates.
          child: ValueListenableBuilder<PainterControllerValue>(
              valueListenable: controller,
              builder: (context, _, child) {
                return AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Color(0xB6326EF1),
                  title: child,
                  actions: [
                    PopupMenuButton(
                        icon: const Icon(PhosphorIcons.upload),
                        itemBuilder: (context) {
                          return [
                            const PopupMenuItem<int>(
                              value: 0,
                              child: Text("Upload from Device"),
                            ),
                            const PopupMenuItem<int>(
                              value: 1,
                              child: Text("Upload from Profiles"),
                            ),
                            const PopupMenuItem<int>(
                              value: 2,
                              child: Text("Search Tags"),
                            ),
                            const PopupMenuItem<int>(
                              value: 3,
                              child: Text("Use Drafts"),
                            ),
                          ];
                        },
                        onSelected: (value) {
                          if (value == 0) {
                            imageSelectorGallery();
                          } else if (value == 1) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      content: SearchC(context),
                                      actions: [
                                        IconButton(
                                          icon:
                                              const Icon(Icons.cancel_rounded),
                                          tooltip: 'Close',
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                        ),
                                      ],
                                    ));
                          } else if (value == 2) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchT(context),
                              ),
                            );
                          } else if (value == 3) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    displaydrafts(context, drafts),
                              ),
                            );
                          }
                        }),

                    // delete selected drawable
                    IconButton(
                      icon: const Icon(
                        PhosphorIcons.trash,
                      ),
                      onPressed: controller.selectedObjectDrawable == null
                          ? null
                          : removeSelectedDrawable,
                    ),
                    // flip the selected drawable
                    IconButton(
                      icon: const Icon(
                        Icons.flip,
                      ),
                      onPressed: controller.selectedObjectDrawable != null &&
                              controller.selectedObjectDrawable is ImageDrawable
                          ? flipSelectedImageDrawable
                          : null,
                    ),
                    // Redo action
                    IconButton(
                      icon: const Icon(
                        PhosphorIcons.arrowClockwise,
                      ),
                      onPressed: controller.canRedo ? redo : null,
                    ),
                    // Undo action
                    IconButton(
                      icon: const Icon(
                        PhosphorIcons.arrowCounterClockwise,
                      ),
                      onPressed: controller.canUndo ? undo : null,
                    ),
                  ],
                );
              }),
        ),
        // Generate image
        floatingActionButton: FloatingActionButton(
          heroTag: "btn1",
          backgroundColor: Color(0xB6326EF1),
          child: const Icon(PhosphorIcons.imageFill),
          onPressed: renderAndDisplayImage,
        ),
        body: Stack(
          children: [
            if (backgroundImage != null)
              // Enforces constraints
              Positioned.fill(
                child: Center(
                  child: AspectRatio(
                    aspectRatio:
                        backgroundImage!.width / backgroundImage!.height,
                    child: FlutterPainter(
                      controller: controller,
                    ),
                  ),
                ),
              ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: ValueListenableBuilder(
                valueListenable: controller,
                builder: (context, _, __) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Container(
                        constraints: const BoxConstraints(
                          maxWidth: 400,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                          color: Colors.white54,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (controller.freeStyleMode !=
                                FreeStyleMode.none) ...[
                              const Divider(),
                              const Text("Free Style Settings"),
                              // Control free style stroke width
                              Row(
                                children: [
                                  const Expanded(
                                      flex: 1, child: Text("Stroke Width")),
                                  Expanded(
                                    flex: 3,
                                    child: Slider.adaptive(
                                        min: 2,
                                        max: 25,
                                        value: controller.freeStyleStrokeWidth,
                                        onChanged: setFreeStyleStrokeWidth),
                                  ),
                                ],
                              ),
                              if (controller.freeStyleMode ==
                                  FreeStyleMode.draw)
                                Row(
                                  children: [
                                    const Expanded(
                                        flex: 1, child: Text("Color")),
                                    // Control free style color hue
                                    Expanded(
                                      flex: 3,
                                      child: Slider.adaptive(
                                          min: 0,
                                          max: 359.99,
                                          value: HSVColor.fromColor(
                                                  controller.freeStyleColor)
                                              .hue,
                                          activeColor:
                                              controller.freeStyleColor,
                                          onChanged: setFreeStyleColor),
                                    ),
                                  ],
                                ),
                            ],
                            if (textFocusNode.hasFocus) ...[
                              const Divider(),
                              const Text("Text settings"),
                              // Control text font size
                              Row(
                                children: [
                                  const Expanded(
                                      flex: 1, child: Text("Font Size")),
                                  Expanded(
                                    flex: 3,
                                    child: Slider.adaptive(
                                        min: 8,
                                        max: 96,
                                        value:
                                            controller.textStyle.fontSize ?? 14,
                                        onChanged: setTextFontSize),
                                  ),
                                ],
                              ),

                              // Control text color hue
                              Row(
                                children: [
                                  const Expanded(flex: 1, child: Text("Color")),
                                  Expanded(
                                    flex: 3,
                                    child: Slider.adaptive(
                                        min: 0,
                                        max: 359.99,
                                        value: HSVColor.fromColor(
                                                controller.textStyle.color ??
                                                    red)
                                            .hue,
                                        activeColor: controller.textStyle.color,
                                        onChanged: setTextColor),
                                  ),
                                ],
                              ),
                            ],
                            if (controller.shapeFactory != null) ...[
                              const Divider(),
                              const Text("Shape Settings"),

                              // Control text color hue
                              Row(
                                children: [
                                  const Expanded(
                                      flex: 1, child: Text("Stroke Width")),
                                  Expanded(
                                    flex: 3,
                                    child: Slider.adaptive(
                                        min: 2,
                                        max: 25,
                                        value: controller
                                                .shapePaint?.strokeWidth ??
                                            shapePaint.strokeWidth,
                                        onChanged: (value) =>
                                            setShapeFactoryPaint(
                                                (controller.shapePaint ??
                                                        shapePaint)
                                                    .copyWith(
                                              strokeWidth: value,
                                            ))),
                                  ),
                                ],
                              ),

                              // Control shape color hue
                              Row(
                                children: [
                                  const Expanded(flex: 1, child: Text("Color")),
                                  Expanded(
                                    flex: 3,
                                    child: Slider.adaptive(
                                        min: 0,
                                        max: 359.99,
                                        value: HSVColor.fromColor(
                                                (controller.shapePaint ??
                                                        shapePaint)
                                                    .color)
                                            .hue,
                                        activeColor: (controller.shapePaint ??
                                                shapePaint)
                                            .color,
                                        onChanged: (hue) =>
                                            setShapeFactoryPaint(
                                                (controller.shapePaint ??
                                                        shapePaint)
                                                    .copyWith(
                                              color: HSVColor.fromAHSV(
                                                      1, hue, 1, 1)
                                                  .toColor(),
                                            ))),
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  const Expanded(
                                      flex: 1, child: Text("Fill shape")),
                                  Expanded(
                                    flex: 3,
                                    child: Center(
                                      child: Switch(
                                          value: (controller.shapePaint ??
                                                      shapePaint)
                                                  .style ==
                                              PaintingStyle.fill,
                                          onChanged: (value) =>
                                              setShapeFactoryPaint(
                                                  (controller.shapePaint ??
                                                          shapePaint)
                                                      .copyWith(
                                                style: value
                                                    ? PaintingStyle.fill
                                                    : PaintingStyle.stroke,
                                              ))),
                                    ),
                                  ),
                                ],
                              ),
                            ]
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: controller,
          builder: (context, _, __) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Free-style eraser
              IconButton(
                icon: Icon(
                  PhosphorIcons.eraser,
                  color: controller.freeStyleMode == FreeStyleMode.erase
                      ? Theme.of(context).accentColor
                      : null,
                ),
                onPressed: toggleFreeStyleErase,
              ),
              // Free-style drawing
              IconButton(
                icon: Icon(
                  PhosphorIcons.scribbleLoop,
                  color: controller.freeStyleMode == FreeStyleMode.draw
                      ? Theme.of(context).accentColor
                      : null,
                ),
                onPressed: toggleFreeStyleDraw,
              ),
              // Add text
              IconButton(
                icon: Icon(
                  PhosphorIcons.textT,
                  color: textFocusNode.hasFocus
                      ? Theme.of(context).accentColor
                      : null,
                ),
                onPressed: addText,
              ),
              // Add sticker image
              IconButton(
                icon: const Icon(
                  PhosphorIcons.sticker,
                ),
                onPressed: addSticker,
              ),
              // Add shapes
              if (controller.shapeFactory == null)
                PopupMenuButton<ShapeFactory?>(
                  tooltip: "Add shape",
                  itemBuilder: (context) => <ShapeFactory, String>{
                    LineFactory(): "Line",
                    ArrowFactory(): "Arrow",
                    DoubleArrowFactory(): "Double Arrow",
                    RectangleFactory(): "Rectangle",
                    OvalFactory(): "Oval",
                  }
                      .entries
                      .map((e) => PopupMenuItem(
                          value: e.key,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                getShapeIcon(e.key),
                                color: Colors.black,
                              ),
                              Text(" ${e.value}")
                            ],
                          )))
                      .toList(),
                  onSelected: selectShape,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      getShapeIcon(controller.shapeFactory),
                      color: controller.shapeFactory != null
                          ? Theme.of(context).accentColor
                          : null,
                    ),
                  ),
                )
              else
                IconButton(
                  icon: Icon(
                    getShapeIcon(controller.shapeFactory),
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () => selectShape(null),
                ),
            ],
          ),
        ));
  }

  Widget displaydrafts(BuildContext context, List<Collab> post) {
    return SafeArea(
        child: Material(
            child: Column(children: [
      Align(
        alignment: Alignment.topLeft, // align to the top left of the page
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: const Color.fromRGBO(1, 1, 1, 1),
          iconSize: 25,
          tooltip: 'Back',
          onPressed: () {
            Navigator.of(context).pushNamed('/collabandmashup');
          },
        ),
      ),
      Expanded(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [],
              ),
            ),
            SliverPadding(
              padding:
                  const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
              sliver: SliverGrid(
                // Creates a sliver that places multiple box children in a grid acc to delegate
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400,
                  childAspectRatio: 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 15,
                ),
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  Collab postobj = post[index];
                  var _bytesImage =
                      const Base64Decoder().convert(postobj.draft);
                  return Container(
                      padding:
                          (index % 2 == 0 // gap from left or right to screen
                              ? const EdgeInsets.only(left: 20.0)
                              : const EdgeInsets.only(right: 20.0)),
                      child: InkWell(
                          onTap: () {
                            //img = imageLink.post;
                            setState(() {
                              Future.delayed(Duration.zero, () async {
                                print("b1");
                                ui.Image bg =
                                    await Image.memory(_bytesImage).image.image;
                                backgroundImage = bg;
                                controller.background = bg.backgroundDrawable;
                                print("b12");
                              });
                            });
                            Navigator.pop(context, 'Cancel');
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height / 4.7,
                            width: MediaQuery.of(context).size.width / 3.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.memory(
                                    _bytesImage,
                                  ).image,
                                )),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        PopupMenuButton(
                                          itemBuilder: (context) {
                                            return [
                                              PopupMenuItem<int>(
                                                  value: 0,
                                                  child:
                                                      const Text("Delete Post"),
                                                  onTap: () async {
                                                    var bool = await collabrepo
                                                        .deletePost(postobj.id);
                                                    print(bool);
                                                    if (bool) {
                                                      // displaydrafts(
                                                      //  context, post);
                                                      Navigator.of(context)
                                                          .pushNamedAndRemoveUntil(
                                                              "/collabandmashup",
                                                              (route) => false);
                                                    }
                                                  }),
                                            ];
                                          },
                                        ),
                                      ]),
                                ]),
                          )));
                }, childCount: post.length),
              ),
            ),
          ],
        ),
      ),
    ])));
  }

  @override
  Widget build(BuildContext context) {
    return buildDefault(context);
  }

  static IconData getShapeIcon(ShapeFactory? shapeFactory) {
    if (shapeFactory is LineFactory) return PhosphorIcons.lineSegment;
    if (shapeFactory is ArrowFactory) return PhosphorIcons.arrowUpRight;
    if (shapeFactory is DoubleArrowFactory) {
      return PhosphorIcons.arrowsHorizontal;
    }
    if (shapeFactory is RectangleFactory) return PhosphorIcons.rectangle;
    if (shapeFactory is OvalFactory) return PhosphorIcons.circle;
    return PhosphorIcons.polygon;
  }

  void undo() {
    controller.undo();
  }

  void redo() {
    controller.redo();
  }

  void toggleFreeStyleDraw() {
    controller.freeStyleMode = controller.freeStyleMode != FreeStyleMode.draw
        ? FreeStyleMode.draw
        : FreeStyleMode.none;
  }

  void toggleFreeStyleErase() {
    controller.freeStyleMode = controller.freeStyleMode != FreeStyleMode.erase
        ? FreeStyleMode.erase
        : FreeStyleMode.none;
  }

  void addText() {
    if (controller.freeStyleMode != FreeStyleMode.none) {
      controller.freeStyleMode = FreeStyleMode.none;
    }
    controller.addText();
  }

  void addSticker() async {
    final imageLink = await showDialog<String>(
        context: context,
        builder: (context) => const SelectStickerImageDialog(
              imagesLinks: imageLinks,
            ));
    if (imageLink == null) return;
    controller.addImage(
        await NetworkImage(imageLink).image, const Size(100, 100));
  }

  void setFreeStyleStrokeWidth(double value) {
    controller.freeStyleStrokeWidth = value;
  }

  void setFreeStyleColor(double hue) {
    controller.freeStyleColor = HSVColor.fromAHSV(1, hue, 1, 1).toColor();
  }

  void setTextFontSize(double size) {
    // Set state is just to update the current UI, the [FlutterPainter] UI updates without it
    setState(() {
      controller.textSettings = controller.textSettings.copyWith(
          textStyle:
              controller.textSettings.textStyle.copyWith(fontSize: size));
    });
  }

  void setShapeFactoryPaint(Paint paint) {
    // Set state is just to update the current UI, the [FlutterPainter] UI updates without it
    setState(() {
      controller.shapePaint = paint;
    });
  }

  void setTextColor(double hue) {
    controller.textStyle = controller.textStyle
        .copyWith(color: HSVColor.fromAHSV(1, hue, 1, 1).toColor());
  }

  void selectShape(ShapeFactory? factory) {
    controller.shapeFactory = factory;
  }

  void renderAndDisplayImage() {
    if (backgroundImage == null) return;
    final backgroundImageSize = Size(
        backgroundImage!.width.toDouble(), backgroundImage!.height.toDouble());

    // Render the image
    // Returns a [ui.Image] object, convert to to byte data and then to Uint8List
    final imageFuture = controller
        .renderImage(backgroundImageSize)
        .then<Uint8List?>((ui.Image image) => image.pngBytes);

    // Show a dialog with the image
    showDialog(
        context: context,
        builder: (context) => RenderedImageDialog(imageFuture: imageFuture));
  }

  void removeSelectedDrawable() {
    final selectedDrawable = controller.selectedObjectDrawable;
    if (selectedDrawable != null) controller.removeDrawable(selectedDrawable);
  }

  void flipSelectedImageDrawable() {
    final imageDrawable = controller.selectedObjectDrawable;
    if (imageDrawable is! ImageDrawable) return;

    controller.replaceDrawable(
        imageDrawable, imageDrawable.copyWith(flipped: !imageDrawable.flipped));
  }
}

class SearchC extends StatefulWidget {
  BuildContext buildContext;
  SearchC(this.buildContext, {Key? key}) : super(key: key);

  @override
  State<SearchC> createState() => _SearchCState();
}

class _SearchCState extends State<SearchC> {
  final UserRepository _userRepository = UserRepository();
  final PostRepository _postRepository = PostRepository();
  final ProfileRepository _profRepository = ProfileRepository();
  List<dynamic> profiles = [];
  List<User> users = [];
  List<Library> posts = [];
  List<User> _foundUsers = [];
  String username = '';
  FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      username = (await storage.read(key: 'username')).toString();
      users = await _userRepository.GetUsers();
      users.removeWhere((element) =>
          (element.email.compareTo("hwumazij@gmail.com") == 0) &&
          (element.username.compareTo("hwumazijadmin48") == 0));
      profiles = await _profRepository.getProfiles();
      posts = await _postRepository.GetPosts();
      _foundUsers = users;
    });
    super.initState();
  }

  dynamic _profilepic(String username) {
    int i = 0;
    String dp = '';
    while (i < profiles.length) {
      if (profiles[i].username.compareTo(username) == 0) {
        dp = profiles[i].profile_pic;
      }
      i++;
    }
    var s = const Base64Decoder().convert(dp);
    return s;
  }

  void _runFilter(String enteredKeyword) {
    List<User> results = [];
    if (enteredKeyword.isEmpty) {
      results = users;
      print("if filter length is 0, len of all users is- ${results.length}");
    } else {
      print("if filter not 0");
      results = users
          .where((user) => (user.username
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              user.first_name
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              user.last_name
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase())))
          .toList();
      print(results.length);
    }

    setState(() {
      _foundUsers = results;
      print("foundusers len in setstate runfilter- ${_foundUsers.length}");
    });
    // Refresh the UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Search User',
            style: TextStyle(
                color: Colors.purple,
                fontSize: 14,
                fontWeight: FontWeight.w700)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (value) {
                print("on changed");
                _runFilter(value);
                print("value in textfield after filter ${value}");
                int i = 0;
                while (i < _foundUsers.length) {
                  print("in onchanged loop");
                  print(_foundUsers[i].username);
                  i++;
                }
              },
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.purple),
                    borderRadius: BorderRadius.circular(45),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(45),
                  ),
                  suffixIcon: const Icon(Icons.search)),
            ),
            const SizedBox(
              height: 40,
            ),
            Expanded(
                child: _foundUsers.isEmpty
                    ? ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) => Card(
                          key: ValueKey(users[index].username),
                          //color: Colors.amberAccent,
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                              width: 100,
                              child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: Image.memory(
                                      _profilepic(users[index].username),
                                    ).image,
                                    radius: 35.0,
                                  ),
                                  title: Text(users[index].username.toString()),
                                  subtitle: Text(
                                    "${users[index].first_name} ${users[index].last_name}",
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  onTap: () {
                                    List<Library> po = [];
                                    int i = 0;
                                    while (i < posts.length) {
                                      if (posts[i].user.compareTo(
                                              users[index].username) ==
                                          0) {
                                        po.add(posts[i]);
                                      }
                                      i++;
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            displayposts(context, po),
                                      ),
                                    );
                                  })),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _foundUsers.length,
                        itemBuilder: (context, index) => Card(
                          key: ValueKey(_foundUsers[index].username),
                          //color: Colors.amberAccent,
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                              width: 100,
                              child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: Image.memory(
                                      _profilepic(_foundUsers[index].username),
                                    ).image,
                                    radius: 35.0,
                                  ),
                                  title: Text(
                                      _foundUsers[index].username.toString()),
                                  subtitle: Text(
                                    "${_foundUsers[index].first_name} ${_foundUsers[index].last_name}",
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  onTap: () {
                                    List<Library> po = [];
                                    int i = 0;
                                    while (i < posts.length) {
                                      if (posts[i].user.compareTo(
                                              _foundUsers[index].username) ==
                                          0) {
                                        po.add(posts[i]);
                                      }
                                      i++;
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            displayposts(context, po),
                                      ),
                                    );
                                  })),
                        ),
                      )),
          ],
        ),
      ),
    );
  }

  Widget displayposts(BuildContext context, List<Library> post) {
    return SafeArea(
        child: Material(
            child: Column(children: [
      Align(
        alignment: Alignment.topLeft, // align to the top left of the page
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: const Color.fromRGBO(1, 1, 1, 1),
          iconSize: 25,
          tooltip: 'Back',
          onPressed: () {
            Navigator.of(context).pushNamed('/collabandmashup');
          },
        ),
      ),
      Expanded(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [],
              ),
            ),
            SliverPadding(
              padding:
                  const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
              sliver: SliverGrid(
                // Creates a sliver that places multiple box children in a grid acc to delegate
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400,
                  childAspectRatio: 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 15,
                ),
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  Library postobj = post[index];
                  var _bytesImage = const Base64Decoder().convert(postobj.post);
                  return Container(
                      padding:
                          (index % 2 == 0 // gap from left or right to screen
                              ? const EdgeInsets.only(left: 20.0)
                              : const EdgeInsets.only(right: 20.0)),
                      child: InkWell(
                          onTap: () {
                            //img = imageLink.post;
                            setState(() {
                              Future.delayed(Duration.zero, () async {
                                print("b1");
                                ui.Image bg =
                                    await Image.memory(_bytesImage).image.image;
                                backgroundImage = bg;
                                controller.background = bg.backgroundDrawable;
                                print("b12");
                              });
                            });
                            Navigator.pop(context, 'Cancel');
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height / 4.7,
                            width: MediaQuery.of(context).size.width / 3.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.memory(
                                    _bytesImage,
                                  ).image,
                                )),
                          )));
                }, childCount: post.length),
              ),
            ),
          ],
        ),
      ),
    ])));
  }
}

class SearchT extends StatefulWidget {
  BuildContext buildContext;
  SearchT(this.buildContext, {Key? key}) : super(key: key);

  @override
  State<SearchT> createState() => _SearchTState();
}

class _SearchTState extends State<SearchT> {
  List<Library> posts = [];
  List<Library> _foundPosts = [];
  PostRepository _postRepository = PostRepository();

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      //username = (await storage.read(key: 'username')).toString();
      posts = await _postRepository.GetPosts();
      _foundPosts = posts;
      print("painter init state searcht");
      if (mounted) setState(() {});
    });
    super.initState();
  }

  void _runFilter2(String enteredKeyword) {
    List<Library> results = [];
    if (enteredKeyword.isEmpty) {
      results = posts;
      print("if filter length");
      print(results.length);
    } else {
      print("if filter not 0");
      results = posts
          .where((post) => ((post.caption
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase())) ||
              (enteredKeyword
                  .toLowerCase()
                  .startsWith(post.account_type.toLowerCase()))))
          .toList();
    }

    // Refresh the UI
    setState(() {
      _foundPosts = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Search Tags',
            style: TextStyle(
                color: Colors.purple,
                fontSize: 14,
                fontWeight: FontWeight.w700)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (value) => _runFilter2(value),
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.purple),
                    borderRadius: BorderRadius.circular(45),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(45),
                  ),
                  suffixIcon: const Icon(Icons.search)),
            ),
            const SizedBox(
              height: 40,
            ),
            Expanded(
                child:
                    //_foundUsers.isNotEmpty?
                    _foundPosts.isEmpty
                        ? displayposts(context, posts)
                        : displayposts(context, _foundPosts)),
          ],
        ),
      ),
    );
  }

  Widget displayposts(BuildContext context, List<Library> post) {
    return SafeArea(
        child: Material(
            child: Column(children: [
      // Align(
      //   alignment: Alignment.topLeft, // align to the top left of the page
      //   child: IconButton(
      //     icon: const Icon(Icons.arrow_back),
      //     color: const Color.fromRGBO(1, 1, 1, 1),
      //     iconSize: 25,
      //     tooltip: 'Back',
      //     onPressed: () {
      //       Navigator.of(context).pushNamed('/collabandmashup');
      //     },
      //   ),
      // ),
      Expanded(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [],
              ),
            ),
            SliverPadding(
              padding:
                  const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
              sliver: SliverGrid(
                // Creates a sliver that places multiple box children in a grid acc to delegate
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400,
                  childAspectRatio: 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 15,
                ),
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  Library postobj = post[index];
                  var _bytesImage = const Base64Decoder().convert(postobj.post);
                  return Container(
                      padding:
                          (index % 2 == 0 // gap from left or right to screen
                              ? const EdgeInsets.only(left: 20.0)
                              : const EdgeInsets.only(right: 20.0)),
                      child: InkWell(
                          onTap: () {
                            //img = imageLink.post;
                            setState(() {
                              Future.delayed(Duration.zero, () async {
                                print("b1");
                                ui.Image bg =
                                    await Image.memory(_bytesImage).image.image;
                                backgroundImage = bg;
                                controller.background = bg.backgroundDrawable;
                                print("b12");
                              });
                            });
                            Navigator.pop(context, 'Cancel');
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height / 4.7,
                            width: MediaQuery.of(context).size.width / 3.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.memory(
                                    _bytesImage,
                                  ).image,
                                )),
                          )));
                }, childCount: post.length),
              ),
            ),
          ],
        ),
      ),
    ])));
  }
}

class RenderedImageDialog extends StatefulWidget {
  final Future<Uint8List?> imageFuture;

  const RenderedImageDialog({Key? key, required this.imageFuture})
      : super(key: key);

  @override
  State<RenderedImageDialog> createState() => _RenderedImageDialogState();
}

class _RenderedImageDialogState extends State<RenderedImageDialog> {
  String user = '';
  var storage = const FlutterSecureStorage();
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      user = (await storage.read(key: 'username')).toString();
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Color c = Colors.grey;
    dynamic b;
    return AlertDialog(
      title: const Text("Mashup"),
      content: FutureBuilder<Uint8List?>(
        future: widget.imageFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const SizedBox(
              height: 50,
              child: Center(child: CircularProgressIndicator.adaptive()),
            );
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const SizedBox();
          }
          b = snapshot.data;

          return InteractiveViewer(
              maxScale: 10, child: Image.memory(snapshot.data!));
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.cancel_rounded),
          tooltip: 'Close',
          onPressed: () => Navigator.pop(context, 'Cancel'),
          //child: const Text('Cancel'),
        ),
        IconButton(
          icon: const Icon(Icons.save),
          tooltip: 'Save to Device',
          onPressed: () async {
            await FileSaver.instance
                .saveFile("sample_mashup", b, "jpeg", mimeType: MimeType.JPEG);
          },
        ),
        IconButton(
          icon: Icon(
            Icons.cloud_download,
            //color: c,
          ),
          tooltip: 'Save to Drafts',
          onPressed: () async {
            CollabRepository crepo = CollabRepository();
            var bool = await crepo.createPost(user, base64Encode(b));
            print(bool);
            if (bool) {
              setState(() {
                // c = Colors.green;
              });
              Navigator.of(context).pushNamedAndRemoveUntil(
                  "/collabandmashup", (route) => false);
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.file_upload),
          tooltip: 'Upload to Profile',
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreatePostCollab(
                        base64Encode(b), user, "Uploaded to Mazij!", 0, user)));
          },
        )
      ],
    );
  }
}

class SelectStickerImageDialog extends StatelessWidget {
  final List<String> imagesLinks;

  const SelectStickerImageDialog({Key? key, this.imagesLinks = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Select sticker"),
      content: imagesLinks.isEmpty
          ? const Text("No images")
          : FractionallySizedBox(
              heightFactor: 0.5,
              child: SingleChildScrollView(
                child: Wrap(
                  children: [
                    for (final imageLink in imagesLinks)
                      InkWell(
                        onTap: () => Navigator.pop(context, imageLink),
                        child: FractionallySizedBox(
                          widthFactor: 1 / 4,
                          child: Image.network(imageLink),
                        ),
                      ),
                  ],
                ),
              ),
            ),
      actions: [
        IconButton(
          icon: const Icon(Icons.cancel_rounded),
          tooltip: 'Close',
          onPressed: () => Navigator.pop(context, 'Cancel'),
          //child: const Text('Cancel'),
        ),
      ],
    );
  }
}
