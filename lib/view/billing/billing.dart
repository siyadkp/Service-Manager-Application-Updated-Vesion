import 'package:flutter/material.dart';
import 'package:service_manager/view/billing/addbillproduct/add_bill_product.dart';
import 'package:service_manager/view/widget/dropdown_textformfield/dropdown_textformfield.dart';
import '../../core/colors.dart';
import '../../core/sizing.dart';
import '../widget/textformfiewld.dart';


class ScreenBilling extends StatelessWidget {
  const ScreenBilling({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 10),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(right:350),
            child: InkWell( onTap: () {
                        Navigator.pop(context);
                      }, child: Container(width: 40,height: 40,color: clrDarkBlue,child: const Icon(Icons.arrow_back,color: Colors.white,size: 30,),)),
          ),
          DropdownTextFormField(suggestions: ['hi','helo','das']),
          //  TopTextTextFormFieldWidget(height: 50,width: 370,text: 'Customer',fontsize: 20, controllerObj: TextEditingController(),screenName: ''),
            TopTextTextFormFieldWidget(height: 50,width: 370,text: 'Phone',controllerObj: TextEditingController(),screenName: ''),
                 TopTextTextFormFieldWidget(height: 200,width: 370,text: 'Billing Address :',maxLines: 7,condition: true,controllerObj: TextEditingController(),screenName: ''),
          Padding(
                padding: const EdgeInsets.only(left: 5,right: 10,top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Add Items',style: TextStyle(fontSize: 23,fontWeight: FontWeight.w500),),
                        InkWell(onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  ScreenAddBillProduct(),));
                        } ,child: Icon(Icons.add,size: 35,color: Colors.grey,))
                      ],
                    ),
                    const Divider(color: Colors.grey,thickness: 3),
                    Container(
                  
                      width: double.infinity,
                      height: 220,
                      child: ListView.builder(
                              itemBuilder: (context, index) {
                                
                              
                          return const AddProductSingleWidget();
                        },
                        itemCount: 4,
                      ),
                    ),
                     const Divider(color: Colors.grey,thickness: 3),
              
                  ],
                ),
              ),
               const Padding(
                     padding: EdgeInsets.only(top: 25,bottom: 20,right: 140),
                     child: Text('Total Amount : 3679',style:TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
                   ),
                   
              
                ElevatedButton(
                  onPressed: () {},style: ElevatedButton.styleFrom(
            backgroundColor: clrDarkBlue,
           
          ),
                  child: const Text('Create Bill'),
                ),
                kHeight20
        ]),
      ),
    ));
  }
}
class AddProductSingleWidget extends StatelessWidget {
  const AddProductSingleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromRGBO(202, 226, 232, 100),
      child: Container(
        
        height: 60,
        width: 250,
        decoration: BoxDecoration( borderRadius: BorderRadius.circular(15)),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            
            const Text('Foxin FPS 500S SM',
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600)),
            kWidth10,
            const Text(
              '50',
              style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          
            const Text(
              '3',
              style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const Text(
              '200',
              style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
    
            const Text(
              '550',
              style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
           IconButton(onPressed: (){}, icon: const Icon(Icons.remove_circle,color: Colors.red,))
          ],
        ),
      ),
    );
  }
}
