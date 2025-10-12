import 'package:flutter/material.dart';
import 'package:packages/constants/colors.dart';
import 'package:packages/models/film.dart';

class SearchItem extends StatelessWidget{
  final Film film;
  final VoidCallback onTap;

  const SearchItem({super.key, required this.film, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              color: film.poster != null && film.poster != '' ? null : AppColors.background,
              width: 40,
              height: 60,
              child: film.poster != null && film.poster != '' ? Image.network('https://image.tmdb.org/t/p/original${film.poster}', fit: BoxFit.cover,) : null
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Text(film.title, style: TextStyle(
                color: AppColors.color,
                fontSize: 14
              ),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}