import 'package:bt/ProfileOverview.dart';
import 'package:flutter/material.dart';

class Profiledetail extends StatefulWidget {
  const Profiledetail({super.key});

  @override
  State<Profiledetail> createState() => _ProfiledetailState();
}

class _ProfiledetailState extends State<Profiledetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.26,
              decoration: BoxDecoration(
                  color: Colors.blue[400],
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
            ),
            SafeArea(
                child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () =>
                              onPressedRouter(context, Profileoverview()))),
                  const Expanded(
                    flex: 4,
                    child: Text(
                      'PROFILE',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: const Icon(
                          Icons.create,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ))
                ],
              ),
            )),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 120),
                  child: const CardViewDetail(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Info(),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: DetailPage(text: 'Personal Detail'),
                ),
                DetailPage(text: 'Friend List')
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CardViewDetail extends StatefulWidget {
  const CardViewDetail({super.key});
  @override
  State<CardViewDetail> createState() => _CarViewDetail();
}

class _CarViewDetail extends State<CardViewDetail> {
  bool _zoom = false;
  void _zoomOut() {
    setState(() {
      _zoom = !_zoom;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Card(
        elevation: 6,
        child: GestureDetector(
          onTap: () => _zoomOut(),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/background.jpg',
                          fit: BoxFit.cover,
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Đoàn Văn Sơn',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'K24-CNTTA',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 300),
                    firstCurve: Curves.easeInOut,
                    secondCurve: Curves.easeInOut,
                    crossFadeState: _zoom
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    firstChild: const Text(
                      'Tap to see detail',
                      style: TextStyle(fontSize: 12),
                    ),
                    secondChild: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(height: 10),
                          Text(
                            'Hobbies: Soccer, Badminton, Video games',
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Skills: Flutter, Dart',
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Education: Banking Academy',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  bool _zoom = false;
  void _zoomOut() {
    setState(() {
      _zoom = !_zoom;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _zoomOut,
      child: AnimatedContainer(
        // transform: Matrix4.translationValues(0, _zoom ? -100 : 0, 0),
        height: _zoom ? 200 : 100,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 50,
          )
        ]),

        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: const Card(
            elevation: 4,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(Icons.phone),
                      SizedBox(width: 10),
                      Text(
                        '+0325277184',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 13),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(Icons.mail),
                      SizedBox(width: 10),
                      Text(
                        'vanson21102003@gmail.com',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 13),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String text;

  const DetailPage({super.key, required this.text});

  void onPressed() {}
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Attribute(text: text)),
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 25, right: 20, top: 10),
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(),
          color: Colors.black26,
        ),
        child: Row(
          children: [
            Expanded(
                flex: 4,
                child: Text(
                  text,
                  style: TextStyle(color: Colors.blue[700]),
                )),
            Expanded(
                flex: 4,
                child: SizedBox(
                  width: 50,
                )),
            Expanded(
                flex: 2,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation) =>
                            Attribute(text: 'List Friend'),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(0.0, 1.0);
                          const end = Offset.zero;
                          const curves = Curves.easeInOut;
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curves));
                          var offset = animation.drive(tween);
                          return SlideTransition(
                              position: offset, child: child);
                        },
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.blue[300],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
