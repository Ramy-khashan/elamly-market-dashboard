
import 'package:flutter/material.dart'; 

 

class Utils {
  BuildContext context;
  Utils(this.context);

   Color get color =>   Colors.black;
  Size get getScreenSize => MediaQuery.of(context).size; 
}
