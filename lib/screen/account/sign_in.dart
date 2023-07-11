import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../bloc/auth/bloc_dangKy.dart';
import '../../bloc/check_log_state.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/state_bloc.dart';
import '../../config/path/share_pref_path.dart';
import '../../home.dart';
import '../../model/model_login.dart';
import '../../styles/init_style.dart';
import '../../widget/app_bar.dart';
import 'inset_phone.dart';

class ChangePass extends StatefulWidget {
  String phone;
  ChangePass({required this.phone});

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  BlocDangKy blocDangKy=BlocDangKy();


  TextEditingController password=TextEditingController();
  TextEditingController confirm=TextEditingController();
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
                'Nhập mật khẩu',
                style: StyleApp.textStyle500(color: Colors.white, fontSize: 18),
              ))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [

              TextFormField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: '     nhập mật khẩu ',
                    hintStyle: StyleApp.textStyle400(color: Colors.grey,fontSize: 16)
                ),
              ),
              TextFormField(
                controller: confirm,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: '     nhập lại mật khẩu ',
                    hintStyle: StyleApp.textStyle400(color: Colors.grey,fontSize: 16),

                ),

              ),
              SizedBox(height: 15,),
              BlocListener(bloc: blocDangKy,
                listener: (_,StateBloc state) {
                  ModelLogin model = ModelLogin();
                  if (state is LoadSuccess) {
                    model = state.data;
                  }
                CheckLogState.check(context, state: state,msg: 'Thành công',
                success: ()async{
                  await SharePrefsKeys.saveUserKey(model);
                  // await    SharedPrefs.saveString(SharePrefsKeys.user_token,model.accessToken);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                });
                },
                child: InkWell(
                  onTap: (){
                  },
                  child: Container(
                    color: ColorApp.red,
                    width:MediaQuery.of(context).size.width * 0.5 ,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(child: Text('Tiếp tục',style: StyleApp.textStyle700(color: Colors.white),)),
                    ),
                  ),
                ),
              )
            ],
          ),
          // Container(
          //     height: MediaQuery.of(context).size.height * 0.05,
          //     width: double.infinity,
          //     decoration: BoxDecoration(border: Border.all(color: Colors.grey),
          //         color: Colors.white
          //
          //     ),
          //     child: Center(child: Text('Đăng ký',style: StyleApp.textStyle700(fontSize: 18,color: ColorApp.red),))
          // ),
        ],
      ),
    );
  }
}
