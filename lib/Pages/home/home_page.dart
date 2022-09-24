import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _input = '';
  var _message = '';


  @override

  void _handleClickButton(int num) {
    const password = '123456';

    setState(() {
      if (num == -1) {
        _input = _input.substring(0, _input.length - 1);
      } else {
        _input = _input + num.toString();
      }
    });

    if (_input.length == 6) {
      // ตรวจสอบรหัสผ่านว่าถูกต้องหรือไม่
      if (_input == password) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        setState(() {
          _message = 'ยินดีต้อนรับสู่ Mobile Banking App :)';
        });
      } else {
        //showMyDialog(context, 'Sorry', 'Incorrect PIN, please try again.');
        setState(() {
          _input = '';
          //_message = 'รหัสผ่านไม่ถูกต้อง กรุณาลองใหม่';
        });
      }
    }
  }


  Widget _buildButton(int num) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          _handleClickButton(num);
        },
        customBorder: CircleBorder(),
        child: Container(
          width: 60.0,
          height: 60.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: num != -1
                ? Border.all(
              color: Color(0xFFCCCCCC),
              width: 1.0,
            )
                : null,
          ),
          child: num == -1
              ? Icon(Icons.backspace_outlined)
              : Text(
            num.toString(),
            style: GoogleFonts.firaCode(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey, //สีพื้นหลังของ Container
          border: Border.all(
            width: 5.0,
            color: Colors.white60,
          ),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
            ),
          ],
        ),
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/guess_logo.png',
              width: 100.0,
            ),
            Text('Guess the number',
              style: GoogleFonts.firaCode(
                fontSize: 22.0,
                fontWeight: FontWeight.w200,
              ),
            ),
            SizedBox(height: 16.0),
            Text(_input,
              style: GoogleFonts.asset(
                fontWeight: FontWeight.w400,
                fontSize: 50,
              ),
            ),
            Text(_message,
              style: TextStyle(
                fontWeight: FontWeight. w300,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 30.0,),

            Column(
              children: [
                for (var row in [
                  [1, 2, 3],
                  [4, 5, 6],
                  [7, 8, 9],
                ])
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [for (var i in row) _buildButton(i)],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildButton(0),
                    _buildButton(-1),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
