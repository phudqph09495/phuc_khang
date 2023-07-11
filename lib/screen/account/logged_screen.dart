import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:phuc_khang/model/model_profile.dart';
import 'package:phuc_khang/screen/account/profile_screen.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../bloc/auth/bloc_checkLogin.dart';
import '../../bloc/auth/bloc_profile.dart';
import '../../bloc/auth/bloc_xoaTK.dart';
import '../../bloc/check_log_state.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/state_bloc.dart';
import '../../config/path/share_pref_path.dart';
import '../../home.dart';
import '../../model/model_config.dart';
import '../../model/model_user.dart';
import '../../styles/init_style.dart';
import '../../widget/app_bar.dart';
import '../../widget/item/load_image.dart';
import 'history_screen.dart';
import 'login_screen.dart';

class LoggedScreen extends StatefulWidget {
  const LoggedScreen({Key? key}) : super(key: key);

  @override
  State<LoggedScreen> createState() => _LoggedScreenState();
}

class _LoggedScreenState extends State<LoggedScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  BlocProfile blocProfile = BlocProfile()..add(GetData());
  BlocXoaAcc blocXoaAcc=BlocXoaAcc();
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
            leadingTap: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            scaffoldKey: _scaffoldKey,
            tittle: Center(
                child: Text(
              'Tài khoản',
              style: StyleApp.textStyle500(color: Colors.white, fontSize: 18),
            ))),
        body: BlocBuilder(
          builder: (context, StateBloc state) {
            if(state is LoadSuccess){
              ModelProfile modelUser=state.data;

              return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.17,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: MediaQuery.of(context).size.height * 0.03,
                                    horizontal: 15),
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.red, width: 2)),
                                  child: ClipOval(
                                    child: LoadImage(
                                      url:
                                      'https://t4.ftcdn.net/jpg/03/46/93/61/360_F_346936114_RaxE6OQogebgAWTalE1myseY1Hbb5qPM.jpg',
                                      height: MediaQuery.of(context).size.height * 0.13,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: MediaQuery.of(context).size.height * 0.03,
                                    horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${modelUser.profile!.name}\n', style: StyleApp.textStyle700()),
                                    Text(modelUser.profile!.phone??'',
                                        style: StyleApp.textStyle500()),

                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LichSuDatHang()));
                          },
                          child: Container(
                            decoration: BoxDecoration(border:Border(top: BorderSide(color: Colors.grey))),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 25, left: 25, top: 10,bottom: 10),
                                  child: Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.clockRotateLeft,
                                        color: ColorApp.red,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        'Lịch sử đặt hàng',
                                        style: StyleApp.textStyle400(fontSize: 16),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Profle()));
                          },
                          child: Container(
                            decoration: BoxDecoration(border:Border(top: BorderSide(color: Colors.grey))),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 25, left: 25, top: 10,bottom: 10),
                                  child: Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.gear,
                                        color: ColorApp.red,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        'Cài đặt tài khoản',
                                        style: StyleApp.textStyle400(fontSize: 16),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),


                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(onTap: (){
                          showDialog(context: context, builder: (context)=>AlertDialog(
                            content: Container(
                              height: MediaQuery.of(context)
                                  .size
                                  .height *
                                  0.1,
                              width: MediaQuery.of(context)
                                  .size
                                  .width *
                                  0.7,
                              child: Center(child: Text('Xác nhận xoá tài khoản',style: StyleApp.textStyle500(
                                  color: Colors.black,
                                  fontSize: 18),),),
                            ),
                            actions: [
                              InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Huỷ',
                                  style: StyleApp.textStyle500(
                                      color: Colors.grey),
                                ),
                              ),
                              SizedBox(width: 30,),
                              BlocListener(
                                bloc: blocXoaAcc,
                                listener: (_, StateBloc state) {
                                  CheckLogState.check(context, state: state,
                                      msg: 'Xoá tài khoản thành công',
                                      success: () async {
                                        await SharePrefsKeys.removeAllKey();
                                        context.read<BlocCheckLogin>().add(GetData());
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MyHomePage()));
                                      });
                                },
                                child: InkWell(onTap: (){
                                  blocXoaAcc.add(GetData());
                                },
                                    child: Text(
                                      'Xác nhận',
                                      style:
                                      StyleApp.textStyle500(
                                        color: Colors.red,
                                      ),)
                                ),)
                            ],
                          ));
                        },
                          child: Container(
                            decoration: BoxDecoration(border:Border(top: BorderSide(color: Colors.grey),bottom: BorderSide(color: Colors.grey))),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 25, left: 25, top: 10,bottom: 10),
                                  child: Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.userSlash,
                                        color: ColorApp.red,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        'Xoá tài khoản',
                                        style: StyleApp.textStyle400(fontSize: 16),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: ()async{
                      SharePrefsKeys.removeAllKey();
                      context.read<BlocCheckLogin>().add(GetData());
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Đăng xuất thành công"),backgroundColor: Colors.green,
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(width: double.infinity,color: ColorApp.red,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('Đăng xuất',style: StyleApp.textStyle500(color: Colors.white,fontSize: 16),textAlign: TextAlign.center,),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
            if(state is LoadFail){

              return Center(
                child: Column(
                  children: [
                    SizedBox(height: 100,),
                    Text('Phiên đăng nhập đã hết, vui lòng đăng nhập lại'
                        ''),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      },
                      child: Container(
                        decoration: BoxDecoration(border: Border.all()),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Đăng Nhập',style: StyleApp.textStyle500(color: ColorApp.blue00),textAlign: TextAlign.center,),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return SizedBox();
          },
          bloc: blocProfile,
        ));
  }
}
