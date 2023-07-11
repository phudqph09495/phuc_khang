import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';


import '../../bloc/auth/bloc_profile.dart';
import '../../bloc/bloc_counter.dart';
import '../../bloc/cart/bloc_cart.dart';
import '../../bloc/cart/bloc_order.dart';
import '../../bloc/cart/event_bloc2.dart';

import '../../bloc/check_log_state.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/location/bloc_huyen.dart';
import '../../bloc/location/bloc_phiVC.dart';
import '../../bloc/location/bloc_tinh.dart';
import '../../bloc/product/bloc_infoPrd.dart';
import '../../bloc/state_bloc.dart';
import '../../config/const.dart';
import '../../home.dart';
import '../../model/model_huyen.dart';
import '../../model/model_infoPro.dart';
import '../../model/model_productMain.dart';
import '../../model/model_profile.dart';
import '../../model/model_tinh.dart';
import '../../model/model_user.dart';
import '../../styles/init_style.dart';
import 'dart:async';

import '../../widget/item/custom_toast.dart';
import '../../widget/item/load_image.dart';
import 'ketQua_screen.dart';


class ThanhToanScreen extends StatefulWidget {
  const ThanhToanScreen({Key? key}) : super(key: key);

  @override
  State<ThanhToanScreen> createState() => _ThanhToanScreenState();
}

class _ThanhToanScreenState extends State<ThanhToanScreen> {
  String tinhS = 'Chọn tỉnh/thành phố';
  String idTinh = "";
  String huyenS = 'Chọn quận/huyện';
  String idHuyen = '';
  int checkedVC = 0;
  int checkedTT = 0;
  bool mau = true;
  late Timer timer;
  int phiVC = 0;
  int tong = 0;

  BlocProfile blocProfile = BlocProfile();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController diachi = TextEditingController();
  TextEditingController promotion_code = TextEditingController();
  String maKM='';
  String huyenSS = '';
  ModelProfile model = ModelProfile();
  BlocTinh blocTinh = BlocTinh();

  BlocHuyen blocHuyen = BlocHuyen();

  int sum = 0;
  BlocCartLocal blocCartLocal = BlocCartLocal();
  Bloc_infoPrd bloc = Bloc_infoPrd();
  Bloc_phiVC bloc_phiVC = Bloc_phiVC();
  BlocOrder bloc_order = BlocOrder();
  Map<String, int> count = {};
  int coupon = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blocProfile.add(GetData());
    blocTinh.add(GetData());

  }



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocCartLocal,StateBloc>(builder: (context,StateBloc state){
      if(state is LoadSuccess){
        List<ModelSanPhamMain2> list = state.data;
        int sum = state.data2;
        List<ModelInfoPro> listInfo = state.data3;
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
                          context.read<CounterCubit>().cst();
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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [

                  BlocBuilder(
                    builder: (_, StateBloc state) {
                      if (state is LoadSuccess) {
                        model = state.data;
                        name.text = model.profile!.name ?? '';
                        phone.text = model.profile!.phone ?? '';

                        diachi.text = model.profile!.address ?? '';
                        return Column(
                          children: [
                            Table(
                              columnWidths: const {
                                0: FlexColumnWidth(5),
                                1: FlexColumnWidth(5),
                              },
                              border: TableBorder(
                                  horizontalInside: BorderSide(color: Colors.black12),
                                  top: BorderSide(color: Colors.black12),
                                  left: BorderSide(color: Colors.black12),
                                  right: BorderSide(color: Colors.black12),
                                  bottom: BorderSide(color: Colors.black12)),
                              children: [
                                TableRow(children: [
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Thông tin giao hàng',
                                              style: StyleApp.textStyle700()),
                                        )
                                      ]),
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('',
                                              style: TextStyle(fontSize: 20.0)),
                                        )
                                      ]),
                                ]),
                                TableRow(children: [
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Tên',
                                            style: StyleApp.textStyle400(),
                                          ),
                                        )
                                      ]),
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        TextFormField(
                                          controller: name,
                                          textAlign: TextAlign.end,
                                          decoration:
                                          InputDecoration(hintText: 'Điền tên'),
                                        )
                                      ]),
                                ]),
                                TableRow(children: [
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Số điện thoại',
                                            style: StyleApp.textStyle400(),
                                          ),
                                        )
                                      ]),
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        TextFormField(
                                          controller: phone,
                                          textAlign: TextAlign.end,
                                          decoration:
                                          InputDecoration(hintText: 'Điền sdt'),
                                        )
                                      ]),
                                ]),
                                TableRow(children: [
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Tỉnh/thành phố',
                                            style: StyleApp.textStyle400(),
                                          ),
                                        )
                                      ]),
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        BlocBuilder(
                                          builder: (_, StateBloc stateTinh) {
                                            if (stateTinh is LoadSuccess) {
                                              ModelTinh modelTinh = stateTinh.data;
                                              return PopupMenuButton(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      SizedBox(),
                                                      Row(
                                                        children: [
                                                          Text('${tinhS}'),
                                                          Icon(
                                                            Icons.arrow_forward_ios,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  itemBuilder: (context) {
                                                    return List.generate(
                                                        modelTinh.regions!.length,
                                                            (index) => PopupMenuItem(
                                                          value: index,
                                                          onTap: () {
                                                            setState(() {
                                                              tinhS =
                                                              '${modelTinh.regions![index].defaultName}';
                                                              idTinh = modelTinh
                                                                  .regions![
                                                              index]
                                                                  .id
                                                                  .toString();
                                                              blocHuyen.add(GetData(
                                                                  param:
                                                                  '${modelTinh.regions![index].id}'));
                                                              huyenS = '';
                                                              idHuyen = '';

                                                            });
                                                            print(idTinh);
                                                            print(idHuyen);
                                                          },
                                                          child: Text(
                                                            '${modelTinh.regions![index].defaultName}',
                                                            style: StyleApp
                                                                .textStyle500(),
                                                            textAlign:
                                                            TextAlign.end,
                                                          ),
                                                        ));
                                                  });
                                            }
                                            return SizedBox();
                                          },
                                          bloc: blocTinh,
                                        )
                                        //
                                      ]),
                                ]),
                                TableRow(children: [
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Quận/huyện'),
                                        )
                                      ]),
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        BlocBuilder(
                                          builder: (_, StateBloc stateHuyen) {
                                            if (stateHuyen is LoadSuccess) {
                                              ModelHuyen modelHuyen =
                                                  stateHuyen.data;
                                              return PopupMenuButton(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      SizedBox(),
                                                      Row(
                                                        children: [
                                                          Text('${huyenS}'),
                                                          Icon(
                                                            Icons.arrow_forward_ios,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  itemBuilder: (context) {
                                                    return List.generate(
                                                        modelHuyen
                                                            .districts!.length,
                                                            (index) => PopupMenuItem(
                                                          value: index,
                                                          onTap: () {
                                                            setState(() {
                                                              huyenS =
                                                              '${modelHuyen.districts![index].defaultName}';
                                                              idHuyen = modelHuyen
                                                                  .districts![
                                                              index]
                                                                  .id
                                                                  .toString();
                                                            });


                                                          },
                                                          child: Text(
                                                            '${modelHuyen.districts![index].defaultName}',
                                                            style: StyleApp
                                                                .textStyle500(),
                                                            textAlign:
                                                            TextAlign.end,
                                                          ),
                                                        ));
                                                  });
                                            }
                                            return SizedBox();
                                          },
                                          bloc: blocHuyen,
                                        )
                                        //
                                      ]),
                                ]),
                              ],
                            ),
                            Table(
                              border: TableBorder(
                                  bottom: BorderSide(color: Colors.black12),
                                  left: BorderSide(color: Colors.black12),
                                  right: BorderSide(color: Colors.black12)),
                              columnWidths: const {
                                0: FlexColumnWidth(50),
                                1: FlexColumnWidth(1),
                              },
                              children: [
                                TableRow(children: [
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Địa chỉ cụ thể',
                                                style: StyleApp.textStyle400(),
                                              ),
                                              Text(
                                                'Số nhà, tên toà nhà, tên đường tên khu vực',
                                                style:
                                                StyleApp.textStyle400(fontSize: 12),
                                              ),
                                              TextFormField(
                                                controller: diachi,
                                                decoration: InputDecoration(
                                                  hintText: 'Nhập địa chỉ cụ thế',
                                                  hintStyle: StyleApp.textStyle400(),
                                                ),
                                                maxLines: 1,
                                                onChanged: (val) {
                                                  model.profile!.address = val;
                                                },
                                              )
                                            ],
                                          ),
                                        )
                                      ]),
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child:
                                          Text('', style: StyleApp.textStyle400()),
                                        )
                                      ]),
                                ]),
                              ],
                            ),
                          ],
                        );
                      }
                      return SizedBox();
                    },
                    bloc: blocProfile,
                  ),
                  SizedBox(
                    height: 20,
                  ),



                  Container(
                    decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.black12))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Thông tin tài khoản hưởng',
                                  style: StyleApp.textStyle700(fontSize: 14),
                                ),
                              )),
                          Column(
                            children: [
                              Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(5),
                                  1: FlexColumnWidth(5),
                                },
                                children: [
                                  TableRow(children: [
                                    Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                            EdgeInsets.all(8.0),
                                            child: Text(
                                              'Tên ngân hàng',
                                              style: StyleApp
                                                  .textStyle400(),
                                            ),
                                          )
                                        ]),
                                    Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding:
                                            EdgeInsets.all(8.0),
                                            child: Text('Ngân hàng BIDV',
                                                style: StyleApp
                                                    .textStyle500(
                                                    color: ColorApp
                                                        .red)),
                                          )
                                        ]),
                                  ]),

                                  TableRow(children: [
                                    Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                            EdgeInsets.all(8.0),
                                            child: Text(
                                              'Tên chủ tài khoản',
                                              style: StyleApp
                                                  .textStyle400(),
                                            ),
                                          )
                                        ]),
                                    Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding:
                                            EdgeInsets.all(8.0),
                                            child: Text('Trương Ái Hữu',
                                                style: StyleApp
                                                    .textStyle500(
                                                    color: ColorApp
                                                        .red)),
                                          )
                                        ]),
                                  ]),
                                  TableRow(children: [
                                    Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                            EdgeInsets.all(8.0),
                                            child: Text(
                                              'Số tài khoản',
                                              style: StyleApp
                                                  .textStyle400(),
                                            ),
                                          )
                                        ]),
                                    Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding:
                                            EdgeInsets.all(8.0),
                                            child: Text('68610000265987',
                                                style: StyleApp
                                                    .textStyle500(
                                                    color: ColorApp
                                                        .red)),
                                          )
                                        ]),
                                  ]),
                                ],
                              ),

                            ],
                          )
                        ],
                      ),
                    ),
                  )
                  ,
                  Divider(),
                  ListView.builder(
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
                                      Text(
                                        '${Const.ConvertPrice.format(int.parse('${listInfo[index].product!.customerPrice!.price}'))} đ x ${list[index].amount}',
                                        style: StyleApp.textStyle600(
                                            color: ColorApp.dark500,
                                            fontSize: 14),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '   ${Const.ConvertPrice.format(int.parse('${listInfo[index].product!.customerPrice!.price}') * list[index].amount!)}  đ  ',style: StyleApp.textStyle700(),),
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
                  ),


                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tổng',
                        style: StyleApp.textStyle400(),
                      ),
                      BlocBuilder<BlocCartLocal, StateBloc>(
                          builder: (_, StateBloc state) {
                            if (state is LoadSuccess) {
                              tong = state.data2;
                              return Text(
                                '${NumberFormat("###,###.###", 'vi_VN').format(tong)}đ',
                                style: StyleApp.textStyle700(color: ColorApp.red),
                              );
                            }
                            return Text(
                              '0đ',
                              style: StyleApp.textStyle700(color: ColorApp.red),
                            );
                          }),
                    ],
                  ),


                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  )
                ]),
              )),
          bottomSheet: Container(
            height: MediaQuery.of(context).size.height * 0.06,
            decoration: BoxDecoration(border: Border.all(), color: ColorApp.red),
            child: BlocListener(
              bloc: bloc_order,
              listener: (_, StateBloc state) {


                CheckLogState.check(context,
                    state: state, msg: 'Đặt hàng thành công', success: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));

                      blocCartLocal.add(ClearAll());
                    });
              },
              child: InkWell(
                onTap: () {
                  List<Products> products = [];


                  if(diachi.text!=''&&idTinh!=''&&idHuyen!=''&&phone.text!=''){
                    for (var i = 0; i < list.length; i++) {
                      products.add(Products(
                          quanty: list[i].amount,
                          price: int.parse(
                              listInfo[i].product!.customerPrice!.price ??
                                  '0'),
                          productInfo: listInfo[i].product));
                    }
                    bloc_order.add(CreateOrder(
                        region: tinhS,

                        district: huyenS,
                        address: diachi.text,
                        products: products,
                        shipmentCost: 0,
                        totalProductPrice: sum,
                        freeShip: 'true',
                        totalPrice: sum));
                    // bloc_order.add(TaoOrder(
                    //     product: listPrd,
                    //     address: diachi.text,
                    //     name: name.text,
                    //     phone: phone.text,
                    //     district_id: idHuyen,
                    //     region_id: idTinh,
                    //     promotion_code: maKM,
                    //     payment_method: checkedVC == 0 ? 'COD' : 'ATM',
                    //     shipping_method: checkedVC == 0 ? 'SHOP_SHIP' : 'NO_SHIP'));
                  }else if(diachi.text==''){
                    CustomToast.showToast(context: context, msg: 'Hãy nhập địa chỉ chi tiết');
                  }else if(idHuyen==''){
                    CustomToast.showToast(context: context, msg: 'Hãy chon quận/huyện');
                  }else if(idTinh==''){
                    CustomToast.showToast(context: context, msg: 'Hãy chọn tỉnh/TP');
                  }else if(phone.text==''){
                    CustomToast.showToast(context: context, msg: 'Hãy nhập số điện thoại');
                  }


// if(checkedVC==0){
//   print('SHOP_SHIP');
//
// }else{
//   print(('NO_SHIP'));
// }
//             if(checkedTT==0){
//               print('COD');
//
//             }else{
//               print(('ATM'));
//             }

                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>KetQuaScreen()));
                  // blocCartLocal.add(ClearAll());
                },
                child: Container(
                  child: Center(
                      child: Text(
                        'Chốt đơn',
                        style: StyleApp.textStyle700(color: Colors.white),
                      )),
                ),
              ),
            ),
          ),
        );
      }
      return Scaffold();
    });
  }
}
