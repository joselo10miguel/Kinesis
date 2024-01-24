import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/nav_provider.dart';
import 'dart:math';
import '../ruta.dart';

class CustomEntrenamientoButton extends StatelessWidget {
  final String titleCard;
  final Color colorCarta;
  final String estado;
  final VoidCallback? onPressed;

  CustomEntrenamientoButton({
    Key? key,
    required this.titleCard,
    required this.colorCarta,
    required this.estado,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final buttonWidth = size.width * 0.3;

    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: SizedBox(
        height: size.height * 0.8,
        width: buttonWidth * 0.3,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: colorCarta,
            elevation: 0,
            animationDuration: Duration.zero,
            side: const BorderSide(color: Colors.transparent),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      child: Text(
                        estado,
                        style: TextStyle(color: Colors.black45),
                      ),
                    ),
                  ),
                  Text(
                    titleCard,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
