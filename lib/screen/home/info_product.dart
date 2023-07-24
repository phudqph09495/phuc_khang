import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:phuc_khang/screen/home/whithlist_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../bloc/auth/bloc_profile.dart';
import '../../bloc/cart/bloc_cart.dart';
import '../../bloc/cart/event_bloc2.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/product/bloc_infoPrd.dart';
import '../../bloc/product/bloc_rate.dart';
import '../../bloc/state_bloc.dart';
import '../../config/const.dart';
import '../../model/model_config.dart';
import '../../model/model_flash.dart';
import '../../model/model_infoPro.dart';
import '../../model/model_productMain.dart';
import '../../model/model_user.dart';
import '../../styles/init_style.dart';
import '../../widget/app_bar.dart';
import '../../widget/item/input/text_filed.dart';
import '../../widget/item/load_image.dart';
import '../account/login_screen.dart';

class InfoProductScreen extends StatefulWidget {
  String id;
  InfoProductScreen({required this.id});
  @override
  State<InfoProductScreen> createState() => _InfoProductScreenState();
}

class _InfoProductScreenState extends State<InfoProductScreen>
    with TickerProviderStateMixin {


  Bloc_infoPrd bloc_infoPrd = Bloc_infoPrd();

  BlocCartLocal blocCartLocal = BlocCartLocal();
  BlocCartLocal blocCartLocal2 = BlocCartLocal();
  ModelSanPhamMain model = ModelSanPhamMain();



  _launchURL(url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Đã có lỗi , vui lòng quay lại sau';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    bloc_infoPrd.add(GetData(param: '${widget.id}'));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        bloc_infoPrd.add(GetData(param: '${widget.id}'));
      },
      child: Scaffold(
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
                          child: BlocBuilder(
                            builder: (_, StateBloc state) {
                              if (state is LoadSuccess) {
                                ModelInfoPro model = state.data;
                                return Text(
                                 model.product!.name??'aaa',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: StyleApp.textStyle500(
                                      color: Colors.red, fontSize: 18),
                                );
                              }
                              return SizedBox();
                            },
                            bloc: bloc_infoPrd,
                          ),
                        )),
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GioHangScreen()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: -3,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: BlocBuilder<BlocCartLocal, StateBloc>(
                                  builder: (context, StateBloc state) {
                                    List<ModelSanPhamMain2> list =
                                        state is LoadSuccess ? state.data : [];

                                    return Text(
                                        list.length.toString(),
                                        style: StyleApp.textStyle500(
                                            color: Colors.red, fontSize: 12));
                                  },
                                ),
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            )),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder(
                builder: (_, StateBloc state) {

                  if (state is LoadSuccess) {
                    ModelInfoPro model = state.data;



                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: ImageSlideshow(
                                children: List.generate(
                                    model.product!.imagesShow!.length,
                                    (index) => LoadImage(
                                          url:
                                              '${Const.image_host}${model.product!.imagesShow![index].url}',
                                          width:
                                              MediaQuery.of(context).size.width,
                                        )),
                                height: MediaQuery.of(context).size.width,
                                // [
                                indicatorColor:
                                model.product!.imagesShow!.length > 1
                                        ? Colors.red
                                        : Colors.transparent,
                                isLoop: model.product!.imagesShow!.length > 1,
                                autoPlayInterval: 2000,
                              ),
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     InkWell(
                            //       onTap: () {
                            //         Share.share(
                            //             '${model.product!.name} ${model.link_web}');
                            //       },
                            //       child: Card(
                            //         shape: RoundedRectangleBorder(
                            //             borderRadius:
                            //                 BorderRadius.circular(50)),
                            //         child: Container(
                            //             decoration: BoxDecoration(
                            //               shape: BoxShape.circle,
                            //             ),
                            //             child: Padding(
                            //               padding: const EdgeInsets.all(3),
                            //               child: Icon(
                            //                 Icons.share_outlined,
                            //                 color: Colors.grey,
                            //               ),
                            //             )),
                            //       ),
                            //     ),
                            //
                            //   ],
                            // )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text('${model.product!.name}',
                                        style: StyleApp.textStyle700()),
                                  ),
                              SizedBox()
                                ],
                              ),
                              SizedBox(height: 15,),
                              Row(
                                children: [
                                  Text(
                                    'Giá lẻ: ${Const.convertPrice('${model.product!.customerPrice!.originPrice}')}đ',
                                    style: StyleApp.textStyle600(
                                        color: ColorApp.dark500, fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),

                                ],
                              ),
                              SizedBox(height: 15,),
                              Row(
                                children: [
                                  Text(
                                    'Giá thùng: ${Const.convertPrice('${model.product!.customerPrice!.price}')}đ',
                                    style: StyleApp.textStyle600(
                                        color: ColorApp.red, fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),

                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                             SizedBox(),
                                  model.product!.amount!>0
                                      ? Text(
                                          'Còn hàng',
                                          style: StyleApp.textStyle600(
                                              color: Colors.green),
                                        )
                                      : Text(
                                          'Hết hàng',
                                          style: StyleApp.textStyle600(
                                              color: Colors.red),
                                        )
                                ],
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
Text('Thông tin sán phẩm',style: StyleApp.textStyle600(),),
                         SizedBox(height: 10,),
                         HtmlWidget(
                                model.product!.descript??'',
                           customWidgetBuilder:
                               (ele) {
                             if (ele.attributes[
                             'src'] !=
                                 null) {
                               return Const
                                   .imageFromBase64String(
                                   '${ele.attributes['src']}',
                                   height: 200,
                                   width: double
                                       .infinity,
                                   fit: BoxFit
                                       .fitHeight);
                             }
                           },
                                onTapUrl: (url) => _launchURL(url),
                              )


                      ],
                    );
                  }

                  return SizedBox();
                },
                bloc: bloc_infoPrd,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(),
              ),


              SizedBox(
                height: 50,
              )
            ],
          ),
        ),

        bottomSheet: BlocBuilder(
          builder: (_, StateBloc state) {
            if(state is LoadSuccess){
              ModelInfoPro model =
              state.data;

              return Row(
                children: [

                  BlocListener(
                    bloc: blocCartLocal,
                    listener: (_,StateBloc state) {
                      if(state is LoadSuccess){
                        context.read<BlocCartLocal>().add(GetCart());
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: Duration(seconds: 1),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Đã thêm thành công'),
                            ],
                          ),
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.zero,
                        ));
                      }
                    },
                    child: InkWell(
                      onTap: () {
                        blocCartLocal.add(AddData(modelSanPhamMain: ModelSanPhamMain2(
                          id: model.product!.id,
                          amount: 1,
                          max: model.product!.amount
                        )));

                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                            border: Border.all(color: ColorApp.red),
                            color: ColorApp.red),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.white,
                              ),
                              Text(
                                'ĐẶT HÀNG',
                                style: StyleApp.textStyle600(
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
               BlocListener(
                    bloc: blocCartLocal2,
                    listener: (_, StateBloc state) {
                      if (state is LoadSuccess) {
                        context.read<BlocCartLocal>().add(GetCart());
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: Duration(seconds: 1),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Đã thêm thành công'),
                            ],
                          ),
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.zero,
                        ));
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>GioHangScreen()));
                      }
                    },
                    child: InkWell(
                      onTap: () {
                        blocCartLocal2.add(AddData(modelSanPhamMain: ModelSanPhamMain2(
                            id: model.product!.id,
                            amount: 1,
                            max: model.product!.amount
                        )));
                        // blocCartLocal.add(AddData(modelSanPhamMain: model));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                            border: Border.all(color: ColorApp.red)),
                        child: Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.add,
                                color: ColorApp.red,
                              ),
                              Text(
                                'LÊN ĐƠN',
                                style: StyleApp.textStyle600(color: ColorApp.red),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
         return SizedBox();
          },
          bloc: bloc_infoPrd,
        ),
      ),
    );
  }
}
