import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phuc_khang/screen/home/thanhtoan_screen.dart';


import '../../bloc/auth/bloc_profile.dart';
import '../../bloc/cart/bloc_cart.dart';
import '../../bloc/cart/event_bloc2.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/product/bloc_infoPrd.dart';
import '../../bloc/state_bloc.dart';
import '../../config/const.dart';
import '../../config/share_pref.dart';
import '../../home.dart';
import '../../model/model_infoPro.dart';
import '../../model/model_productMain.dart';
import '../../model/model_user.dart';
import '../../styles/init_style.dart';
import '../../widget/item/load_image.dart';
import '../account/login_screen.dart';

class GioHangScreen extends StatefulWidget {
  @override
  State<GioHangScreen> createState() => _GioHangScreenState();
}

class _GioHangScreenState extends State<GioHangScreen> {

  BlocProfile blocProfile = BlocProfile();
  BlocCartLocal blocCartLocal = BlocCartLocal();


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
                          'Lên đơn',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: StyleApp.textStyle500(
                              color: Colors.white, fontSize: 18),
                        ),
                      )),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                    },
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
        child: Column(
          children: [
            BlocBuilder<BlocCartLocal, StateBloc>(
                builder: (_, StateBloc state) {
              if (state is LoadSuccess) {
                List<ModelSanPhamMain2> list = state.data;
                int sum = state.data2;
                List<ModelInfoPro> listInfo = state.data3;

                return    ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: LoadImage(
                              url:
                              '${Const.image_host}${listInfo[index].product!.thumbnail}',
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.7,
                                    child: Text(
                                      '${listInfo[index].product!.name}',
                                      style: StyleApp.textStyle700(),
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width:
                                      MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Giá bán: ${Const.ConvertPrice.format(int.parse('${listInfo[index].product!.customerPrice!.price}'))} đ',
                                            style: StyleApp.textStyle600(
                                                color: ColorApp.dark500,
                                                fontSize: 14),
                                          ),
                                          // Text(
                                          //   'Lợi nhuận: 50.000 đ',
                                          //   style: StyleApp.textStyle600(
                                          //       color: ColorApp.green00,
                                          //       fontSize: 14),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        BlocListener(
                                            bloc: blocCartLocal,
                                            listener: (_, StateBloc state) {
                                              if (state is LoadSuccess) {
                                                context
                                                    .read<BlocCartLocal>()
                                                    .add(GetCart());
                                              }
                                            },
                                            child: InkWell(
                                                onTap: () {
                                                  blocCartLocal.add(Reduce(
                                                      modelSanPhamMain:
                                                      ModelSanPhamMain2(
                                                          id: list[index]
                                                              .id,
                                                          amount: 1)));
                                                },
                                                child: Icon(
                                                  Icons.remove_circle,
                                                  color: ColorApp.redText,
                                                  size: 27,
                                                ))),
                                        Text('  ${list[index].amount}  '),
                                        BlocListener(
                                            bloc: blocCartLocal,
                                            listener: (_, StateBloc state) {
                                              if (state is LoadSuccess) {
                                                context
                                                    .read<BlocCartLocal>()
                                                    .add(GetCart());
                                              }
                                            },
                                            child: InkWell(
                                                onTap: () {
                                                  blocCartLocal.add(AddData(
                                                      modelSanPhamMain:
                                                      ModelSanPhamMain2(
                                                          id: list[index]
                                                              .id,
                                                          amount: 1)));
                                                },
                                                child: Icon(
                                                  Icons.add_circle,
                                                  color: ColorApp.redText,
                                                  size: 27,
                                                ))),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: listInfo.length,
                );
              }
              return SizedBox();
            }),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            )
          ],
        ),
      ),
      bottomSheet: Container(
        height: MediaQuery.of(context).size.height * 0.13,
        decoration: BoxDecoration(border: Border.all(), color: ColorApp.red),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                  color: Colors.white, border: Border(bottom: BorderSide())),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng',
                      style: StyleApp.textStyle500(fontSize: 18),
                    ),
                    BlocBuilder<BlocCartLocal, StateBloc>(
                        builder: (_, StateBloc state) {
                      if (state is LoadSuccess) {
                        int tong = state.data2;
                        return Text(
                          '${NumberFormat("###,###.###", 'vi_VN').format(tong)} đ',
                          style: StyleApp.textStyle700(color: ColorApp.red,fontSize: 18),
                        );
                      }
                      return Text(
                        '0đ',
                        style: StyleApp.textStyle700(color: ColorApp.red),
                      );
                    }),
                  ],
                ),
              ),
            ),
            BlocListener(
              bloc: blocProfile,
              listener: (_, StateBloc state) {
                if (state is LoadSuccess) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ThanhToanScreen()));
                }
                if (state is LoadFail) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text('Bạn phải đăng nhập để mua hàng'),
                        ),
                      ],
                    ),
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.zero,
                  ));

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }
              },
              child: InkWell(
                onTap: () async {
                  blocProfile.add(GetData());
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: Center(
                      child: Text(
                    'CHỐT ĐƠN',
                    style: StyleApp.textStyle700(color: Colors.white),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
