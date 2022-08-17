import 'package:flutter/material.dart';

import '../managers/settings_manager.dart';

class Settings extends StatefulWidget {
  final Function onBackClicked;

  const Settings({
    Key? key,
    required this.onBackClicked,
  }) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 800,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.white,
                    ),
                    onPressed: () => {} //widget.onBackClicked,
                    ),
              ),
              const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
              Expanded(child: Container())
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ValueListenableBuilder<bool>(
            valueListenable: SettingsManager.instance.listenableBgm,
            builder: (context, bool bgm, _) {
              return SwitchListTile(
                title: const Text(
                  "Background Music",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                ),
                value: bgm,
                onChanged: (bool value) {
                  SettingsManager.instance.setBgm(value);
                },
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: SettingsManager.instance.listenableSfx,
            builder: (context, bool sfx, _) {
              return SwitchListTile(
                title: const Text(
                  "Sound Effects",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                ),
                value: sfx,
                onChanged: (bool value) {
                  SettingsManager.instance.setSfx(value);
                },
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: SettingsManager.instance.listenableBackgroundIndex,
            builder: (context, int selectedIndex, _) {
              // TODO - implement the parallax map here to select
              // var backgroundImages = parallaxMap.values.toList();
              var backgroundImages = [];

              return Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: backgroundImages.map((e) {
                    int index = backgroundImages.indexOf(e);
                    bool backgroundSelected = index == selectedIndex;

                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (!backgroundSelected) {
                            SettingsManager.instance.setBackgroundIndex(index);
                            SettingsManager.instance.listenableBackgroundIndex
                                .value = index;
                          }
                        },
                        child: BackgroundImageWidget(
                          e.displayBackgroundImage,
                          isSelected: backgroundSelected,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class BackgroundImageWidget extends StatelessWidget {
  final String image;
  final bool isSelected;

  const BackgroundImageWidget(this.image, {Key? key, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
        border: !isSelected ? null : Border.all(color: Colors.yellow, width: 2),
        color: Colors.transparent,
      ),
    );
  }
}
