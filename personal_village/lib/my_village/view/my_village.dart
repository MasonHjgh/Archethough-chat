import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class MyVillage extends StatefulWidget {
  const MyVillage({Key? key}) : super(key: key);

  @override
  State<MyVillage> createState() => _MyVillageState();
}

class _MyVillageState extends State<MyVillage>
    with SingleTickerProviderStateMixin {
  final Graph graph = Graph();
  bool isDataReady = false;
  TransformationController viewController = TransformationController();
  late AnimationController _animationController;
  late Animation<Matrix4> _mapAnimation;
  bool showInfoBar = false;
  int tappedPerson = 0;

  @override
  void initState() {
    super.initState();
    var start = Matrix4.identity()..translate(0.0, 0.0);
    var end = Matrix4.identity()..translate(100.0, 100.0);
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    _mapAnimation =
        Matrix4Tween(begin: start, end: end).animate(_animationController);
    _mapAnimation.addListener(() {
      setState(() {
        viewController.value = Matrix4.inverted(_mapAnimation.value);
      });
    });
    _animationController.forward();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      setUpDummyData();
    });
  }

  _animateToPosition(Offset offset) {
    print("The offset: $offset");
    if (_animationController.isAnimating) {
      _animationController.stop();
    }
    _mapAnimation = Matrix4Tween(
            begin: viewController.value,
            end: Matrix4.identity()..translate(offset.dx, offset.dy))
        .animate(_animationController);
    _mapAnimation.addListener(() {
      setState(() {
        viewController.value = Matrix4.inverted(_mapAnimation.value);
      });
    });
    _animationController.reset();
    _animationController.forward().then((value) {
      setState(() {
        viewController.value = Matrix4.inverted(
            Matrix4.identity()..translate(offset.dx, offset.dy));
      });

      print("new controller value: ${viewController.value}");
    });
  }

  setUpDummyData() async {
    final selfNode = Node.Id(0);
    final node1 = Node.Id(1);
    final node2 = Node.Id(2);
    final node3 = Node.Id(3);
    final node4 = Node.Id(4);
    final node5 = Node.Id(5);
    final node6 = Node.Id(6);
    final node8 = Node.Id(7);
    final node7 = Node.Id(8);
    graph.addEdge(selfNode, node1);
    graph.addEdge(selfNode, node2);
    graph.addEdge(selfNode, node3);
    graph.addEdge(selfNode, node4);
    graph.addEdge(selfNode, node5);
    graph.addEdge(selfNode, node6);
    graph.addEdge(selfNode, node7);
    graph.addEdge(selfNode, node8);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      isDataReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("viewController: dx: ${viewController.value.toString()}");
    return isDataReady
        ? Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.75,
                    width: MediaQuery.of(context).size.width,
                    color: Color(0xFFF0F0F0),
                    child: InteractiveViewer(
                      transformationController: viewController,
                      constrained: false,
                      panEnabled: true,
                      scaleEnabled: true,
                      boundaryMargin: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 40,
                      ),
                      minScale: 0.01,
                      maxScale: 5.6,
                      child: GraphView(
                        algorithm: FruchtermanReingoldAlgorithm(),
                        graph: graph,
                        paint: Paint()
                          ..color = Color(0xFFF0F0F0)
                          ..strokeWidth = 1
                          ..style = PaintingStyle.stroke,
                        builder: (Node node) {
                          int id = node.key?.value as int;
                          if (id == 0) {
                            return CircleAvatar(
                              child: CircleAvatar(
                                child: Image.asset(
                                  "assets/images/avatar.png",
                                ),
                              ),
                            );
                          } else {
                            return GestureDetector(
                              onTapUp: (TapUpDetails details) {
                                double canvasHeight =
                                    MediaQuery.of(context).size.height * 0.75;
                                double canvasWidth =
                                    MediaQuery.of(context).size.width;
                                Offset targetPosition = Offset(
                                    node.x - (canvasWidth / 2),
                                    node.y - (canvasHeight / 2));

                                // _animateToPosition(targetPosition);
                                setState(() {
                                  tappedPerson = id;
                                  if (!showInfoBar) showInfoBar = true;
                                });
                              },
                              child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                "assets/images/p3.jpg",
                              )),
                            );
                          }
                        },
                      ),
                    )),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 40,
                child: Text(
                  "My Village",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              AnimatedPositioned(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.red.shade300,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          "assets/images/p2.jpg",
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Person $tappedPerson",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Brother",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Icon(Icons.call),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white38,
                        child: Icon(
                          Icons.mail,
                          color: Colors.white,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.teal,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 35,
                        ),
                        onPressed: () {
                          setState(() {
                            showInfoBar = false;
                          });
                        },
                      )
                    ],
                  ),
                ),
                duration: Duration(milliseconds: 300),
                bottom: showInfoBar ? 0 : -80,
              )
            ],
          )
        : Center(
            child: CircularProgressIndicator(
              color: Colors.red.shade300,
            ),
          );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
