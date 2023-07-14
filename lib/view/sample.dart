import 'package:flutter/material.dart';

class ScrollingOpacityPage extends StatefulWidget {
  @override
  _ScrollingOpacityPageState createState() => _ScrollingOpacityPageState();
}

class _ScrollingOpacityPageState extends State<ScrollingOpacityPage> {
  late ScrollController _scrollController;
  double opacityValue = 1.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      opacityValue = (_scrollController.position.maxScrollExtent - _scrollController.offset) / 200.0;
      opacityValue = opacityValue.clamp(0.0, 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scrolling Opacity Demo'),
      ),
      body: GridView.builder(
        controller: _scrollController,
        itemCount: 20, // Number of containers
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          double itemOpacity = opacityValue - (index * 0.1);
          itemOpacity = itemOpacity.clamp(0.0, 1.0);
          if (itemOpacity <= 0.0) {
            return SizedBox.shrink(); // Hide the topmost container
          } else {
            return Opacity(
              opacity: itemOpacity,
              child: Container(
                margin: EdgeInsets.all(8),
                color: Colors.blue,
                height: 100,
                child: Center(
                  child: Text(
                    'Container ${index + 1}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}


