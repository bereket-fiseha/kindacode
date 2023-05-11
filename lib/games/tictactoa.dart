import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kindacode/games/tictacsetting.dart';
import 'package:kindacode/provider/playersettingprovider.dart';
import 'package:kindacode/provider/soundeffectsettingprovider.dart';
import 'package:kindacode/screen/transparentmodal.dart';
import 'package:kindacode/util/texttospeechconvertor.dart';
import 'package:kindacode/widgets/confetticontainer.dart';
import 'package:provider/provider.dart';

enum Turn { N, X, O }

class TicTacToa extends StatefulWidget {
  const TicTacToa({super.key});

  @override
  State<TicTacToa> createState() => _TicTacToaState();
}

initState(BuildContext context) {}

class _TicTacToaState extends State<TicTacToa> {
  var stateMatrix = [
    [Turn.N, Turn.N, Turn.N],
    [Turn.N, Turn.N, Turn.N],
    [Turn.N, Turn.N, Turn.N]
  ];
  Turn currentTurn = Turn.N;
  bool gameOver = false;
  late ConfettiController _controllerCenter;
  TextToSpeechConvertor _tts = TextToSpeechConvertor();
  AudioPlayer _player = AudioPlayer();

  Turn? gameWinner;
  Future playAudio(String src) async {
    ByteData bytes = await rootBundle.load(src); //load audio from assets
    Uint8List audiobytes =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    await _player.playBytes(audiobytes);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(milliseconds: 4000));
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  void ticTacToaBoxOnTap(int row, int col) async {
    var soundEffect =
        Provider.of<SoundEffectSettingProvider>(context, listen: false);
    setState(() {
      if (currentTurn == Turn.N || currentTurn == Turn.X) {
        stateMatrix[row][col] = Turn.X;
        currentTurn = Turn.O;
      } else {
        stateMatrix[row][col] = Turn.O;

        currentTurn = Turn.X;
      }
    });

    var winner = checkWinner(stateMatrix);
    if (soundEffect.enableSound() && winner == null) {
      if (currentTurn == Turn.X) {
        playAudio("asset/audio/ping.mp3");
      } else {
        playAudio("asset/audio/switch.mp3");
      }
    }

    if (winner != null) {
      setState(() {
        gameOver = true;
        gameWinner = winner;
      });

      var player = Provider.of<PlayerSettingProvider>(context, listen: false);

      _tts.speak("The winner is ${player.getPlayer(gameWinner!)}");
      // sleep(new Duration(seconds: 2));
      if (soundEffect.enableSound()) {
        playAudio("asset/audio/cheer.mp3");
        //   _controllerCenter.play();
      }
      Navigator.push(
          context,
          FullScreenModal(
              child: ConfettiContainer(),
              title: "",
              description:
                  "Hooray, The winner is ${player.getPlayer(gameWinner!)}"));
    }
  }

  Turn? checkWinnerInEveryRow(List<List<Turn>> matrix) {
    //check for every row
    //i row
    //j col

//dont check  for value N ,Turn.N
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        if (j == matrix[i].length - 1) {
          return matrix[i][j];
        } else if (matrix[i][j] == Turn.N || matrix[i][j] != matrix[i][j + 1]) {
          break;
        }
      }
    }
    return null;
  }

  Turn? checkWinnerInEveryCol(List<List<Turn>> matrix) {
    //check every column
//j col
//i row
//dont check  for value N ,Turn.N
    for (int j = 0; j < matrix.length; j++) {
      for (int i = 0; i < matrix.length; i++) {
        if (i == matrix.length - 1) {
          return matrix[i][j];
        } else if (matrix[i][j] == Turn.N || matrix[i][j] != matrix[i + 1][j]) {
          break;
        }
      }
    }
    return null;
  }

  Turn? checkWinnerInDiagonal(List<List<Turn>> matrix) {
    //check for diagonal (left to right)
    int j = 0;
    int i = 0;
    while (i == matrix.length - 1 ||
        matrix[i][j] == matrix[i + 1][j + 1] && matrix[i][j] != Turn.N) {
      if (i == matrix.length - 1) {
        return matrix[i][j];
      }
      i++;
      j++;
    }
    //check for diagonal (right to left)
    j = matrix.length - 1;
    i = 0;
    while (i == matrix.length - 1 ||
        matrix[i][j] == matrix[i + 1][j - 1] && matrix[i][j] != Turn.N) {
      if (i == matrix.length - 1) {
        return matrix[i][j];
      }
      i++;
      j--;
    }
    return null;
  }

  Turn? checkWinner(List<List<Turn>> matrix) {
    var winnerByRow = checkWinnerInEveryRow(matrix);
    var winnerByCol = checkWinnerInEveryCol(matrix);
    var winnerByDiagonal = checkWinnerInDiagonal(matrix);

    if (winnerByRow != null) {
      return winnerByRow;
    } else if (winnerByCol != null) {
      return winnerByCol;
    } else if (winnerByDiagonal != null) {
      return winnerByDiagonal;
    }

    return null;
  }

  void reset() {
    setState(() {
      stateMatrix = [
        [Turn.N, Turn.N, Turn.N],
        [Turn.N, Turn.N, Turn.N],
        [Turn.N, Turn.N, Turn.N]
      ];
      gameOver = false;
      gameWinner = null;
    });
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tic Tac Toa"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => TicTacSetting()));
            },
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              RowColBox(
                row: 0,
                col: 0,
                turn: stateMatrix[0][0],
                boxOnTap: ticTacToaBoxOnTap,
              ),
              RowColBox(
                row: 0,
                col: 1,
                turn: stateMatrix[0][1],
                boxOnTap: ticTacToaBoxOnTap,
              ),
              RowColBox(
                row: 0,
                col: 2,
                turn: stateMatrix[0][2],
                boxOnTap: ticTacToaBoxOnTap,
              )
            ],
          ),
          Row(
            children: [
              RowColBox(
                row: 1,
                col: 0,
                turn: stateMatrix[1][0],
                boxOnTap: ticTacToaBoxOnTap,
              ),
              RowColBox(
                row: 1,
                col: 1,
                turn: stateMatrix[1][1],
                boxOnTap: ticTacToaBoxOnTap,
              ),
              RowColBox(
                row: 1,
                col: 2,
                turn: stateMatrix[1][2],
                boxOnTap: ticTacToaBoxOnTap,
              )
            ],
          ),
          Row(
            children: [
              RowColBox(
                row: 2,
                col: 0,
                turn: stateMatrix[2][0],
                boxOnTap: ticTacToaBoxOnTap,
              ),
              RowColBox(
                row: 2,
                col: 1,
                turn: stateMatrix[2][1],
                boxOnTap: ticTacToaBoxOnTap,
              ),
              RowColBox(
                row: 2,
                col: 2,
                turn: stateMatrix[2][2],
                boxOnTap: ticTacToaBoxOnTap,
              )
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Stack(
            children: [
              SizedBox(
                height: 200,
                child: Align(
                  alignment: Alignment.center,
                  child: ConfettiWidget(
                    minBlastForce: 15,
                    numberOfParticles: 30,
                    emissionFrequency: 0.05,
                    confettiController: _controllerCenter,
                    blastDirectionality: BlastDirectionality
                        .explosive, // don't specify a direction, blast randomly
                    shouldLoop:
                        false, // start again as soon as the animation is finished
                    colors: const [
                      Colors.green,
                      Colors.blue,
                      Colors.pink,
                      Colors.orange,
                      Colors.purple,
                      Colors.white,
                      Colors.black,
                      Colors.yellow
                    ], // manually specify the colors to be used
                    createParticlePath: drawStar, // define a custom shape/path.
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Consumer<PlayerSettingProvider>(
                      builder: (context, provider, child) => Text(
                          gameOver
                              ? "The winner is ${provider.getPlayer(gameWinner!)}"
                              : "The turn is for ${provider.getPlayer(currentTurn)} ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25)),
                    ),
                    ElevatedButton(
                        onPressed: () => reset(), child: Text("Reset"))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RowColBox extends StatelessWidget {
  final Turn turn;
  final int row;
  final int col;
  Function(int row, int col) boxOnTap;
  RowColBox(
      {super.key,
      required this.turn,
      required this.boxOnTap,
      required this.row,
      required this.col});

  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.headline2;
    var color = turn == Turn.N
        ? Colors.white
        : turn == Turn.X
            ? Colors.red
            : Colors.green;

    var child = turn == Turn.N
        ? Container()
        : turn == Turn.X
            ? Text("X",
                style: TextStyle(
                    fontSize: textStyle?.fontSize, color: Colors.white))
            : Text(
                "O",
                style: TextStyle(
                    fontSize: textStyle?.fontSize, color: Colors.white),
              );

    return Expanded(
      child: GestureDetector(
          child: TicTacBox(color: color, child: Center(child: child)),
          onTap: () => boxOnTap(row, col)),
    );
  }
}

class TicTacBox extends StatelessWidget {
  final Color color;
  final Widget child;
  const TicTacBox({super.key, required this.color, required this.child});
  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        height: heightOfScreen / 6,
        child: child,
        decoration: BoxDecoration(
            color: color, border: Border.all(width: 3, color: Colors.black54)),
      ),
    );
  }
}
