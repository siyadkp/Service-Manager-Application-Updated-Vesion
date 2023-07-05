import 'package:flutter/material.dart';
import 'package:service_manager/core/colors.dart';
import 'package:service_manager/core/images.dart';
import 'package:service_manager/core/naming.dart';
import 'package:service_manager/view/home/widget/service_card_widget.dart';
import 'package:service_manager/view/settings/settings.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = 40;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: size.height / 3,
                  child: Card(
                    color: clrDarkBlue,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: clrDarkBlue,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SafeArea(
                    child: Padding(
                  padding:
                      EdgeInsets.only(left: size.width / 1.18, top: height / 8),
                  child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScreenSettings(),
                          )),
                      child: const CircleAvatar(
                        backgroundColor: Colors.amber,
                        radius: 25,
                        backgroundImage: AssetImage('asset/user.jpeg'),
                      )),
                )),
                Padding(
                  padding: const EdgeInsets.only(top: 270),
                  child: SizedBox(
                    height: size.height / 1.494,
                    width: double.infinity,
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 700,
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                itemCount: 5,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 230,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 7,
                                  crossAxisSpacing: 5,
                                ),
                                itemBuilder: (context, index) =>
                                    Builder(builder: (context) {
                                  return ServiceCardWidget(
                                    image: images[index],
                                    Index: index,
                                    text: serviceCardNames[index],
                                    top: index == 3 ? 10 : 20,
                                  );
                                },),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 160),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(
                        children: [
                          Column(
                            children: [
                              Text(
                                'Complete',
                                style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: 145,
                                child: Center(
                                  child: Text(
                                    '17566',
                                    style: TextStyle(
                                      fontSize: 28,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Pending',
                            style: TextStyle(
                              fontSize: 19,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 145,
                            child: Center(
                              child: Text(
                                '17566',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
