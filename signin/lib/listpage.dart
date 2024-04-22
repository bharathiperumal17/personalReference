import 'package:flutter/material.dart';
import 'package:signin/details.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions:const [
           Center(
            child:  Text(
              'Skip this Step',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(colors: [
                      Color.fromRGBO(255, 255, 255, 1),
                      // Colors.blueGrey,
                      Colors.purple
                    ]).createShader(bounds),
                child: const Text(
                  "What topic do you like? ",
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 445,
                    width: 300,
                    child: Wrap(
                      children: List.generate(details.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            // print('Selected Item: ${details[index].text}');
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: 138,
                            height: 65,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  details[index].image,
                                  height: 34,
                                  width: 34,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  details[index].text,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Everything',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontStyle: FontStyle.italic
                      ),),
                      Image.asset( "asset/image/36853-3-hand-emoji-thumb.png" ,
                      height:40,)
                    ],
                  ),
            ),




            const SizedBox(height: 25,),
                       Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      backgroundColor:
                           MaterialStatePropertyAll(Colors.purple.withOpacity(0.5)),
                      padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                      )),
                  onPressed: () {
                    
                  },
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Next ',
                        style: TextStyle(
                            color: Colors.white70,
                            fontStyle: FontStyle.italic,
                            fontSize: 22),
                      ),
                      Image.asset( "asset/image/36853-3-hand-emoji-thumb.png" ,
                      height: 26,)

                    ],
                  ),
                ),
              ),
          const SizedBox(height: 55,)
          ],
        ),
      ),
    );
  }
}