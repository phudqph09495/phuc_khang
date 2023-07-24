
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phuc_khang/model/model_search.dart';

import '../../bloc/event_bloc.dart';
import '../../bloc/product/bloc_search.dart';
import '../../bloc/state_bloc.dart';
import '../../config/const.dart';

import '../../model/model_listPro.dart';
import '../../styles/init_style.dart';
import '../../widget/item/load_image.dart';
import '../../widget/loadPage/item_loadfaild.dart';
import 'info_product.dart';


class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  BlocSearch blocSearch = BlocSearch();
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: ColorApp.redText,
            )),
        actions: [
          InkWell(
              onTap: () {
                search.clear();
              },
              child: Icon(
                Icons.clear,
                color: ColorApp.redText,
              ))
        ],
        backgroundColor: ColorApp.whiteF0,
        title: TextFormField(
          controller: search,
          decoration: InputDecoration(
              hintText: 'Tìm kiếm',
              suffixIcon: InkWell(
                  onTap: () {
                    blocSearch.add(GetData(param: search.text));
                    FocusScope.of(context).requestFocus(FocusNode());

                  },
                  child: Icon(Icons.search)),
              hintStyle: StyleApp.textStyle400(fontStyle: FontStyle.italic)),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder(
            bloc: blocSearch,
            builder: (_, StateBloc state) {
              if (state is Loading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: ColorApp.main,
                  ),
                );
              }
              if (state is LoadFail) {
                return      Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        state.error,
                        style: StyleApp.textStyle400(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),


                    ],
                  ),
                );
              }
              if (state is LoadSuccess) {
             ModelSearch list=state.data;
              
                return
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InfoProductScreen(
                                    id: '${list.products![index].id}',
                                  )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  LoadImage(
                                    url:
                                    '${Const.image_host}${list.products![index].thumbnail}',
                                    width:
                                    MediaQuery.of(context).size.width *
                                        0.2,
                                    fit: BoxFit.fitHeight,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${list.products![index].name}',
                                          style: StyleApp.textStyle700(),
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Text(

                                              'Giá lẻ: ${Const.convertPrice('${list.products![index].customerPrice!.originPrice}')}đ',
                                              style: StyleApp.textStyle500(
                                                  color: ColorApp.dark500, fontSize: 16),
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
                                          children: [
                                            Text(

                                              'Giá thùng: ${Const.convertPrice('${list.products![index].customerPrice!.price}')}đ',
                                              style: StyleApp.textStyle600(
                                                  color: ColorApp.redText, fontSize: 16),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),

                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Divider()
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: list.products!.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  );
              }
              return Container();
            }),
      ),
    );
  }
}
