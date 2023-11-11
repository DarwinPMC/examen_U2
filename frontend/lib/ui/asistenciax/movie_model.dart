import 'package:flutter/material.dart';

class MovieModel {
  final String movieTitle;
  final int movieRating;
  final String moviePoster;
  final String movieRelease;

  const MovieModel({
    required this.moviePoster,
    required this.movieTitle,
    required this.movieRating,
    required this.movieRelease,
  });
}
