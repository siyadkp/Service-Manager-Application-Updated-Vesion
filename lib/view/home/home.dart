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
      backgroundColor:  const Color.fromARGB(255, 255, 255, 255),
      // KColors.ScaffoldBackgrountColor,
    
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: size.height / 3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromRGBO(78, 158, 255, 0.769),
           

              Color.fromRGBO(22, 105, 207, 1)
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SafeArea(
                      child: Padding(
                    padding: EdgeInsets.only(
                        left: size.width / 1.18, top: height / 8),
                    child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ScreenSettings(),
                            )),
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage('asset/user.jpeg'),
                        )),
                  )),
                  const SizedBox(height: 50,),
                   const Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                ],
              ),
            ),
            HomeServiceCardsSection(size: size),
           
          ],
        ),
      ),
    );
  }
}

class HomeServiceCardsSection extends StatelessWidget {
  const HomeServiceCardsSection({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height / 1.494,
      width: double.infinity,
      child: ListView(
        children: [
          Column(
            children: [
              Container(
                height: 720,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: 5,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 230,
                    crossAxisCount: 2,
                    mainAxisSpacing: 7,
                    crossAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) => Builder(
                    builder: (context) {
                      return ServiceCardWidget(
                        image: images[index],
                        index: index,
                        text: serviceCardNames[index],
                        top: index == 3 ? 10 : 20,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10,)
            ],
          ),
        ],
      ),
    );
  }
}
