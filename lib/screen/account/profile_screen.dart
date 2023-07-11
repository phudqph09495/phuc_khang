import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../../bloc/auth/bloc_profile.dart';
import '../../bloc/auth/bloc_updateProFile.dart';
import '../../bloc/check_log_state.dart';
import '../../bloc/choose_image_bloc.dart';
import '../../bloc/event_bloc.dart';

import '../../bloc/location/bloc_huyen.dart';
import '../../bloc/location/bloc_tinh.dart';
import '../../bloc/state_bloc.dart';
import '../../config/const.dart';
import '../../model/model_profile.dart';
import '../../model/model_tinh.dart';
import '../../model/model_user.dart';
import '../../styles/init_style.dart';
import '../../widget/app_bar.dart';
import '../../widget/item/load_image.dart';
import 'login_screen.dart';

class Profle extends StatefulWidget {
  const Profle({Key? key}) : super(key: key);

  @override
  State<Profle> createState() => _ProfleState();
}

class _ProfleState extends State<Profle> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  BlocProfile blocProfile = BlocProfile()..add(GetData());


  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController diachi = TextEditingController();
  TextEditingController ngaySinh = TextEditingController();
  BlocUpdateProFile blocUpdateProFile = BlocUpdateProFile();
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
            'Cài đặt tài khoản',
            style: StyleApp.textStyle500(color: Colors.white, fontSize: 18),
          ))),
      body: SingleChildScrollView(
          child: Column(
        children: [

          BlocBuilder(
            builder: (_, StateBloc state) {
              if (state is LoadSuccess) {
                ModelProfile model = state.data;
                name.text = model.profile!.name ?? '';
                phone.text = model.profile!.phone ?? '';
                // email.text = model.email ?? '';

                // ngaySinh.text = model.dateOfBirth ?? '';



                diachi.text = model.profile!.address ?? '';
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 5),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border(top: BorderSide())),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    'Tên',
                                    style: StyleApp.textStyle500(),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: TextFormField(
                                      onChanged: (val) {
                                        model.profile!.name = val;
                                      },
                                      controller: name,
                                      textAlign: TextAlign.end,
                                      decoration:
                                          InputDecoration(hintText: 'Điền tên'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border(top: BorderSide())),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    'Số điện thoại',
                                    style: StyleApp.textStyle500(),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: TextFormField(
                                      onChanged: (val) {
                                        model.profile!.phone = val;
                                      },
                                      readOnly: true,
                                      controller: phone,
                                      textAlign: TextAlign.end,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        hintText: '',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),



                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border(top: BorderSide())),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 13),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Địa chỉ cụ thể',
                                    style: StyleApp.textStyle500(),
                                  ),
                                  Text(
                                    'Số nhà,tên toà nhà, tên đường, tên khu vực',
                                    style: StyleApp.textStyle400(fontSize: 14),
                                  ),
                                  TextFormField(
                                    controller: diachi,
                                    // onChanged: (val) {
                                    //   model.location!.address = val;
                                    // },
                                    decoration: InputDecoration(
                                      hintText: model.profile!.address??'Nhập địa chỉ cụ thể',

                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          BlocListener(
                            bloc: blocUpdateProFile,
                            listener: (_, StateBloc state) {
                              CheckLogState.check(context,
                                  state: state,
                                  msg: 'Cập nhật thành công',
                                  success: () {
                                    blocProfile.add(GetData());
                                  });
                            },
                            child: InkWell(
                              onTap: () {
                                blocUpdateProFile.add(UpdateProfile(
                                    name: name.text,




                                    address: diachi.text));
                              },
                              child: Container(
                                decoration: BoxDecoration(color: ColorApp.red),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Center(
                                      child: Text(
                                    'Lưu thông tin',
                                    style: StyleApp.textStyle700(
                                        fontSize: 16, color: Colors.white),
                                  )),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          )
                        ],
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
          ),
        ],
      )),
    );
  }
}
