import 'package:flutter/material.dart';

import '../../config/const.dart';
import '../../home.dart';
import '../../styles/init_style.dart';

class KetQuaScreen extends StatefulWidget {
 String code;
 KetQuaScreen({required this.code});

  @override
  State<KetQuaScreen> createState() => _KetQuaScreenState();
}

class _KetQuaScreenState extends State<KetQuaScreen> {
  int checkedVC = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: ColorApp.red,
            flexibleSpace: Padding(
              padding: EdgeInsets.only(
                  right: 10,
                  left: 10,
                  top: MediaQuery.of(context).size.height * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Center(
                        child: Text(
                          'Đơn hàng của bạn',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: StyleApp.textStyle500(
                              color: Colors.white, fontSize: 18),
                        ),
                      )),
                  InkWell(
                    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));},
                    child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/img2.png',
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                        )),
                  ),
                ],
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [

              SizedBox(
                height: 35,
              ),
              Text(
                'Mã đơn hàng : ${widget.code}',
                style: StyleApp.textStyle500(color: Colors.black87),
              ),
              Text(
                'Thời gian giao dịch : ${Const.formatTime(DateTime.now().millisecondsSinceEpoch,format: 'HH:mm:ss dd/MM/yyyy')}',
                style: StyleApp.textStyle500(color: Colors.black87),
              ),
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 50,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'GIAO DỊCH THÀNH CÔNG',
                style: StyleApp.textStyle500(color: ColorApp.red, fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(color: ColorApp.blue3D),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Row(
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              ' Tiếp tục mua sắm',
                              style: StyleApp.textStyle500(
                                  color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox()
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
