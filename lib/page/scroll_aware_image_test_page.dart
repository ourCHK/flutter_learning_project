import 'package:flutter/material.dart';

class ScrollAwareImageTestPage extends StatefulWidget {
  const ScrollAwareImageTestPage({super.key});

  @override
  State createState() {
    return _ScrollAwareImageProviderState();
  }
}

class _ScrollAwareImageProviderState extends State<ScrollAwareImageTestPage> {
  bool scrollAware = false;

  String text = "CurrentInScrollAware";

  late DisposableBuildContext<_ScrollAwareImageProviderState> awareContext;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changeScrollAware() {
    setState(() {
      if (scrollAware) {
        text = "CurrentInNotScrollAware";
      } else {
        text = "CurrentInScrollAware";
      }
      scrollAware = !scrollAware;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ScrollAwareImageTest")),
      body: Column(
        children: [
          ElevatedButton(onPressed: () => changeScrollAware, child: Text(text)),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                    color: Colors.limeAccent,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        renderChild(context,index),
                        Text("This is the text:$index")
                      ],
                    ));
              },
              itemCount: 30,
              cacheExtent: 300,
            ),
          )
        ],
      ),
    );
  }

  Widget renderChild(BuildContext buildContext, int index) {
    // if (scrollAware) {
    //   return renderScrollAwareImage(buildContext,index);
    // } else {
      return renderNormalImage(index);
    // }
  }

  Widget renderNormalImage(int index) {
    // return Image.network(imageList[index],fit: BoxFit.fill);
    return Image.network(imageList[index], width: 200, height: 100,fit: BoxFit.fill,);
  }

  Widget renderScrollAwareImage(BuildContext buildContext, int index) {
    return Image(
        width: 100,
        height: 100,
        image: ScrollAwareImageProvider(
          context: awareContext,
          imageProvider: const AssetImage("images/image.jpeg"),
        ));
  }

  List<String> imageList = [
    "https://sit-marketing-img.bankneo.co.id/ads/img/KvOOE3rs-FcL-JUimYORjtZ0P4sIA-mnc__9yeJAERs.png",
    "https://sit-marketing-img.bankneo.co.id/ads/img/mE06YhS6JxGn2zI-UbbAvMnDZjuU4Hl6L0C2Ioo-K5o.png",
    "https://sit-marketing-img.bankneo.co.id/ads/img/KVyz-MzX52qhqtOkFxTk0y5jGY5YHrIns73a1YfXmbA.png",
    "https://sit-marketing-img.bankneo.co.id/ads/img/EfR4SLgxMK5jBR_YbbdPilGfwkBb1DaTj0te7AjdUdA.png",
    "https://sit-marketing-img.bankneo.co.id/ads/img/wDR_UdbmAlkiCSnHkPPGcW8jhvA9hu6QVnvd2V_uw58.png",
    "https://sit-marketing-img.bankneo.co.id/ads/img/iOpeszDg4808lelttW5WZ9QNt5MuNch74mNzCn3CnbY.png",
    "https://sit-marketing-img.bankneo.co.id/ads/img/txk01S0FZwlw6EE7fin6nXV1q7wAFEdt5o-niH8E8ok.png",
    "https://sit-marketing-img.bankneo.co.id/ads/img/bW4gfb9_kYVK_0gw8h70eSipFJ3iQmGIi5myxLl8Igg.png",
    "https://sit-marketing-img.bankneo.co.id/ads/img/ukUxr-c5CnnRY1wYDKcin9LO9_unW8gFhbgtLmwGEAQ.png",
    "https://sit-marketing-img.bankneo.co.id/ads/img/jZLttrk1jNOKCsPgxweG5OOjsxsYGKeZ5FF34u-41-E.png",
    "https://sit-marketing-img.bankneo.co.id/ads/img/qs89fGqaQUpRYNtCoBp0Rj3tJvbSnP8UirTKPeh5HIg.png",
    "https://sit-marketing-img.bankneo.co.id/ads/img/J8471n_r8B_hegONViAvg7sd7qtzODyG8xKdGGST628.png",
    "https://sit-marketing-img.bankneo.co.id/ads/img/jU1CTkk-9AsqHr0CgbMuLeVFva7uW4QVFg2UH1caqcE.png",
    "https://sit-marketing-img.bankneo.co.id/ads/img/KXUJES9ooeFrGMSwwulBVE6rw-EpAArQepsTq7VnNBE.png",
    "https://sit-marketing-img.bankneo.co.id/ads/img/xrJ_MC9qo-lSSm-8Cq0wirxcH7PO3FmP-3Xfmn_allc.png",
    "https://sit-marketing-img.bankneo.co.id/ads/img/IFXxQ_3NsxyUWBY_vfJCA9qmQOHoVTpXtnejc8rxSrc.png",
    "https://sit-marketing-img.bankneo.co.id/ads/img/jGIJCoQnzTJXRflCAtz0ObOx1woN-1ha4MFFxYGO-NA.png",
    "https://sit-marketing-img.bankneo.co.id/ads/img/COJdFcp7IkDx9aFyE0EL68SMAH_GFFwNCSHOav3vAUA.png",
    "https://sit-marketing-img.bankneo.co.id/ads/img/Ep1VzpZHaQ5QI20IlZ3xq5XQ_TDIA6OGfMCrpGSUMMs.png",
    "https://sit-marketing-img.bankneo.co.id/ads/img/FXWtE20MGbf2RY9Xhe_fEdU-YXIMcIIcwIxMMTi2IkI.png",
    "https://sit-marketing-img.bankneo.co.id/ads/img/qxQLX63eXaLzy7x-w5gO1n0cVB11_BDqPEQWb1izitc.png",
    "https://sit-marketing-img.bankneo.co.id/news/img/etxha-ow95PvAhxpw8w39jKr3KA5FWK2ib445avJams.png",
    "https://sit-marketing-img.bankneo.co.id/news/img/dEk0PG8cklCBqMzHl02WGZYQx4NqkIl3tcaL0IiOprU.png",
    "https://sit-marketing-img.bankneo.co.id/news/img/Ncygabw6DZ2LpAC4AtQjBYadV4Eep59st4G3sP0AJVc.png",
    "https://sit-marketing-img.bankneo.co.id/ads/img/Af_tkJ3sgIPcSk2G19_NyVpncbSOhKvhOYrEC26qfSQ.png",
    "https://sit-marketing-img.bankneo.co.id/ads/img/9X_l2O_JBgkMEIv0bfMGWOH7nD_HipbXJtIcEFRmHMM.png",
    "https://sit-marketing-img.bankneo.co.id/ads/img/F1nQRQLC7eDdjXh-RUfO_uAXyLr1W88xqIF7Lw2JhtQ.png",
    "https://sit-marketing-img.bankneo.co.id/ads/img/YFiF84JNDYyJg-hZlJcMDfOOAuY91NJr4RNpKvvFlFs.png",
    "https://sit-marketing-img.bankneo.co.id/ads/img/NzrumthBjTyRkfdapYwfCQ-TRoxPhtmnVIfr2vRUdGQ.png",
    "https://sit-marketing-img.bankneo.co.id/ads/img/ktnQT4rWH56JNCrmhV6AtxXRPFE2z-cK8yfsydFfPKE.png",
    "https://sit-marketing-img.bankneo.co.id/ads/img/H_W0n_7HFeOJTpM4owynK3KXIx9UE6f_GLmn3ptKxmg.png",
  ];


}
