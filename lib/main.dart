
import 'Constant/component.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => MyAppState();
}
class MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GetMaterialApp(
        initialBinding: ControllerBinding(),
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Color(0xFFF6F6F8),
            appBarTheme: AppBarTheme(),
            primarySwatch: Colors.blue,
            primaryColor: Color.fromRGBO(48, 49, 52, 1.0),
            hintColor: Color(int.parse('0xff2399CC')),
            iconTheme: IconThemeData(color: Colors.white),
            fontFamily: 'DMSans_Regular',
        ),

        home: MainScreen());
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {

  bool isCollapsed = true;
  late double scWidth, scHeight;
  final Duration duration = const Duration(milliseconds: 500);
  late AnimationController _controller;

  AppBar appBar = AppBar();
  double borderRadius = 0.0;
  // _navBarIndex=0;
  int pageIndex = 0;
  late TabController tabController;
  BookingController bookingController=Get.put(BookingController());
  PackageController packageContoller=Get.put(PackageController());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
  }

  @override
  void dispose() {
    _controller.dispose();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      setState(() {
        // _navBarIndex = tabController.index;
      });
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    scHeight = size.height;
    scWidth = size.width;

    return WillPopScope(
      onWillPop: () async {
        if (!isCollapsed) {
          setState(() {
            _controller.reverse();
            borderRadius = 0.0;
            isCollapsed = !isCollapsed;
          });
          return false;
        } else
          return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: <Widget>[
            menu(context),
            AnimatedPositioned(
                left: isCollapsed ? 0 : 0.6 * scWidth,
                right: isCollapsed ? 0 : -0.2 * scWidth,
                top: isCollapsed ? 0 : scHeight * 0.05,
                bottom: isCollapsed ? 0 : scHeight * 0.05,
                duration: duration,
                curve: Curves.fastOutSlowIn,
                child: dashboard(context)),
          ],
        ),
      ),
    );
  }

  Widget menu(context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 32.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: 0.6,
            heightFactor: 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Appcolors.appthemeColorPink,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            child: CachedNetworkImage(
                              imageUrl:  ApiEndPoints.profile,
                              width: 75,
                              height: 75,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Image.asset('assets/images/profile.png'),
                            ),
                          ),
                        ],
                      ),
                    ),


                    Text(
                      'Emily Cyrus',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0,color: Appcolors.appthemeColorPink),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      if (isCollapsed) {
                        _controller.forward();

                        borderRadius = 16.0;
                      } else {
                        _controller.reverse();

                        borderRadius = 0.0;
                      }

                      isCollapsed = !isCollapsed;
                    });
                  },
                  child: Text(
                    'Home',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0,color: Appcolors.themTextColor),
                  ),
                ),
                SizedBox(height: 15),
                Divider(height: 0.5,color: Appcolors.dividerColorPink,endIndent: 60,),
                SizedBox(height: 15),
                Text(
                  'Book A Nanny',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0,color: Appcolors.themTextColor),
                ),
                SizedBox(height: 15),
                Divider(height: 0.5,color: Appcolors.dividerColorPink,endIndent: 60,),
                SizedBox(height: 15),

                Text(
                  'How It Works',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0,color: Appcolors.themTextColor),
                ),
                SizedBox(height: 15),
                Divider(height: 0.5,color: Appcolors.dividerColorPink,endIndent: 60,),
                SizedBox(height: 15),

                Text(
                  'Why Nanny Vanny',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0,color: Appcolors.themTextColor),
                ),
                SizedBox(height: 15),
                Divider(height: 0.5,color: Appcolors.dividerColorPink,endIndent: 60,),
                SizedBox(height: 15),

                Text(
                  'My Bookings',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0,color: Appcolors.themTextColor),
                ),
                SizedBox(height: 15),
                Divider(height: 0.5,color: Appcolors.dividerColorPink,endIndent: 60,),
                SizedBox(height: 15),
                Text(
                  'My Profile',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0,color: Appcolors.themTextColor),
                ),
                SizedBox(height: 15),
                Divider(height: 0.5,color: Appcolors.dividerColorPink,endIndent: 60,),
                SizedBox(height: 15),
                Text(
                  'Support',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0,color: Appcolors.themTextColor),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
    // ),
    // )
  }

  Padding buildMyNavBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0, 0.0, 0.0),
      child: Container(
        height: 80,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: (){
                   pageIndex = 0;
                  setState(() {


                  });
                },
                child: Column(
                  children: [
                    IconButton(
                        enableFeedback: false,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: ()  {
                          setState(() {

                             pageIndex = 0;
                          });
                        },
                        icon: pageIndex == 0
                            ? Icon(Icons.home_outlined,size: 25.0,color: Appcolors.appthemeColorPink,)
                            : Icon(Icons.home_outlined,size: 25.0,color: Colors.white,)),
                    Text(
                      "Home",
                      style: TextStyle(
                          color: pageIndex == 0
                              ?  Appcolors.appthemeColorPink
                              :  Colors.black,
                          fontFamily: 'DMSans_Regular',
                          fontSize: 12,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  pageIndex = 1;
                  setState(() {


                  });
                },
                child: Column(
                  children: [
                    IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        enableFeedback: false,
                        onPressed: () {


                          setState(() {
                            pageIndex = 1;
                          });
                        },
                        icon: pageIndex == 1
                            ? Icon(Iconsax.discount_shape,size: 25.0,color: Appcolors.appthemeColorPink,)
                            : Icon(Iconsax.discount_shape,size: 25.0,color: Colors.black,)),
                    Text(
                      "Packages",
                      style: TextStyle(
                          color: pageIndex == 1
                              ?  Appcolors.appthemeColorPink
                              : Colors.black,
                          fontFamily: 'DMSans_Regular',
                          fontSize: 12,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  pageIndex = 2;
                  setState(() {


                  });
                },
                child:  Column(
                  children: [
                    IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        enableFeedback: false,
                        onPressed: () {


                          setState(() {
                            pageIndex = 2;
                          });
                        },
                        icon: pageIndex == 2
                            ? Icon(Iconsax.clock,size: 25.0,color: Appcolors.appthemeColorPink,)
                            : Icon(Iconsax.clock,size: 25.0,color: Colors.black,)
                    ),
                    Text(
                      "Bookings",
                      style: TextStyle(
                          color: pageIndex == 2
                              ?  Appcolors.appthemeColorPink
                              :  Colors.black,
                          fontFamily: 'DMSans_Regular',
                          fontSize: 12,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  pageIndex = 3;
                  setState(() {

                  });
                },
                child: Column(
                  children: [
                    IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        enableFeedback: false,
                        onPressed: () {
                          setState(() {
                             pageIndex = 3;
                          });
                        },
                        icon: pageIndex == 3
                            ? Icon(Iconsax.user_octagon,size: 25.0,color: Appcolors.appthemeColorPink,)
                            : Icon(Iconsax.user_octagon,size: 25.0,color:Colors.black,)),
                    Text(
                      "Profile",
                      style: TextStyle(
                          color: pageIndex == 3
                              ?  Appcolors.appthemeColorPink
                              :  Colors.black,
                          fontFamily: 'DMSans_Regular',
                          fontSize: 12,
                          fontWeight: FontWeight.w600
                      ),
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


  Widget dashboard(context) {
    return SafeArea(
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        type: MaterialType.card,
        animationDuration: duration,
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: 8,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          child: Scaffold(
            bottomNavigationBar: buildMyNavBar(context),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              if (isCollapsed) {
                                _controller.forward();

                                borderRadius = 16.0;
                              } else {
                                _controller.reverse();

                                borderRadius = 0.0;
                              }

                              isCollapsed = !isCollapsed;
                            });
                          },
                            child: Icon(Iconsax.textalign_right,size: 25.0,color: Appcolors.appthemeColorPink,),
                            ),



                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Appcolors.appthemeColorPink,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                child: CachedNetworkImage(
                                  imageUrl: ApiEndPoints.profile,
                                  width: 55,
                                  height: 55,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Image.asset('assets/images/profile.png'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20,),
                        Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,color: Appcolors.themTextColor),
                            ),
                            Text(
                              'Emily Cyrus',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0,color: Appcolors.appthemeColorPink),
                            ),
                          ],
                        ),

                      ],
                    ),
                    SizedBox(height: 30,),

                Stack(
                  children: [
                    // Container with text and button
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Appcolors.cardBack,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)), // Border radius for the container
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 30.0),
                              child: Text(
                                "Nanny And \nBabysitting Service",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.0,
                                  color: Appcolors.appthemeColor, // Your theme color
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color:Appcolors.appthemeColor, // Your theme color
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                  child: Text(
                                    "Book Now",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Positioned image of baby and mother
                    Positioned(
                      top: -30, // Adjust based on the image size and positioning
                      right: -20, // Aligns image to the right
                      child: Image.asset(
                        'assets/image/baby_and_mother.png', // Your image asset path
                        width: 200,
                        height: 200,// Adjust size as needed
                      ),
                    ),
                  ],
                ),

                    SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Your Current Booking',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,color: Appcolors.appthemeColor),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),

                    Obx(()=>ListView.builder(
                        shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: bookingController.bookingList.length,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)), // Add border radius here
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 1), // Adjust the offset if needed
                                      blurRadius: 1, // Increase the blur radius
                                      spreadRadius: 1, // Increase the spread radius
                                      color: Colors.grey.shade200, // Adjust the opacity of the shadow color
                                    ),
                                  ],
                                ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          bookingController.bookingList[index].title,
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0,color: Appcolors.appthemeColorPink),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Appcolors.appthemeColorPink,
                                              borderRadius: BorderRadius
                                                  .all(Radius
                                                  .circular(
                                                  20.0)),),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets
                                                .symmetric(
                                                horizontal:
                                                15.0),
                                            child: Text(
                                              "Start",
                                              style:
                                              TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "From",
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Appcolors.themTextColor,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(height: 5.0,),

                                                Row(
                                                  children: [
                                                    Icon(Iconsax.calendar_2,size: 15.0,color: Appcolors.appthemeColorPink,),
                                                    SizedBox(width: 5,),
                                                    Text(
                                                      bookingController.bookingList[index].fromDate ,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Appcolors.themTextColor,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5.0,),

                                                Row(
                                                  children: [
                                                    Icon(Iconsax.clock,size: 15.0,color: Appcolors.appthemeColorPink,),
                                                    SizedBox(width: 5,),
                                                    Text(
                                                      bookingController.bookingList[index].fromTime,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Appcolors.themTextColor,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "To",
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Appcolors.themTextColor,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(height: 5.0,),

                                                Row(
                                                  children: [
                                                    Icon(Iconsax.calendar_2,size: 15.0,color: Appcolors.appthemeColorPink,),
                                                    SizedBox(width: 5,),
                                                    Text(
                                                      bookingController.bookingList[index].toDate ,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Appcolors.themTextColor,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5.0,),

                                                Row(
                                                  children: [
                                                    Icon(Iconsax.clock,size: 15.0,color: Appcolors.appthemeColorPink,),
                                                    SizedBox(width: 5,),
                                                    Text(
                                                      bookingController.bookingList[index].toTime,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Appcolors.themTextColor,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Appcolors.appthemeColor,
                                            borderRadius: BorderRadius
                                                .all(Radius
                                                .circular(
                                                20.0)),),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                                            child: Row(
                                              children: [
                                                Icon(Iconsax.star,size: 15.0,color: Colors.white,),
                                                SizedBox(width: 5,),
                                                Text(
                                                  "Rate Us",
                                                  style:
                                                  TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        Container(
                                          decoration: BoxDecoration(
                                            color: Appcolors.appthemeColor,
                                            borderRadius: BorderRadius
                                                .all(Radius
                                                .circular(
                                                20.0)),),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                                            child: Row(
                                              children: [
                                                Icon(Iconsax.map,size: 15.0,color: Colors.white,),
                                                SizedBox(width: 5,),
                                                Text(
                                                  "Geolocation",
                                                  style:
                                                  TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        Container(
                                          decoration: BoxDecoration(
                                            color: Appcolors.appthemeColor,
                                            borderRadius: BorderRadius
                                                .all(Radius
                                                .circular(
                                                20.0)),),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                                            child: Row(
                                              children: [
                                                Icon(Iconsax.microphone,size: 15.0,color: Colors.white,),
                                                SizedBox(width: 5,),
                                                Text(
                                                  "Survillence",
                                                  style:
                                                  TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),


                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Packages',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,color: Appcolors.appthemeColor),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),

                    Obx(()=>ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: packageContoller.packageList.length,
                        itemBuilder: (BuildContext context, index) {
                          Color containerColor = index % 2 == 0 ? Appcolors.cardBack : Appcolors.cardBack2;
                          Color buttonColor = index % 2 == 0 ? Appcolors.buttonback : Appcolors.buttonback2;
                          return Padding(
                            padding: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(5.0)),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: containerColor,
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 0),
                                        blurRadius: 1,
                                        spreadRadius: 1,
                                        color: Colors.grey.shade400,
                                      ),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          Icon(Iconsax.calendar,size: 25.0,color: Appcolors.appthemeColorPink,),

                                          Container(
                                            decoration: BoxDecoration(
                                              color: buttonColor,
                                              borderRadius: BorderRadius
                                                  .all(Radius
                                                  .circular(
                                                  20.0)),),
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                                              child: Text(
                                                "Book Now",
                                                style:
                                                TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),

                                      SizedBox(height: 20,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            packageContoller.packageList[index].title,
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0,color: Appcolors.appthemeColor),
                                          ),

                                          Text(
                                            "₹ ${packageContoller.packageList[index].price}",
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0,color: Appcolors.appthemeColor),
                                          ),

                                        ],
                                      ),
                                      SizedBox(height: 10,),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              packageContoller.packageList[index].desc,
                                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0,color: Appcolors.themTextColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                    )
                  ],
                ),
              )
            ),
          ),
        ),
      ),
    );
  }
}

