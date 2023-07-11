import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/bloc_dangKy.dart';
import '../../bloc/auth/bloc_sendOTP.dart';
import '../../bloc/check_log_state.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/state_bloc.dart';
import '../../styles/init_style.dart';
import '../../widget/app_bar.dart';
import '../../widget/item/input/text_filed.dart';
import 'confirm_phone.dart';
import 'login_screen.dart';

class DangKY extends StatefulWidget {
  const DangKY({Key? key}) : super(key: key);

  @override
  State<DangKY> createState() => _DangKYState();
}

class _DangKYState extends State<DangKY> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  BlocDangKy blocDangKy=BlocDangKy();
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();
  final keyFormSignUp = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController confirm = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
          context: context,
          hasCart: false,
          leadingTap: () {
            Navigator.pop(context);
          },
          scaffoldKey: _scaffoldKey,
          tittle: Center(
              child: Text(
            'Đăng Ký',
            style: StyleApp.textStyle500(color: Colors.white, fontSize: 18),
          ))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  'assets/images/img2.png',
                  width: MediaQuery.of(context).size.width * 0.35,
                ),
                // child: LoadImage(
                //   url:
                //       'https://img.ws.mms.shopee.vn/3481ecb6f8a0e5d6949fd877cbdd183d',
                //   width: MediaQuery.of(context).size.width * 0.3,
                // ),
              ),
            ),
            Text(
              'Chào mừng bạn đến với Phúc Khang',
              style: StyleApp.textStyle700(color: ColorApp.red, fontSize: 16),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(

                    controller: name,
                    decoration: InputDecoration(
                        hintText: '     nhập họ tên ',
                        hintStyle: StyleApp.textStyle400(
                            color: Colors.grey, fontSize: 16)),
                  ),

                  TextFormField(
                   keyboardType: TextInputType.phone,
                    controller: phone,
                    decoration: InputDecoration(
                        hintText: '     nhập số điện thoại ',
                        hintStyle: StyleApp.textStyle400(
                            color: Colors.grey, fontSize: 16)),
                  ),
                  TextFormField(

                    controller: address,
                    decoration: InputDecoration(
                        hintText: '     nhập địa chỉ',
                        hintStyle: StyleApp.textStyle400(
                            color: Colors.grey, fontSize: 16)),
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: password,
                    decoration: InputDecoration(
                        hintText: '     nhập mật khẩu ',
                        hintStyle: StyleApp.textStyle400(
                            color: Colors.grey, fontSize: 16)),
                  ),
                  TextFormField(
                    controller: confirm,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: '     nhập lại mật khẩu ',
                      hintStyle:
                          StyleApp.textStyle400(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  BlocListener(
                    listener: (_,StateBloc state) {
                      CheckLogState.check(context, state: state,msg:state is LoadSuccess?state.mess:'Thành công',success: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      } );
                    },
                    bloc: blocDangKy,
                    child: InkWell(
                      onTap: (){
                        blocDangKy.add(DangKy(address: address.text, name: name.text, email: '', password_confirmation: confirm.text, phone: phone.text, password: password.text));
                      },
                      child: Container(
                        color: ColorApp.red,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                              child: Text(
                            'Đăng ký',
                            style: StyleApp.textStyle700(color: Colors.white),
                          )),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
