import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/features/address/models/address.dart';
import 'package:verker_prof/utils/theme/constants/colors.dart';
import 'package:verker_prof/utils/theme/constants/textstyle.dart';

class VerkerSearchResult extends StatelessWidget {
  VerkerSearchResult({
    Key? key,
    required this.result,
    required this.onSearchTap,
    this.onCurrentLocationTap,
  }) : super(key: key);

  final dynamic Function()? onCurrentLocationTap;
  final void Function(Address address) onSearchTap;

  final List<Address> result;

  @override
  Widget build(BuildContext context) {
    List<Widget> searchResults = [
      const SizedBox(height: 15),
      InkWell(
        onTap: onCurrentLocationTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 250, 250, 250),
            border: Border.symmetric(
              horizontal: BorderSide(color: kGreyColor, width: 0.5),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: kGreenColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: const Icon(
                      Icons.location_on,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Brug min nuværende lokation',
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
              const Icon(Icons.arrow_forward_rounded)
            ],
          ),
        ),
      ),
      const SizedBox(height: 15),
    ];
    searchResults.addAll(result
        .map(
          (element) => InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              onSearchTap(element);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 30,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            element.address,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            element.zip,
                            style: const TextStyle(color: kGreyText),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: kGreyColor,
                  thickness: 0.5,
                ),
              ],
            ),
          ),
        )
        .toList());
    return Column(
      children: searchResults,
    );
  }
}

class VerkerSelectedValue extends StatelessWidget {
  const VerkerSelectedValue({
    required this.location,
    required this.onClear,
    Key? key,
  }) : super(key: key);

  final Address location;
  final void Function() onClear;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location.address,
                      style: kMediumBold,
                      overflow: TextOverflow.clip,
                    ),
                    Text(
                      location.zip,
                      style: kSmallRegular,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onClear,
                icon: Icon(Icons.delete),
              )
            ],
          ),
        ),
      ],
    );
  }
}
