// ignore: file_names
// ignore_for_file: non_constant_identifier_names

import 'package:bt/ProfileDetail.dart';
import 'package:flutter/material.dart';

class Profileoverview extends StatefulWidget {
  const Profileoverview({super.key});

  @override
  State<Profileoverview> createState() => _ProfileoverviewState();
}

class _ProfileoverviewState extends State<Profileoverview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Stack(children: [
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
                        Icons.menu,
                        color: Colors.white,
                      ),
                      onPressed: () {})),
              const Expanded(
                flex: 4,
                child: Text(
                  'DASH BOARD',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(
                      Icons.notifications,
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
              child: CardView(),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardView1(
                  IconCard: Icon(Icons.menu_book),
                  textCard: 'Syllabus',
                ),
                CardView1(
                  IconCard: Icon(Icons.assignment_turned_in),
                  textCard: 'Attendance',
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardView1(
                  IconCard: Icon(Icons.assessment),
                  textCard: 'Home Work',
                ),
                CardView1(
                  IconCard: Icon(Icons.bar_chart),
                  textCard: 'Result',
                )
              ],
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Teachers',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                icon_teacher(img: 'assets/images/teacher.jpg'),
                icon_teacher(img: 'assets/images/6.jpg'),
                icon_teacher(img: 'assets/images/4.jpg'),
                icon_teacher(img: 'assets/images/3.jpg'),
                icon_teacher(img: 'assets/images/4.jpg'),
                icon_teacher(img: 'assets/images/3.jpg'),
                icon_teacher(img: 'assets/images/6.jpg'),
                icon_teacher(img: 'assets/images/7.jpg'),
                icon_teacher(img: 'assets/images/6.jpg'),
                icon_teacher(img: 'assets/images/7.jpg'),
                icon_teacher(img: 'assets/images/6.jpg'),
              ]),
            )
          ],
        )
      ]),
    ));
  }
}

class CardView extends StatelessWidget {
  const CardView({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 270,
      child: Card(
        elevation: 8,
        child: GestureDetector(
          onTap: () => onPressedRouter(context, Profiledetail()),
          child: Column(
            children: [
              Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.only(top: 10),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/background.jpg',
                      fit: BoxFit.cover,
                    ),
                  )),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Đoàn Văn Sơn',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'K24 - CNTTA',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 13),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Tap to see profile',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardView1 extends StatelessWidget {
  final Icon IconCard;
  final String textCard;
  const CardView1({super.key, required this.IconCard, required this.textCard});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 140,
        child: Card(
          elevation: 4,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Attribute(text: textCard)));
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.only(top: 10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                          child: Container(
                              height: 70,
                              width: 70,
                              color: Colors.blue[100],
                              child: IconCard))),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    textCard,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
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

class Attribute extends StatelessWidget {
  final String text;
  const Attribute({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(text + ' Page'),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Back'),
                Icon(
                  Icons.arrow_back,
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class icon_teacher extends StatelessWidget {
  final String img;
  const icon_teacher({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 1, left: 5),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.asset(
            img,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

void onPressedRouter(BuildContext context, Widget page) {
  Navigator.push(
      context,
      PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // Slide từ phải sang trái
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          }));
}
