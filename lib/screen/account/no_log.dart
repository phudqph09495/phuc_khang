import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../bloc/event_bloc.dart';
import '../../bloc/state_bloc.dart';
import '../../model/model_config.dart';
import '../../styles/init_style.dart';
import '../../widget/app_bar.dart';
import '../../widget/item/load_image.dart';
import 'inset_phone.dart';
import 'login_screen.dart';

class NoLogScreen extends StatefulWidget {
  const NoLogScreen({Key? key}) : super(key: key);

  @override
  State<NoLogScreen> createState() => _NoLogScreenState();
}

class _NoLogScreenState extends State<NoLogScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  _launchURL(url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Đã có lỗi , vui lòng quay lại sau';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      appBar: AppBarCustom(
          context: context,
          leadingTap: (){_scaffoldKey.currentState!.openDrawer();},
          scaffoldKey: _scaffoldKey,
          tittle: Center(
              child: Text(
            'Tài khoản',
            style: StyleApp.textStyle500(color: Colors.white, fontSize: 18),
          ))),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: double.infinity,
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey),

                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * 0.03,
                            horizontal: 15),
                        child: Container(
                          decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(color: Colors.red,width: 2)),
                          child: ClipOval(
                            child: LoadImage(
                              url:
                              'https://t4.ftcdn.net/jpg/03/46/93/61/360_F_346936114_RaxE6OQogebgAWTalE1myseY1Hbb5qPM.jpg',
                              height: MediaQuery.of(context).size.height * 0.11,

                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                      InkWell(onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      },child: Text('Đăng nhập ',style: StyleApp.textStyle700(fontSize: 16),)),
                      Text('| ',style: StyleApp.textStyle700(fontSize: 16),),
                      InkWell(onTap: (){
                        // _launchURL(Uri.parse('https://khohangnhat.vn/customer/phoneverify.html?type=register'));
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DangKY()));
                      },child: Text('Đăng ký ',style: StyleApp.textStyle700(fontSize: 16),))
                    ],
                  ),
                ),
                SizedBox(height: 30,),

              ],
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: double.infinity,
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey),
                    color: ColorApp.red

                  ),
                  child: Center(child: Text('Đăng nhập',style: StyleApp.textStyle400(fontSize: 18,color: Colors.white),))
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
