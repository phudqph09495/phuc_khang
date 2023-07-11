import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:phuc_khang/screen/home/search_screen.dart';

import '../../bloc/event_bloc.dart';

import '../../bloc/product/bloc_category.dart';
import '../../bloc/product/bloc_productMain.dart';
import '../../bloc/state_bloc.dart';
import '../../config/const.dart';
import '../../item/product_item.dart';
import '../../model/model_category.dart';
import '../../model/model_listPro.dart';
import '../../model/model_productMain.dart';
import '../../styles/init_style.dart';
import '../../widget/app_bar.dart';

import '../../widget/item/input/text_filed.dart';
import '../../widget/item/item_count_down.dart';
import '../../widget/item/load_image.dart';
import '../../widget/loadPage/item_load_page.dart';
import '../../widget/loadPage/item_loadmore.dart';
import 'info_product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  BlocCategory blocCategory = BlocCategory()..add(GetData());
  BlocListPro blocProductMain = BlocListPro();
  ScrollController _controller = ScrollController();
  String cate = 'DANH MỤC';
  int page = 1;
  int id = 0;
  int index1=0;
  Future<void> onRefresh(int id) async {
    page = 1;
    blocProductMain.add(LoadMoreEvent(
      page: page,
      id: id.toString(),
      cleanList: true,
    ));
  }

  loadmore(int id) async {
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        page++;
        blocProductMain.add(LoadMoreEvent(
          page: page,
          id: id.toString(),
          loadMore: true,
        ));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        tittle: InputText1(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SearchScreen()));
          },
          label: 'Tìm kiếm',
          readOnly: true,
          hasLeading: true,
          iconPreFix: InkWell(
            child: Icon(
              Icons.search,
              color: Colors.red,
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          onRefresh(id);
        },
        child: SingleChildScrollView(
          controller: _controller,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 05, vertical: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     showDialog(
                    //         context: context,
                    //         builder: (context) => AlertDialog(
                    //               title: Text('Chọn loại sản phẩm'),
                    //               content: Container(
                    //                 height: MediaQuery.of(context).size.height *
                    //                     0.4,
                    //                 width:
                    //                     MediaQuery.of(context).size.width * 0.8,
                    //                 child: SingleChildScrollView(
                    //                   child: BlocBuilder(
                    //                     builder: (_, StateBloc state) {
                    //                       if (state is LoadSuccess) {
                    //                         ModelCategory model = state.data;
                    //                         id = model.categories![0].id!;
                    //                         onRefresh(id);
                    //                         return Column(
                    //                           children: [
                    //                             ListView.builder(
                    //                               itemBuilder:
                    //                                   (context, index) {
                    //                                 return InkWell(
                    //                                   onTap: () {
                    //                                     setState(() {
                    //                                       id = model
                    //                                           .categories![
                    //                                               index]
                    //                                           .id!;
                    //                                       cate = model
                    //                                               .categories![
                    //                                                   index]
                    //                                               .name!
                    //                                               .toUpperCase() ??
                    //                                           '';
                    //                                     });
                    //
                    //                                     page = 1;
                    //                                     blocProductMain
                    //                                         .add(LoadMoreEvent(
                    //                                       page: page,
                    //                                       id: model
                    //                                           .categories![
                    //                                               index]
                    //                                           .id
                    //                                           .toString(),
                    //                                       cleanList: true,
                    //                                     ));
                    //                                     Navigator.pop(context);
                    //                                   },
                    //                                   child: Card(
                    //                                     color: ColorApp.whiteF0,
                    //                                     margin: EdgeInsets.only(
                    //                                         top: 7),
                    //                                     child: Padding(
                    //                                       padding:
                    //                                           const EdgeInsets
                    //                                               .all(12.0),
                    //                                       child: Text(
                    //                                         '${model.categories![index].name!.toUpperCase()}',
                    //                                         style: StyleApp
                    //                                             .textStyle500(
                    //                                                 fontSize:
                    //                                                     16),
                    //                                       ),
                    //                                     ),
                    //                                   ),
                    //                                 );
                    //                               },
                    //                               shrinkWrap: true,
                    //                               itemCount:
                    //                                   model.categories!.length,
                    //                               physics:
                    //                                   NeverScrollableScrollPhysics(),
                    //                             ),
                    //                           ],
                    //                         );
                    //                       }
                    //                       return SizedBox();
                    //                     },
                    //                     bloc: blocCategory,
                    //                   ),
                    //                 ),
                    //               ),
                    //             ));
                    //   },
                    //   child: Row(
                    //     children: [
                    //       Text(
                    //         cate,
                    //         style: StyleApp.textStyle500(fontSize: 16),
                    //       ),
                    //       Icon(Icons.keyboard_arrow_down_rounded)
                    //     ],
                    //   ),
                    // ),
                    BlocBuilder(
                      builder: (_, StateBloc state) {
                        if (state is LoadSuccess) {
                          ModelCategory model = state.data;
                          id = model.categories![index1].id!;
                          onRefresh(id);
                          return InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text('Chọn loại sản phẩm'),
                                        content: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.4,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                ListView.builder(
                                                  itemBuilder:
                                                      (context, index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        index1=index;
                                                        id = model
                                                            .categories![
                                                        index1]
                                                            .id!;
                                                        setState(() {

                                                          cate = model
                                                                  .categories![
                                                                      index]
                                                                  .name!
                                                                  .toUpperCase() ??
                                                              '';
                                                        });

                                                        page = 1;
                                                        blocProductMain
                                                            .add(LoadMoreEvent(
                                                          page: page,
                                                          id: id.toString(),
                                                          cleanList: true,
                                                        ));
                                                        Navigator.pop(context);
                                                      },
                                                      child: Card(
                                                        color: ColorApp.whiteF0,
                                                        margin: EdgeInsets.only(
                                                            top: 7),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(12.0),
                                                          child: Text(
                                                            '${model.categories![index].name!.toUpperCase()}',
                                                            style: StyleApp
                                                                .textStyle500(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      model.categories!.length,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ));
                            },
                            child: Row(
                              children: [
                                Text(
                                  cate,
                                  style: StyleApp.textStyle500(fontSize: 16),
                                ),
                                Icon(Icons.keyboard_arrow_down_rounded)
                              ],
                            ),
                          );
                        }
                        return SizedBox();
                      },
                      bloc: blocCategory,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    BlocBuilder(
                      builder: (_, StateBloc state) {
                        final length =
                            state is LoadSuccess ? state.checkLength : false;
                        final hasMore =
                            state is LoadSuccess ? state.hasMore : false;
                        final list = state is LoadSuccess
                            ? state.data as List<Prod>
                            : <Prod>[];
                        return ItemLoadPage(
                            state: state,
                            onTapErr: () {
                              onRefresh(id);
                            },
                            success: Column(
                              children: [
                                GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10,
                                          mainAxisExtent: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.35),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => InfoProductScreen(
                                                  id: '${list[index].id}',
                                                )));
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: ColorApp.grey4F)),
                                          child: Column(
                                            children: [
                                              Stack(
                                                children: [
                                                  Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color: ColorApp.red,
                                                            strokeAlign: BorderSide
                                                                .strokeAlignOutside)),
                                                    // child: Image.asset(
                                                    //
                                                    //   'assets/images/exp.jpg',
                                                    //
                                                    //   height: MediaQuery.of(context).size.height*0.2
                                                    //   ,fit: BoxFit.fill,
                                                    // ),
                                                    child: LoadImage(
                                                      url:
                                                          '${Const.image_host}${list[index].thumbnail}',
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.22,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.22,
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                  ),
                                                  // Positioned(
                                                  //   top: 0,
                                                  //   left: 0,
                                                  //   child: Container(
                                                  //     decoration: BoxDecoration(
                                                  //         color: ColorApp.red,
                                                  //         borderRadius: BorderRadius.only(
                                                  //             topRight: Radius.circular(20),
                                                  //             bottomRight: Radius.circular(20))),
                                                  //     child: Padding(
                                                  //       padding:
                                                  //       EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                                                  //       child: Text(
                                                  //         (100 -
                                                  //             (double.parse(
                                                  //                 '${widget.modelSanPhamMain.price}') *
                                                  //                 100 /
                                                  //                 double.parse(
                                                  //                     '${widget.modelSanPhamMain.priceBeforeDiscount}'))
                                                  //                 .round())
                                                  //             .toString() +
                                                  //             '%',
                                                  //         style: StyleApp.textStyle500(
                                                  //             color: Colors.white, fontSize: 14),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  // Positioned(
                                                  //   top: 0,
                                                  //   right: 0,
                                                  //   child: Container(
                                                  //     decoration: BoxDecoration(
                                                  //         color: ColorApp.red,
                                                  //         borderRadius: BorderRadius.only(
                                                  //             topLeft: Radius.circular(20),
                                                  //             bottomLeft: Radius.circular(20))),
                                                  //     child: Padding(
                                                  //       padding:
                                                  //       EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                                                  //       child: Text(
                                                  //         widget.modelSanPhamMain.isStock == '1'
                                                  //             ? 'Còn hàng'
                                                  //             : 'Hết hàng',
                                                  //         style: StyleApp.textStyle600(
                                                  //             color: Colors.white, fontSize: 14),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5),
                                                      child: Text(
                                                        '${list[index].name}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                        style: StyleApp
                                                            .textStyle700(),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 4),
                                                      child: Column(

                                                        children: [
                                                          Text('Giá lẻ: ${Const.convertPrice('${list[index].customerPrice!.originPrice}')}đ',  style: StyleApp
                                                              .textStyle600(
                                                              color:
                                                              ColorApp
                                                                  .black00,
                                                              fontSize: 16),),
                                                          Text(
                                                            'Giá bán: ${Const.convertPrice('${list[index].customerPrice!.price}')}đ',
                                                            style: StyleApp
                                                                .textStyle600(
                                                                    color:
                                                                        ColorApp
                                                                            .red,
                                                                    fontSize: 16),
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )),
                                    );
                                  },
                                  itemCount: list.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                ),
                                ItemLoadMore(
                                  hasMore: hasMore,
                                  length: length,
                                ),
                              ],
                            ));
                      },
                      bloc: blocProductMain,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
