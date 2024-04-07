import 'package:flutter/material.dart';

class LocalCategoryActionChipModel {
  final int id;
  final String label;
  final String imageAsset;
  final VoidCallback onPressed;

  LocalCategoryActionChipModel({
    required this.id,
    required this.label,
    required this.imageAsset,
    required this.onPressed,
  });
}

final List<LocalCategoryActionChipModel> localCategoryActionChipModelList = [
  LocalCategoryActionChipModel(
    id: 1,
    label: "Anatomy",
    imageAsset: "assets/images/png/human-anatomy.png",
    onPressed: () {},
  ),
  LocalCategoryActionChipModel(
    id: 2,
    label: "Biochemistry",
    imageAsset: "assets/images/png/biochemistry.png",
    onPressed: () {},
  ),
  LocalCategoryActionChipModel(
    id: 3,
    label: "Physiology",
    imageAsset: "assets/images/png/physiology.png",
    onPressed: () {},
  ),
  LocalCategoryActionChipModel(
    id: 4,
    label: "Pathology",
    imageAsset: "assets/images/png/oral-pathology.png",
    onPressed: () {},
  ),
  LocalCategoryActionChipModel(
    id: 5,
    label: "Microbiology",
    imageAsset: "assets/images/png/microbiology-bacteria.png",
    onPressed: () {},
  ),
  LocalCategoryActionChipModel(
    id: 6,
    label: "Pharmacology",
    imageAsset: "assets/images/png/pharmacology.png",
    onPressed: () {},
  ),
  LocalCategoryActionChipModel(
    id: 7,
    label: "FMT",
    imageAsset: "assets/images/png/physiology.png",
    onPressed: () {},
  ),
  LocalCategoryActionChipModel(
    id: 8,
    label: "Ophthalmology",
    imageAsset: "assets/images/png/ophthalmology.png",
    onPressed: () {},
  ),
  LocalCategoryActionChipModel(
    id: 9,
    label: "ENT",
    imageAsset: "assets/images/png/physiology.png",
    onPressed: () {},
  ),
  LocalCategoryActionChipModel(
    id: 10,
    label: "Community Medicine",
    imageAsset: "assets/images/png/medicine.png",
    onPressed: () {},
  ),
  LocalCategoryActionChipModel(
    id: 11,
    label: "Medicine",
    imageAsset: "assets/images/png/medicine.png",
    onPressed: () {},
  ),
  LocalCategoryActionChipModel(
    id: 12,
    label: "Dermatology",
    imageAsset: "assets/images/png/physiology.png",
    onPressed: () {},
  ),
  LocalCategoryActionChipModel(
    id: 13,
    label: "Psychiatry",
    imageAsset: "assets/images/png/physiology.png",
    onPressed: () {},
  ),
  LocalCategoryActionChipModel(
    id: 14,
    label: "Radiology",
    imageAsset: "assets/images/png/radiology.png",
    onPressed: () {},
  ),
  LocalCategoryActionChipModel(
    id: 15,
    label: "Orthopedics",
    imageAsset: "assets/images/png/orthopedic.png",
    onPressed: () {},
  ),
  LocalCategoryActionChipModel(
    id: 16,
    label: "Surgery",
    imageAsset: "assets/images/png/surgery.png",
    onPressed: () {},
  ),
  LocalCategoryActionChipModel(
    id: 17,
    label: "Anaesthesia",
    imageAsset: "assets/images/png/physiology.png",
    onPressed: () {},
  ),
  LocalCategoryActionChipModel(
    id: 18,
    label: "Pediatrics",
    imageAsset: "assets/images/png/physiology.png",
    onPressed: () {},
  ),
  LocalCategoryActionChipModel(
    id: 19,
    label: "Obs/Gyn",
    imageAsset: "assets/images/png/physiology.png",
    onPressed: () {},
  ),
  LocalCategoryActionChipModel(
    id: 20,
    label: "Elite",
    imageAsset: "assets/images/png/physiology.png",
    onPressed: () {},
  ),
  LocalCategoryActionChipModel(
    id: 21,
    label: "Image Bank",
    imageAsset: "assets/images/png/bank.png",
    onPressed: () {},
  ),
  LocalCategoryActionChipModel(
    id: 22,
    label: "High-Yield",
    imageAsset: "assets/images/png/physiology.png",
    onPressed: () {},
  ),
  LocalCategoryActionChipModel(
    id: 23,
    label: "Previous Year Question",
    imageAsset: "assets/images/png/paper.png",
    onPressed: () {},
  ),
  LocalCategoryActionChipModel(
    id: 24,
    label: "Dr. NJB",
    imageAsset: "assets/images/png/obs.png",
    onPressed: () {},
  ),
  LocalCategoryActionChipModel(
    id: 24,
    label: "NEET UG",
    imageAsset: "assets/images/png/physiology.png",
    onPressed: () {},
  ),
];
