import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kindacode/provider/darkmodesettingprovider.dart';
import 'package:kindacode/provider/playersettingprovider.dart';
import 'package:kindacode/provider/soundeffectsettingprovider.dart';
import 'package:provider/provider.dart';

class TicTacSetting extends StatefulWidget {
  const TicTacSetting({super.key});

  @override
  State<TicTacSetting> createState() => _TicTacSettingState();
}

class _TicTacSettingState extends State<TicTacSetting> {
  bool playerXEditable = false;
  bool playerOEditable = false;
  final TextEditingController _playerXEditingController =
      TextEditingController();
  final TextEditingController _playerOEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Setting"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 5,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).backgroundColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Consumer<SoundEffectSettingProvider>(
                      builder: ((context, provider, child) => SwitchListTile(
                            title: const Text("Enable Sound"),
                            value: provider.enableSound(),
                            secondary:
                                const Icon(Icons.alarm, color: Colors.blue),
                            onChanged: (bool value) {
                              provider.setEnableSound(value);
                            },
                          )),
                    ),
                    Consumer<DarkModeSettingProvider>(
                      builder: ((context, provider, child) => SwitchListTile(
                            title: const Text("Dark Mode"),
                            value: provider.isDarkModeEnabled(),
                            secondary: const Icon(Icons.dark_mode_rounded,
                                color: Color.fromARGB(217, 243, 171, 46)),
                            onChanged: (bool value) {
                              provider.toggleDarkMode(value);
                            },
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        children: [
                          Icon(FontAwesomeIcons.userTie),
                          SizedBox(
                            width: width / 12,
                          ),
                          const Text(
                            "Player X As:",
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          !playerXEditable
                              ? Expanded(
                                  child: Row(
                                  children: [
                                    Expanded(
                                      child: Consumer<PlayerSettingProvider>(
                                          builder:
                                              ((context, provider, child) =>
                                                  Text(provider.getPlayerX()))),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            playerXEditable = true;
                                          });
                                        },
                                        icon: const Icon(Icons.edit))
                                  ],
                                ))
                              : Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: TextField(
                                          controller: _playerXEditingController,
                                          decoration: const InputDecoration(
                                            hintText: 'name',
                                          ),
                                        ),
                                      )),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              playerXEditable = false;
                                            });
                                          },
                                          icon: const Icon(Icons.cancel))
                                    ],
                                  ),
                                )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        children: [
                          Icon(FontAwesomeIcons.userTie),
                          SizedBox(
                            width: width / 12,
                          ),
                          const Text(
                            "Player O As:",
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          !playerOEditable
                              ? Expanded(
                                  child: Row(
                                  children: [
                                    Expanded(
                                      child: Consumer<PlayerSettingProvider>(
                                          builder:
                                              ((context, provider, child) =>
                                                  Text(provider.getPlayerO()))),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            playerOEditable = true;
                                          });
                                        },
                                        icon: const Icon(Icons.edit))
                                  ],
                                ))
                              : Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: TextField(
                                            controller:
                                                _playerOEditingController,
                                            decoration: const InputDecoration(
                                              //     fillColor:   Theme.of(context).textTheme.bodyText1,
                                              hintText: 'name',
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              playerOEditable = false;
                                            });
                                          },
                                          icon: Icon(Icons.cancel))
                                    ],
                                  ),
                                )
                        ],
                      ),
                    ),
                    Consumer<PlayerSettingProvider>(
                      builder: ((context, provider, child) => ElevatedButton(
                            onPressed: () {
                              provider
                                  .setPlayerX(_playerXEditingController.text);

                              provider
                                  .setPlayerO(_playerOEditingController.text);
                              setState(() {
                                playerOEditable = false;
                                playerXEditable = false;
                              });
                            },
                            child: Text("Save"),
                            style: ButtonStyle(),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
