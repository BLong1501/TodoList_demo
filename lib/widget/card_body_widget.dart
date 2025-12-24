import 'package:app_dacs/model/items.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
class CardBody extends StatelessWidget {
   CardBody({ Key? key, required this.index,required this.item, required this.deleteTask }) : super(key: key);

  final int index;
  var item;
  final Function deleteTask;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 28),
      width: double.infinity,
      height: 74 ,
      decoration: BoxDecoration(
        boxShadow:[
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        color: (index % 2 ==0)?const Color.fromARGB(255, 85, 53, 142) : const Color.fromARGB(255, 214, 95, 235),
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child : Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
         
          children: [
            Text(
              item.name,
               style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
        
            ),),
          InkWell(
            onTap: () async{
              if( await customConfirm(context)){
                 deleteTask(item.id);
              }
              return;
               
            },
            child: Icon(
            Icons.delete_outline,
             size: 30,
              color: Colors.white,
              
              )),
         ],
        
        ),
      ),
     
    );
  }
}



class HoverButton extends StatefulWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const HoverButton({
    Key? key,
    required this.text,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  _HoverButtonState createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.1 : 1.0, // phóng to nhẹ khi hover
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: AnimatedOpacity(
          opacity: _isHovered ? 0.85 : 1.0, // mờ nhẹ khi hover
          duration: const Duration(milliseconds: 200),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: widget.onPressed,
            child: Text(
              widget.text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> customConfirm(BuildContext context) async {
  return await showDialog<bool>(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.deepPurple, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.warning_amber_rounded,
                  size: 60, color: Colors.white),
              const SizedBox(height: 12),
              const Text(
                "Xác nhận xóa",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Bạn có chắc muốn xóa task này?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HoverButton(
                    text: "Hủy",
                    color: Colors.grey,
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  HoverButton(
                    text: "Xóa",
                    color: Colors.redAccent,
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  ) ?? false;
}