import 'package:flutter/material.dart';

class MenuManager extends StatelessWidget {
  const MenuManager({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> gridData = [
      {
        "title": "Deli Combo",
        "price": "Rp 34.800",
        "image": "lib/assets/image1.png",
      },
      {
        "title": "Snack Pack",
        "price": "Rp 29.800",
        "image": "lib/assets/image2.png",
      },
      {
        "title": "Drink Combo",
        "price": "Rp 24.800",
        "image": "lib/assets/image3.png",
      },
      {
        "title": "Snack Pack",
        "price": "Rp 29.800",
        "image": "lib/assets/image2.png",
      },
    ];

    return SizedBox(
      height: 360,
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.only(top: 15, left: 36, right: 36),
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Jumlah kolom
                crossAxisSpacing: 20, // Jarak kolom
                mainAxisSpacing: 20, // Jarak baris
              ),
              itemCount: gridData.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => Menuuu(),
                    //   ),
                    // );
                  },
                  child: SizedBox(
                    width: 125,
                    child: Stack(
                      children: [
                        Positioned(
                          child: Container(
                            width: 151,
                            height: 179,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(1, 1),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 8,
                          top: 132,
                          child: Text(
                            gridData[index]['price'],
                            style: const TextStyle(
                              color: Color(0xFF6D6565),
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 150,
                            height: 102,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: AssetImage(gridData[index]['image']),
                                fit: BoxFit.cover,
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 8,
                          top: 108,
                          child: Text(
                            gridData[index]['title'],
                            style: const TextStyle(
                              color: Color(0xFF271F1F),
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
