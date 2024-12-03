import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/Book_Now/screens/select_vehicle.dart';
import 'package:flutter_easy_ride/Book_Now/provider/cab_book_provider.dart';
import 'package:provider/provider.dart';

import '../../common_widget/pickup_drop_widget.dart';
import '../../common_widget/rentale_recurring_location_add_widget.dart';
import '../../view/map/map_screen.dart';
import 'components/recurring_booking_detail_view.dart';
import 'components/select_recurring_rental_view.dart';

class RecurringLocationSelectView extends StatefulWidget {
  const RecurringLocationSelectView({super.key});

  @override
  State<RecurringLocationSelectView> createState() => _PickupScreenState();
}

class _PickupScreenState extends State<RecurringLocationSelectView> {
  final pickupController = TextEditingController();
  final dropController = TextEditingController();
  @override
  void initState() {
    super.initState();

    Provider.of<CabBookProvider>(context, listen: false).getCurrentLocation();
  }
  @override
  void dispose() {
    pickupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cabProvider = Provider.of<CabBookProvider>(context);
    if (cabProvider.pickupLocation != null||cabProvider.dropLocation!=null) {
      pickupController.text = cabProvider.pickupLocation!;
      dropController.text=cabProvider.dropLocation??"";
    }
    return Scaffold(
      backgroundColor: const Color(0xfff3fdf6),
      appBar: AppBar(
        backgroundColor: Color(0xff1937d7),
        title: Text('Create Recurring Package',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
              fontSize: 17,
              color: Colors.white
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,size: 21,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body:Column(
        children: [
          RentaleRecurringLocationAddWidget(
            pickupController: pickupController,
            dropController: dropController, onChange: (value) {
            cabProvider.placeAutoComplete(value,"Drop");
          },
          ),
          Divider(
            thickness: 1.5,
            color: Colors.grey.shade300,
          ),

          if(cabProvider.suggetions.isNotEmpty)
            Container(
                height: 100,
                child: ListView.builder(
                  itemCount: cabProvider.suggetions.length,
                  itemBuilder: (context, index) =>
                      InkWell(
                        onTap: (){
                          cabProvider.getDropLocation(cabProvider.suggetions[index].placePrediction.text.text??"",cabProvider.suggetions[index].placePrediction.placeId??"","Recuring");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.watch_later_outlined,
                                    color: Colors.grey.shade800,size: 20,),
                                  SizedBox(width: 10,),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.8,
                                    child: Text(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis, // Show ellipsis if text exceeds the limit
                                      cabProvider.suggetions[index].placePrediction.text.text??"dehradun",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade800,
                                        fontFamily: 'Poppins', // Set Poppins as the default font

                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Divider(color: Colors.grey.shade200,)
                            ],
                          ),
                        ),
                      ),
                )),



          Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SelectRecurringRentalView()));
            },
            child: Container(
              //  margin: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
              height: 44,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xff1937d7),
              ),
              child:const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Continue",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins', // Set Poppins as the default font
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}




