import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:weatherapptwo/refactoring.dart';
import 'package:weatherendgame/refactoring.dart';

import 'apii.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:weatherapptwo/ModelApiii.dart';
//import 'package:weatherapptwo/apii.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  String timeItem = "";
  String imagee = "";

  final TextEditingController _controlField = TextEditingController();
  final StreamController _controller = StreamController();
  Icon CustomIcon = Icon(Icons.search);
  Widget CustomTitle = Text("location name");
  streamLoader({required String datas}) {
    btnWork(datas: datas).then((value) {
      _controller.add(value);
      time(result!.location!.localtime.toString().split(" ").last);
    });
  }
  storing()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.containsKey("city")){
      streamLoader(datas: preferences.getString("city").toString());
    }
  }


  time(String timevalue) {

    int hour = int.parse(timevalue.split(":").first);
    if (hour < 12) {
      setState(() {
        timeItem = timevalue + " AM";
      });
      if (hour >= 0 && hour < 5) {
        setState(() {
          imagee = "assets/bgi/night.jpg";
        });
      } else if (hour >= 5 && hour < 10) {
        setState(() {
          imagee = "assets/bgi/morning.jpg";
        });
      }
    } else {
      setState(() {
        timeItem = '${hour - 12}' + ":" + timevalue.split(":").last + ' PM';
      });
      if (hour >= 12 && hour < 15) {
        setState(() {
          imagee = "assets/bgi/afternoon.jpg";
        });
      } else if (hour >= 15 && hour < 18) {
        setState(() {
          imagee = "assets/bgi/evening.jpg";
        });
      } else if (hour >= 18 && hour < 24) {
        setState(() {
          imagee = "assets/bgi/night.jpg";
        });
      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    storing();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CustomTitle,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (CustomIcon.icon == Icons.search) {
                    if (CustomIcon.icon == Icons.search) {
                      CustomIcon = Icon(Icons.cancel);
                      CustomTitle = ListTile(
                        leading: Icon(Icons.search),
                        title: TextField(
                          autofocus: true,
                          onSubmitted: (value) {
                            streamLoader(datas: value);
                          },
                          controller: _controlField,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Search..."),
                        ),
                      );
                    }
                  } else {
                    CustomIcon = Icon(Icons.search);
                    CustomTitle = Text("location name");
                  }
                });
              },
              icon: CustomIcon)
        ],
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: StreamBuilder(
              stream: _controller.stream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(imagee), fit: BoxFit.cover)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            result!.location!.localtime
                                .toString()
                                .split(" ")
                                .first,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "date",
                              color: result!.current!.isDay == 1
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 28),
                          child: Text(
                            timeItem.toString(),
                            style: TextStyle(
                              fontSize: 73,
                              fontFamily: "date",
                              color: result!.current!.isDay == 1
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            result!.location!.country.toString(),
                            style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: result!.current!.isDay == 1
                                    ? Colors.black
                                    : Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        result!.current!.isDay == 1
                            ? Container(
                          height:
                          MediaQuery.of(context).size.height * .15,
                          width: MediaQuery.of(context).size.width * .35,
                          child: Image.asset("assets/day/sunn.png"),
                        )
                            : Container(
                          height:
                          MediaQuery.of(context).size.height * .25,
                          width: MediaQuery.of(context).size.width * .45,
                          child: Image.asset("assets/day/starr.png"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              result!.current!.tempC.toString(),
                              style: TextStyle(
                                fontSize: 35,
                                color: result!.current!.isDay == 1
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 18),
                                child: Text(
                                  "o",
                                  style: TextStyle(
                                    color: result!.current!.isDay == 1
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 58.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Column(
                              //   children: [
                              //     Text("Cloud",style: TextStyle(color: result!.current!.isDay == 1
                              //         ?  Colors.black
                              //         : Colors.white,fontFamily: "clouds"),),
                              //     Icon(Icons.cloud,color: result!.current!.isDay == 1
                              //     ? Colors.black
                              //         : Colors.white,),
                              //     Text(result!.current!.cloud.toString(),style: TextStyle(color: result!.current!.isDay == 1
                              //     ? Colors.black
                              //         : Colors.white,),)
                              //   ],
                              // ),
                              Refactor(
                                itemName: "cloud",
                                itemIcon: Icons.cloud,
                                isDay: result!.current!.isDay!.toInt(),
                                value: result!.current!.cloud.toString(),
                              ),

                              Refactor(
                                itemName: "Temp_c",
                                itemIcon: Icons.cloud,
                                value: result!.current!.tempC.toString(),
                                isDay: result!.current!.isDay!.toInt(),
                              ),
                              // Column(
                              //   children: [
                              //     Text(
                              //       "Temp_f",
                              //       style: TextStyle(
                              //           color: result!.current!.isDay == 1
                              //               ? Colors.black
                              //               : Colors.white,
                              //           fontFamily: "clouds"),
                              //     ),
                              //     Icon(
                              //       FontAwesomeIcons.cloudSun,
                              //       color: result!.current!.isDay == 1
                              //           ? Colors.black
                              //           : Colors.white,
                              //     ),
                              //     Text(
                              //       result!.current!.tempF.toString(),
                              //       style: TextStyle(
                              //         color: result!.current!.isDay == 1
                              //             ? Colors.black
                              //             : Colors.white,
                              //       ),
                              //     )
                              //   ],
                              // ),


                              Column(
                                children: [
                                  Text(
                                    "Wind_degree",
                                    style: TextStyle(
                                        color: result!.current!.isDay == 1
                                            ? Colors.black
                                            : Colors.white,
                                        fontFamily: "clouds"),
                                  ),
                                  Icon(
                                    FontAwesomeIcons.wind,
                                    color: result!.current!.isDay == 1
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                  Text(
                                    result!.current!.windDegree.toString(),
                                    style: TextStyle(
                                      color: result!.current!.isDay == 1
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Humidity",
                                    style: TextStyle(
                                        color: result!.current!.isDay == 1
                                            ? Colors.black
                                            : Colors.white,
                                        fontFamily: "clouds"),
                                  ),
                                  Icon(
                                    FontAwesomeIcons.solidSun,
                                    color: result!.current!.isDay == 1
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                  Text(
                                    result!.current!.humidity.toString(),
                                    style: TextStyle(
                                      color: result!.current!.isDay == 1
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
                if (snapshot.connectionState != ConnectionState.done) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData &&
                    ConnectionState == ConnectionState.done) {
                  return Center(
                    child: Text("no datas"),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("something went wrong"),
                  );
                }

                return Container();
              })),
    );
  }

  btnWork({required String datas}) async {
    SharedPreferences preferences =await SharedPreferences.getInstance();
    preferences.setString("city", datas);
    result = await getApii(datas: datas);
    return result;
  }
}