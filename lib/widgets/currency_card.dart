import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0); // 좌측 상단
    path.lineTo(size.width - 30, 0); // 오른쪽 상단에서 약간 떨어진 지점
    path.lineTo(size.width, 30); // 오른쪽 상단에서 약간 아래로 내려옴
    path.lineTo(size.width, size.height); // 우측 하단
    path.lineTo(30, size.height); // 좌측 하단에서 약간 떨어진 지점
    path.lineTo(0, size.height - 30); // 좌측 하단에서 약간 떨어진 지점
    path.lineTo(0, 0); // 좌측 상단
    path.close(); // 패스를 닫아 삼각형을 만듦
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CurrencyCard extends StatelessWidget {
  final double order;
  final String name, code, amount;
  final IconData icon;
  final bool isInverted;

  final blackColor = const Color(0xFF1F2123);

  const CurrencyCard({
    super.key,
    required this.order,
    required this.name,
    required this.code,
    required this.amount,
    required this.icon,
    required this.isInverted,
  });

  @override
  Widget build(BuildContext context) => Transform.translate(
        offset: Offset(0, order * -20),
        child: ClipPath(
          clipper: DiagonalClipper(),
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: isInverted ? Colors.white : blackColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(40),
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(40),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(
                30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          color: isInverted ? blackColor : Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            amount,
                            style: TextStyle(
                              color: isInverted ? blackColor : Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            code,
                            style: TextStyle(
                              color: isInverted ? blackColor : Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Transform.scale(
                    scale: 2.1,
                    child: Transform.translate(
                      offset: const Offset(-6, 13),
                      child: Icon(
                        icon,
                        color: isInverted ? blackColor : Colors.white,
                        size: 78,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
