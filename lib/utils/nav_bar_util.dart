import 'package:flutter/material.dart';
import 'package:flutter_d0601/page/widgets/parent_ink_well_widget.dart';
import 'package:flutter_d0601/utils/screen_util.dart';
import '../app_style/font_style.dart';


class NavBarUtil extends StatefulWidget {
  final List<String> title;
  final TextStyle? unChooseTextStyle;
  final TextStyle? chooseTextStyle;
  final String? asset;
  late  int currentIndex;
  ///interval
  final double? interval;
  final Function? onTap;
  NavBarUtil({Key? key, required this.title, this.asset, this.onTap, required this.currentIndex, this.interval, this.unChooseTextStyle, this.chooseTextStyle}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NavBarUtilState createState() => _NavBarUtilState();
}

class _NavBarUtilState extends State<NavBarUtil> with SingleTickerProviderStateMixin{


  // late AnimationController _animationController;
  //
  // late Animation _animation;
  late TextStyle chooseTextStyle;
  late TextStyle  unChooseTextStyle;



  @override
  void initState() {
    super.initState();
    chooseTextStyle=widget.chooseTextStyle??getFontStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      fontHeight: 1.2,
    );
    unChooseTextStyle= widget.unChooseTextStyle??getFontStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      fontHeight: 1.4,
      letterSpacing: 0.2,
      color: const Color(0xFF828C9D),
    );
    // _animationController = AnimationController(duration: const Duration(milliseconds: 9000),vsync: this);
    // _animationController.addListener(() {
    //   setState(() {});
    // });
    // // _animation = CurvedAnimation(parent: _animationController,curve: Curves.easeInOutCubic);
    // _animation = Tween(begin: unChooseTextStyle,end: chooseTextStyle).animate(_animationController);
    // _animationController.forward();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        height: MediaQuery.of(context).padding.top+kToolbarHeight,
        width: double.infinity,
        color: Colors.white,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.title.length,
            itemBuilder: (context,index){
              return ParentInkWellWidget(
                borderRadius: const BorderRadius.all(Radius.circular(0)),
                onTap: (){
                  // if(_animationController.isCompleted){
                  //   _animationController.reset();
                  // }
                  // _animationController.forward();
                  setState(() {
                    widget.currentIndex=index;
                  });
                  widget.onTap?.call(index);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.setWidth()),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedDefaultTextStyle(
                        style: unChooseTextStyle,
                        duration: const Duration(milliseconds: 1200),
                        child: Text(
                          widget.title[index],key: ValueKey(widget.currentIndex),style: widget.currentIndex==index?chooseTextStyle:unChooseTextStyle,),
                      ),
                      Positioned(
                        // left: ((widget.interval??0)-widget.currentIndex)*100,
                        // right: ((widget.interval??0)-widget.currentIndex)*100,
                          left: 0,
                          right: 0,
                          bottom: kToolbarHeight/4,
                          child: Offstage(
                            offstage: widget.currentIndex!=index,
                            child: Container(
                              key: ValueKey(widget.currentIndex),
                              height: 6.setHeight(),
                              decoration:  BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.all(Radius.circular(19.setRadius())),
                                  gradient: const LinearGradient(
                                    begin: Alignment.bottomRight,
                                    end: Alignment.topLeft,
                                    colors:  [Color(0xFF3A89FF), Color(0xFF7F30FF),Color(0xFFDB3EFF),],
                                  )
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              );
            } ),
      ),
    );
  }
}

