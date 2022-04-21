import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verker_prof/blocs/query_cubit/query_cubit.dart';
import 'package:verker_prof/models/offer.dart';
import 'package:verker_prof/screens/make_offer_screen/materials/components/formats.dart';

class ViewOffer extends StatelessWidget {
  const ViewOffer({required this.offerId, Key? key}) : super(key: key);

  final String offerId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QueryCubit>(
      create: (context) => QueryCubit()..getOfferById(offerId),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
          ],
          backgroundColor: Colors.white.withOpacity(0.0),
        ),
        body: BlocBuilder<QueryCubit, QueryState>(
          builder: (context, state) {
            print(state);

            if (state is QueryLoadedOffer) {
              return offerDetails(state.offer);
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  ListView offerDetails(Offer offer) {
    double totalHourPrice = offer.hours! * offer.hourlyRate!;

    return ListView(
      padding: EdgeInsets.only(top: 10),
      children: [
        Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              largeText(
                  before: 'du har sendt et tilbud på', after: '21.499 Kr.'),
              SizedBox(height: 10),
              fromHeader(),
              SizedBox(height: 50),
            ],
          ),
        ),
        Container(
          color: Color(0xff184449),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Beskrivelse',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              Text(
                offer.description!,
                style: TextStyle(color: Colors.white),
              ),
              Divider(
                color: Colors.white,
                height: 50,
              ),
              row(before: 'Timer', after: kFormatQuantity.format(offer.hours)),
              SizedBox(height: 25),
              row(
                  before: 'Timepris',
                  after: kFormatCurrency.format(totalHourPrice)),
              SizedBox(height: 25),
              row(
                  before: 'Materialer',
                  after: kFormatCurrency.format(offer.materialPrice)),
              SizedBox(height: 25),
              row(before: 'Mulig opstart', after: '21 April 2022'),
              SizedBox(height: 25),
              row(
                  before: 'Estimeret tid',
                  after: '${offer.materials[0].quantity}'),
              SizedBox(height: 40)
            ],
          ),
        )
      ],
    );
  }

  Padding fromHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'fra virksomheden',
            style:
                TextStyle(fontSize: 22, color: Color.fromARGB(255, 93, 93, 93)),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREP7gIeSeG-GqLvJsIt3-vGz3TeiVUBWaJNw&usqp=CAU'),
                  ),
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Brians Tømrerbix',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '4420 Regstrup',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding largeText({required String before, required String after}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            before,
            style:
                TextStyle(fontSize: 22, color: Color.fromARGB(255, 93, 93, 93)),
          ),
          SizedBox(height: 10),
          Text(
            after,
            style: TextStyle(
              fontSize: 40,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Row row({required String before, required String after}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          before,
          style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontWeight: FontWeight.w500),
        ),
        Text(
          after,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
