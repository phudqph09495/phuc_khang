import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../bloc/auth/bloc_vertifyOTP.dart';
import '../../bloc/check_log_state.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/state_bloc.dart';
import '../../config/path/share_pref_path.dart';
import '../../config/share_pref.dart';
import '../../model/model_login.dart';
import '../../styles/init_style.dart';
import '../../widget/app_bar.dart';
import '../../widget/item/input/text_filed.dart';
import 'sign_in.dart';

class XacNhanSDT extends StatefulWidget {
String phone;
XacNhanSDT({required this.phone});

  @override
  State<XacNhanSDT> createState() => _XacNhanSDTState();
}

class _XacNhanSDTState extends State<XacNhanSDT> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController otp=TextEditingController();
  BlocVertifyOTP blocVertifyOTP=BlocVertifyOTP();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
          context: context,
          hasCart: false,
          leadingTap: (){
            Navigator.pop(context);
          },
          scaffoldKey: _scaffoldKey,
          tittle: Center(
              child: Text(
                'Xác nhận mã OTP',
                style: StyleApp.textStyle500(color: Colors.white, fontSize: 18),
              ))),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset('assets/images/img.png',width: MediaQuery.of(context).size.width * 0.35,),
              // child: LoadImage(
              //   url:
              //       'https://img.ws.mms.shopee.vn/3481ecb6f8a0e5d6949fd877cbdd183d',
              //   width: MediaQuery.of(context).size.width * 0.3,
              // ),
            ),
          ),
          Text(
            'Chào mừng bạn đến với kho hàng Nhật',
            style: StyleApp.textStyle700(color: ColorApp.red, fontSize: 16),
          ), SizedBox(
            height: 5,
          ),
          Text(
            'Nhập số mã OTP để tiếp tục',
            style: StyleApp.textStyle700(color: ColorApp.red, fontSize: 16),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.35,
              child: InputText1(
                controller: otp,
                label: 'Mã xác nhận',
                keyboardType: TextInputType.phone,
                radius: 0,
                borderColor: Colors.grey,
                colorBg: Colors.white,
              )),
          SizedBox(
            height: 15,
          ),
          BlocListener(
            bloc: blocVertifyOTP,
            listener: (_,StateBloc state) {
              ModelLogin model = ModelLogin();
              if (state is LoadSuccess) {
                model = state.data;
              }
              CheckLogState.check(context, state: state,msg: 'Xác thực thành công',success: ()async{
                // await   SharedPrefs.saveString(SharePrefsKeys.user_token,model.accessToken);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePass(phone: widget.phone,)));
              });
            },
            child: InkWell(
              onTap: (){
                blocVertifyOTP.add(GetData(param: widget.phone,type: otp.text));

              },
              child: Container(
                color: ColorApp.red,
                width:MediaQuery.of(context).size.width * 0.2 ,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Center(child: Text('Tiếp tục',style: StyleApp.textStyle700(color: Colors.white),)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
