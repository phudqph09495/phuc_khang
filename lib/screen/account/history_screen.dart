import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/auth/bloc_lichSU.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/state_bloc.dart';
import '../../config/const.dart';
import '../../model/model_lichSu.dart';
import '../../styles/init_style.dart';
import '../../widget/loadPage/item_load_page.dart';
import '../../widget/loadPage/item_loadmore.dart';
import 'detail_lichSu.dart';

class LichSuDatHang extends StatefulWidget {
  const LichSuDatHang({Key? key}) : super(key: key);

  @override
  State<LichSuDatHang> createState() => _LichSuDatHangState();
}

class _LichSuDatHangState extends State<LichSuDatHang> {
  BlocLichSu blocLichSu = BlocLichSu()..add(GetData());

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
                  bottom: 5,
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
                          'Lịch sử đặt hàng',
                          style: StyleApp.textStyle500(
                              color: Colors.white, fontSize: 18),
                        ),
                      )),
                  InkWell(
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          )),
      body: SingleChildScrollView(
          child: Column(
        children: [
          BlocBuilder(
            builder: (_, StateBloc state) {
              if (state is LoadSuccess) {
                ModelLichSu model = state.data;

                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChiTietScreen(
                                      totalPrice: model.orders![index].totalPrice??'0',
                                      name: model.orders![index].customerName??'',
                                      id: model.orders![index].id.toString(),
                                      ship: model.orders![index].shipmentPrice??'0',
                                      address: model.orders![index].customerAddress??'',
                                      code: model.orders![index].code??'',
                                      district: model.orders![index].district??'',
                                      region: model.orders![index].region??'',
                                      status: model.orders![index].status??'',
                                      phone: model.orders![index].customerPhone??'',
                                  )));
                        },
                        child: Container(
                          decoration: BoxDecoration(border: Border.all()),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Mã đơn hàng : ${model.orders![index].code}',
                                  style: StyleApp.textStyle400(),
                                ),
                                Text(''),
                                Text(
                                  'Ngày tạo: ${Const.convertTime('${model.orders![index].createdAt}')}',
                                  style: StyleApp.textStyle400(),
                                ),
                                Text(''),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Tổng tiền: ',
                                          style: StyleApp.textStyle400(),
                                        ),
                                        Text(
                                          '${Const.convertPrice('${model.orders![index].totalPrice}')}đ',
                                          style: StyleApp.textStyle400(
                                              color: ColorApp.red),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Trạng thái: ',
                                          style: StyleApp.textStyle400(),
                                        ),
                                        Text(
                                          '${model.orders![index].status}',
                                          style: StyleApp.textStyle400(
                                              color: ColorApp.red),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  shrinkWrap: true,
                  itemCount: model.orders!.length,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                );
              }
              return SizedBox();
            },
            bloc: blocLichSu,
          ),
        ],
      )),
    );
  }
}
