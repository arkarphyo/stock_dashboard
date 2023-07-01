library app_constant;

import 'package:flutter/material.dart';

import '../Model/Profile.dart';
import '../Screen/Components/Header.dart';
import '../Screen/Components/ProfileTile.dart';

const kBorderRadius = 10.0;
const kSpacing = 20.0;

const kFontColorPallets = [
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(210, 210, 210, 1),
  Color.fromRGBO(170, 170, 170, 1),
  Color.fromARGB(100, 100, 100, 0)
];

const kNotifColor = Color.fromRGBO(74, 177, 120, 1);

const key = "D@nger0us99astra";

const infoMessages = [
  {
    "registerSuccessInfo":
        "ဖြင့် Register ပြုလုပ်ခြင်း အောင်မြင်ပါတယ်။ Admin Account မှ သင့်ကို Active ပြုလုပ်ရန် လိုအပ်ပါသဖြင့် Admin အတည်ပြုပြီးပါက ယခု ပြုလုပ်ထားသော Username နှင့် Password ဖြင့် Login ဝင်ပြီး အသုံးပြုနိုင်မည် ဖြစ်ပါတယ်။",
    "registerFailedInfo":
        "Register ပြုလုပ်ခြင်း မအောင်မြင်ပါ။ သင့်ရဲ့ လုပ်ဆောင်မှု များထဲမှ တစ်ခုခု မှားနေခြင်း (သို့မဟုတ်) Internet Connection အား ပြန်လည် စစ်ဆေးပြီး ထပ်မံ ကြိုးစာကြည့်ပေးပါရန်။",
    "requestAdminApprove":
        "Admin Account မှ သင့်ကို Active ပြုလုပ်ရန် လိုအပ်ပါသဖြင့် Admin အတည်ပြုပြီးမှသာ Login ဝင်ပြီး အသုံးပြုနိုင်မည် ဖြစ်ပါတယ်။",
  },
];

class Font {
  static const poppins = "Poppins";
}

Widget BuildHeader(
  String headerName, {
  Function()? onPressedMenu,
  Function()? onPressedAdd,
  Function()? onPressRightSideBar,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: kSpacing / 4),
    child: Row(
      children: [
        if (onPressedMenu != null)
          Padding(
            padding: const EdgeInsets.only(right: kSpacing / 4),
            child: IconButton(
              onPressed: onPressedMenu,
              icon: const Icon(Icons.menu),
              tooltip: "MENU",
            ),
          ),
        Flexible(child: Header()),
        if (onPressedAdd != null)
          Padding(
            padding: const EdgeInsets.all(kSpacing / 4),
            child: ElevatedButton(
              onPressed: onPressedAdd,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                backgroundColor: Colors.white.withOpacity(0.1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(kSpacing / 4),
                child: Icon(Icons.plus_one_outlined),
              ),
            ),
          ),
        if (onPressRightSideBar != null)
          Padding(
            padding: const EdgeInsets.only(left: kSpacing / 4),
            child: IconButton(
              onPressed: onPressRightSideBar,
              icon: const Icon(Icons.info),
              tooltip: "INFO",
            ),
          ),
      ],
    ),
  );
}

Widget BuildProfile({required Profile data}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: kSpacing),
    child: ProfilTile(
      data: data,
      onPressedNotification: () {},
    ),
  );
}
