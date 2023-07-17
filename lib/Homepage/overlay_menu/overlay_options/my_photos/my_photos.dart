import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../../../util/hexcolor.dart';

class MyPhotos extends StatefulWidget {
  List photoURLs;
  MyPhotos(this.photoURLs,{super.key});

  @override
  State<MyPhotos> createState() => _MyPhotosState();
}

class _MyPhotosState extends State<MyPhotos> {
  // final storageRef = FirebaseStorage.instance.ref();
  // List photoURLs = [];
  // List temp = [];
  //
  // void listingImages()async{
  //   final storageRefFiles = FirebaseStorage.instance.ref().child(widget.Username);
  //   final listResult = await storageRefFiles.listAll();
  //   for (var item in listResult.items) {
  //     final imageUrl = await storageRef.child(item.fullPath.toString()).getDownloadURL();
  //     temp.add(imageUrl);
  //     print(imageUrl);
  //   }
  //   setState(() {
  //     photoURLs = temp;
  //   });
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   listingImages();
  // }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
          children : [
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: Container(
                  height: MediaQuery.of(context).size.height-250,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [HexColor("#FB9F40").withOpacity(0.6),HexColor("#ED1C24").withOpacity(0.6)]
                    ),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width - 200,
                      child: ListView.builder(
                          itemCount: widget.photoURLs.length,
                          itemBuilder: (BuildContext context,int index){
                            return MyPhotosCard(index,context);
                          }
                      ),
                    ),
                  )
              ),
            ),
          ]

      ),
    );
  }
  Widget MyPhotosCard(int index, BuildContext context){
    if(index % 2 == 0 && widget.photoURLs.length == index +1){
      return Container(
        margin: const EdgeInsets.only(left: 15,right: 16,bottom: 10,top: 10),
        width: MediaQuery.of(context).size.width/2.3,
        height: MediaQuery.of(context).size.height/4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: HexColor("#F8F8F8"),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey, //New
                blurRadius: 1.0,
                offset: Offset(0, 0))
          ],
        ),
        child: CachedNetworkImage(
          imageUrl: widget.photoURLs[index],
          maxHeightDiskCache: 300,
        ),
      );
    }
    else if(index % 2 == 0 ){
      return Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15,right: 16,bottom: 10,top: 10),
            width: MediaQuery.of(context).size.width/2.3,
            height: MediaQuery.of(context).size.height/4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: HexColor("#F8F8F8"),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey, //New
                    blurRadius: 1.0,
                    offset: Offset(0, 0))
              ],
            ),
            child: CachedNetworkImage(
              imageUrl: widget.photoURLs[index],
              maxHeightDiskCache: 300,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10,top: 10),
            width: MediaQuery.of(context).size.width/2.3,
            height: MediaQuery.of(context).size.height/4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: HexColor("#F8F8F8"),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey, //New
                    blurRadius: 1.0,
                    offset: Offset(0, 0))
              ],
            ),
            child: CachedNetworkImage(
              imageUrl: widget.photoURLs[index+1],
              maxHeightDiskCache: 300,
            ),
          ),
        ],
      );
    }
    else{
      return Container(height: 0,width: 0,);
    }
  }
}
