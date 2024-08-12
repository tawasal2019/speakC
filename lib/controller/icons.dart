import '../model/content.dart';
import '../model/library.dart';

List<lib> iconsList = [
  lib("المدرسة", "assets/IconLib/School/school.png", "yes", [
    Content("حاسبة ", "assets/IconLib/School/calculator.png", "false", "", "",
        "false"),
    Content("حقيبة ظهر ", "assets/IconLib/School/backpack.png", "false", "", "",
        "false"),
    Content("زائد ", "assets/IconLib/School/add.png", "false", "", "", "false"),
    Content(
        "ناقص ", "assets/IconLib/School/remove.png", "false", "", "", "false"),
    Content("نصف ", "assets/IconLib/School/half.png", "false", "", "", "false"),
    Content(
        "يساوي ", "assets/IconLib/School/equal.png", "false", "", "", "false"),
    Content(
        "قسمة ", "assets/IconLib/School/divide.png", "false", "", "", "false"),
    Content(
        "رقم ", "assets/IconLib/School/numbers.png", "false", "", "", "false"),
    Content(
        "فواصل ", "assets/IconLib/School/comma.png", "false", "", "", "false"),
    Content(
        "رتب ", "assets/IconLib/School/arrange.png", "false", "", "", "false"),
    Content("دبوس", "assets/IconLib/School/18.png", "false", "", "", "false"),
  ]),
  lib("الملابس", "assets/IconLib/clothes/0.png", "yes", [
    Content("تغيير الملابس", "assets/IconLib/clothes/change.png", "false", "",
        "", "false"),
    Content("فتح الزر  ", "assets/IconLib/clothes/button.png", "false", "", "",
        "false"),
    Content("اغلاق الزر", "assets/IconLib/clothes/button (1).png", "false", "",
        "", "false"),
    Content("كبير جدا", "assets/IconLib/clothes/loose.png", "false", "", "",
        "false"),
    Content("ضيق جدا", "assets/IconLib/clothes/TightJeans.png", "false", "", "",
        "false"),
    Content(
        "متسخ", "assets/IconLib/clothes/dirty.png", "false", "", "", "false"),
    Content("ارتداء الملابس", "assets/IconLib/clothes/getDressed.png", "false",
        "", "", "false"),
    Content("اغلاق السحاب", "assets/IconLib/clothes/zipper.png", "false", "",
        "", "false"),
    Content("فتح السحاب", "assets/IconLib/clothes/unzip.png", "false", "", "",
        "false"),
    Content("بنطال مبلل  ", "assets/IconLib/clothes/wetpants.png", "false", "",
        "", "false"),
    Content("ملابس داخلية", "assets/IconLib/clothes/underwear.png", "false", "",
        "", "false"),
    Content(
        "شراب", "assets/IconLib/clothes/socks.png", "false", "", "", "false"),
    Content("حذاء رياضي", "assets/IconLib/clothes/sneakers.png", "false", "",
        "", "false"),
    Content(
        "ملابس  ", "assets/IconLib/clothes/0.png", "false", "", "", "false"),
    Content(
        "محفظة", "assets/IconLib/clothes/wallet.png", "false", "", "", "false"),
    Content(
        "ساعة", "assets/IconLib/clothes/watch.png", "false", "", "", "false"),
    Content("أقراط أذن ", "assets/IconLib/clothes/earings.png", "false", "", "",
        "false"),
    Content("تنورة ", "assets/IconLib/clothes/skirt-m.png", "false", "", "",
        "false"),
    Content(" عباية ", "assets/IconLib/clothes/abaya.png", "false", "", "",
        "false"),
    Content(" شورت ", "assets/IconLib/clothes/shorts.png", "false", "", "",
        "false"),
    Content(" حذاء ", "assets/IconLib/clothes/shoes-m.png", "false", "", "",
        "false"),
    Content(
        " كوت ", "assets/IconLib/clothes/Coat.png", "false", "", "", "false"),
    Content(
        " كاب ", "assets/IconLib/clothes/cap.png", "false", "", "", "false"),
    Content(
        " قميص ", "assets/IconLib/clothes/Shirt.png", "false", "", "", "false"),
    Content(
        "حقيبة  ", "assets/IconLib/clothes/3-m.png", "false", "", "", "false"),
    Content(" اكسسوارات ", "assets/IconLib/clothes/1-m.png", "false", "", "",
        "false"),
    Content("ملابس ملونه ", "assets/IconLib/clothes/clothes-m.png", "false", "",
        "", "false"),
  ]),
  lib("الأماكن", "assets/IconLib/Places/place.png", "yes", [
    Content("مدرسة ", "assets/IconLib/Places/school-bus.png", "false", "", "",
        "false"),
    Content(
        "منزل ", "assets/IconLib/Places/home.png", "false", "", "", "false"),
    Content("مستشفى", "assets/IconLib/Places/hospital.png", "false", "", "",
        "false"),
    Content("مكتبة ", "assets/IconLib/Places/library (1).png", "false", "", "",
        "false"),
    Content("مركز تجاري", "assets/IconLib/Places/shopping-center.png", "false",
        "", "", "false"),
    Content("محل قهوة ", "assets/IconLib/Places/coffeeshop.png", "false", "",
        "", "false"),
    Content("مطعم ", "assets/IconLib/Places/restaurant.png", "false", "", "",
        "false"),
    Content(
        "مسجد ", "assets/IconLib/Places/mosque.png", "false", "", "", "false"),
    Content("دورة مياه - رجال", "assets/IconLib/Places/Toilet-man.png", "false",
        "", "", "false"),
    Content("دورة مياه - نساء ", "assets/IconLib/Places/Toilet-w.png", "false",
        "", "", "false"),
    Content("سوبر ماركت  ", "assets/IconLib/Places/Supermarket.png", "false",
        "", "", "false"),
    Content(
        "مكة ", "assets/IconLib/Places/mecca.jpg", "false", "", "", "false"),
    Content("منى ", "assets/IconLib/Places/mina.png", "false", "", "", "false"),
    Content("مزدلفة ", "assets/IconLib/Places/Muzdalifah.png", "false", "", "",
        "false"),
  ]),
  lib("العائلة", "assets/IconLib/family/0.jpg", "yes", [
    Content("طفل", "assets/IconLib/family/1.png", "false", "", "", "false"),
    Content("ولد", "assets/IconLib/family/2.png", "false", "", "", "false"),
    Content("اولادي", "assets/IconLib/family/myChildren.png", "false", "", "",
        "false"),
    Content("شيخ", "assets/IconLib/family/6.jpg", "false", "", "", "false"),
    Content(
        "ام ", "assets/IconLib/family/mother.png", "false", "", "", "false"),
    Content(
        "اخ", "assets/IconLib/family/brother.png", "false", "", "", "false"),
    Content(
        "اب ", "assets/IconLib/family/father.png", "false", "", "", "false"),
    Content("اطفال", "assets/IconLib/family/childern.png", "false", "", "",
        "false"),
    Content("عائلة", "assets/IconLib/family/8.jpg", "false", "", "", "false"),
    Content("بنت", "assets/IconLib/family/9.png", "false", "", "", "false"),
    Content("جد", "assets/IconLib/family/10.png", "false", "", "", "false"),
    Content("جدة", "assets/IconLib/family/11.png", "false", "", "", "false"),
    Content("انا", "assets/IconLib/family/12.png", "false", "", "", "false"),
    Content(
        "اخت ", "assets/IconLib/family/Sister.png", "false", "", "", "false"),
  ]),
  lib("الوان", "assets/IconLib/colors-m/0.png", "yes", [
    Content("اسود", "assets/IconLib/colors-m/1.png", "false", "", "", "false"),
    Content("ازرق", "assets/IconLib/colors-m/2.png", "false", "", "", "false"),
    Content("اخضر", "assets/IconLib/colors-m/3.png", "false", "", "", "false"),
    Content(
        "بنفسجي", "assets/IconLib/colors-m/4.png", "false", "", "", "false"),
    Content("احمر", "assets/IconLib/colors-m/5.png", "false", "", "", "false"),
    Content("ابيض", "assets/IconLib/colors-m/6.png", "false", "", "", "false"),
    Content("اصفر", "assets/IconLib/colors-m/7.png", "false", "", "", "false"),
  ]),
  lib("الجسم", "assets/IconLib/body/0.png", "yes", [
    Content("كعب", "assets/IconLib/body/1.png", "false", "", "", "false"),
    Content("لسان", "assets/IconLib/body/2.png", "false", "", "", "false"),
    Content("ذراع", "assets/IconLib/body/3.png", "false", "", "", "false"),
    Content("عين", "assets/IconLib/body/4.png", "false", "", "", "false"),
    Content(
        "أصابع القدم", "assets/IconLib/body/5.png", "false", "", "", "false"),
    Content("اسنان", "assets/IconLib/body/6.png", "false", "", "", "false"),
    Content("كتف", "assets/IconLib/body/7.png", "false", "", "", "false"),
    Content("رقبة", "assets/IconLib/body/8.png", "false", "", "", "false"),
    Content("يد ", "assets/IconLib/body/hands.png", "false", "", "", "false"),
    Content("اذن ", "assets/IconLib/body/ear.png", "false", "", "", "false"),
    Content("قدم", "assets/IconLib/body/foot.png", "false", "", "", "false"),
    Content("شعر", "assets/IconLib/body/hair.png", "false", "", "", "false"),
    Content(
        "لسان ", "assets/IconLib/body/tongue.png", "false", "", "", "false"),
  ]),
  lib("المنزل", "assets/IconLib/Home/0.jpg", "yes", [
    Content("سرير أطفال", "assets/IconLib/Home/babyBed.png", "false", "", "",
        "false"),
    Content("سرير", "assets/IconLib/Home/Bed.png", "false", "", "", "false"),
    Content("غرفة نوم", "assets/IconLib/Home/bedroom.png", "false", "", "",
        "false"),
    Content("سلة مهملات", "assets/IconLib/Home/wastebasket.png", "false", "",
        "", "false"),
    Content("كرسي", "assets/IconLib/Home/chair.png", "false", "", "", "false"),
    Content(" ادراج", "assets/IconLib/Home/8.png", "false", "", "", "false"),
    Content("حمام", "assets/IconLib/Home/public-toilet.png", "false", "", "",
        "false"),
    Content(
        "المطبخ ", "assets/IconLib/Home/kitchen.png", "false", "", "", "false"),
    Content("منديل يد ", "assets/IconLib/Home/tissue.png", "false", "", "",
        "false"),
    Content("أريكة", "assets/IconLib/Home/sofa.png", "false", "", "", "false"),
    Content(
        "اجهزة تجكم ", "assets/IconLib/Home/0.jpg", "false", "", "", "false"),
    Content(
        "غطاء", "assets/IconLib/Home/bedCover.png", "false", "", "", "false"),
    Content("خزانة", "assets/IconLib/Home/12.png", "false", "", "", "false"),
    Content("مفتاح", "assets/IconLib/Home/key.jpg", "false", "", "", "false"),
    Content("ممسحة", "assets/IconLib/Home/wiper.png", "false", "", "", "false"),
    Content("مشبك", "assets/IconLib/Home/buckle.png", "false", "", "", "false"),
    Content("مقعد", "assets/IconLib/Home/seat.png", "false", "", "", "false"),
    Content(
        " شباك", "assets/IconLib/Home/windows.png", "false", "", "", "false"),
    Content("الطابق العلوي", "assets/IconLib/Home/upstairs.png", "false", "",
        "", "false"),
    Content("الطابق السفلي", "assets/IconLib/Home/downstairs.png", "false", "",
        "", "false"),
    Content("الباب", "assets/IconLib/Home/door-closed.png", "false", "", "",
        "false"),
    Content("العاب كروت", "assets/IconLib/Home/card-game.png", "false", "", "",
        "false"),
  ]),
  lib("الحيوانات", "assets/IconLib/Animall/0.png", "yes", [
    Content("حمار", "assets/IconLib/Animall/18.jpg", "false", "", "", "false"),
    Content("ذئب", "assets/IconLib/Animall/17.jpg", "false", "", "", "false"),
    Content("ثعبان", "assets/IconLib/Animall/13.png", "false", "", "", "false"),
    Content("نمر ", "assets/IconLib/Animall/16.png", "false", "", "", "false"),
    Content("طاووس", "assets/IconLib/Animall/15.jpg", "false", "", "", "false"),
    Content("راما", "assets/IconLib/Animall/12.png", "false", "", "", "false"),
    Content(
        "سلحفاة", "assets/IconLib/Animall/14.png", "false", "", "", "false"),
    Content("فيل", "assets/IconLib/Animall/21.jpg", "false", "", "", "false"),
    Content("خفاش", "assets/IconLib/Animall/20.png", "false", "", "", "false"),
    Content("بطة", "assets/IconLib/Animall/19.png", "false", "", "", "false"),
    Content("دب", "assets/IconLib/Animall/1.jpg", "false", "", "", "false"),
    Content("عصفور", "assets/IconLib/Animall/2.png", "false", "", "", "false"),
    Content("قطة", "assets/IconLib/Animall/3.png", "false", "", "", "false"),
    Content("دجاج", "assets/IconLib/Animall/4.png", "false", "", "", "false"),
    Content("بقرة", "assets/IconLib/Animall/5.jpg", "false", "", "", "false"),
    Content("غراب", "assets/IconLib/Animall/6.jpg", "false", "", "", "false"),
    Content("غزال", "assets/IconLib/Animall/7.png", "false", "", "", "false"),
    Content(
        "ديناصور", "assets/IconLib/Animall/8.jpg", "false", "", "", "false"),
    Content("ماعز", "assets/IconLib/Animall/9.png", "false", "", "", "false"),
    Content("كلب", "assets/IconLib/Animall/10.png", "false", "", "", "false"),
    Content("ارنب", "assets/IconLib/Animall/11.png", "false", "", "", "false"),
  ]),
  lib("الطعام", "assets/IconLib/food/veg.png", "yes", [
    Content("خضروات", "assets/IconLib/food/veg.png", "false", "", "", "false"),
    Content(
        "طماطم", "assets/IconLib/food/tomato.png", "false", "", "", "false"),
    Content("فراولة", "assets/IconLib/food/strawbrry.png", "false", "", "",
        "false"),
    Content("قرع", "assets/IconLib/food/pumpkin.png", "false", "", "", "false"),
    Content("بطاطس مقلي", "assets/IconLib/food/potatoes.jpg", "false", "", "",
        "false"),
    Content("بيتزا", "assets/IconLib/food/pizza.png", "false", "", "", "false"),
    Content("كمثرى", "assets/IconLib/food/pear.png", "false", "", "", "false"),
    Content(
        "فطر", "assets/IconLib/food/mushroom.jpg", "false", "", "", "false"),
    Content("نعناع", "assets/IconLib/food/mint.png", "false", "", "", "false"),
    Content("غداء", "assets/IconLib/food/lunch.jpg", "false", "", "", "false"),
    Content(
        "ملفوف", "assets/IconLib/food/lettuce.jpg", "false", "", "", "false"),
    Content("مانجو", "assets/IconLib/food/mango.jpg", "false", "", "", "false"),
    Content("عنب", "assets/IconLib/food/grape.png", "false", "", "", "false"),
    Content(
        "فواكهه", "assets/IconLib/food/fruits.png", "false", "", "", "false"),
    Content(
        "فلفل", "assets/IconLib/food/hot-pepper.png", "false", "", "", "false"),
    Content("آيسكريم", "assets/IconLib/food/icecream.jpg", "false", "", "",
        "false"),
    Content("كيوي", "assets/IconLib/food/ki.png", "false", "", "", "false"),
  ]),
  lib("فعل", "assets/IconLib/actions/family.png", "yes", [
    Content(
        "فكرة", "assets/IconLib/actions/idea.png", "false", "", "", "false"),
    Content(
        "ضحك", "assets/IconLib/actions/laugh.jpg", "false", "", "", "false"),
    Content("تذكر", "assets/IconLib/actions/remember.png", "false", "", "",
        "false"),
    Content(
        "غضب", "assets/IconLib/actions/angry.jpg", "false", "", "", "false"),
    Content(
        "يحلم", "assets/IconLib/actions/dream.png", "false", "", "", "false"),
    Content("عض", "assets/IconLib/actions/bite.png", "false", "", "", "false"),
    Content(
        "سعال", "assets/IconLib/actions/cough.png", "false", "", "", "false"),
    Content(
        "يتحدث", "assets/IconLib/actions/speak.png", "false", "", "", "false"),
    Content(
        "ينظر", "assets/IconLib/actions/look.png", "false", "", "", "false"),
    Content("اخذ صورة", "assets/IconLib/actions/TakeImage.png", "false", "", "",
        "false"),
    Content(
        "تنظر", "assets/IconLib/actions/sheLook.png", "false", "", "", "false"),
    Content("الم", "assets/IconLib/actions/pain.png", "false", "", "", "false"),
    Content("مستيقظ ", "assets/IconLib/actions/awake.png", "false", "", "",
        "false"),
  ]),
  lib("وسائل نقل", "assets/IconLib/transportation/0.png", "yes", [
    Content("قارب", "assets/IconLib/transportation/1.png", "false", "", "",
        "false"),
    Content(
        "باص", "assets/IconLib/transportation/2.png", "false", "", "", "false"),
    Content("سيارة اجرة", "assets/IconLib/transportation/3.png", "false", "",
        "", "false"),
    Content("سيارة", "assets/IconLib/transportation/4.png", "false", "", "",
        "false"),
    Content("دراجة نارية", "assets/IconLib/transportation/5.png", "false", "",
        "", "false"),
    Content("سيارة الشرطة", "assets/IconLib/transportation/6.png", "false", "",
        "", "false"),
    Content("سيارة اسعاف", "assets/IconLib/transportation/ambulance.png",
        "false", "", "", "false"),
    Content("طوافة", "assets/IconLib/transportation/7.png", "false", "", "",
        "false"),
    Content("طريق", "assets/IconLib/transportation/8.png", "false", "", "",
        "false"),
    Content("سفينة", "assets/IconLib/transportation/9.png", "false", "", "",
        "false"),
    Content("سيارة رياضية", "assets/IconLib/transportation/10.png", "false", "",
        "", "false"),
    Content("شارع", "assets/IconLib/transportation/11.png", "false", "", "",
        "false"),
    Content("قطار", "assets/IconLib/transportation/12.png", "false", "", "",
        "false"),
    Content("سيكل", "assets/IconLib/transportation/bicycle.png", "false", "",
        "", "false"),
    Content("سكوتر", "assets/IconLib/transportation/Scooter.png", "false", "",
        "", "false"),
    Content("سيارة اطفاء", "assets/IconLib/transportation/fire-truck.png",
        "false", "", "", "false"),
  ]),
  lib("مهن", "assets/IconLib/careers/0.png", "yes", [
    Content("خباز", "assets/IconLib/careers/1.jpg", "false", "", "", "false"),
    Content("حلاق", "assets/IconLib/careers/2.jpg", "false", "", "", "false"),
    Content("مهنة ", "assets/IconLib/careers/3.png", "false", "", "", "false"),
    Content("شرطي", "assets/IconLib/careers/4.png", "false", "", "", "false"),
    Content("مديرة", "assets/IconLib/careers/5.png", "false", "", "", "false"),
    Content("دكتورة", "assets/IconLib/careers/doctor.png", "false", "", "",
        "false"),
    Content("سائق", "assets/IconLib/careers/7.png", "false", "", "", "false"),
    Content("صباغ", "assets/IconLib/careers/8.jpg", "false", "", "", "false"),
    Content("دكتور", "assets/IconLib/careers/doctors.png", "false", "", "",
        "false"),
    Content("سباح", "assets/IconLib/careers/9.png", "false", "", "", "false"),
    Content(
        "معلم/ة", "assets/IconLib/careers/10.png", "false", "", "", "false"),
  ]),
  lib("عبادات", "assets/IconLib/worship/0.png", "yes", [
    Content("عرفة", "assets/IconLib/worship/1.png", "false", "", "", "false"),
    Content(
        "صلاة العصر", "assets/IconLib/worship/2.png", "false", "", "", "false"),
    Content(
        "صلاة الفجر", "assets/IconLib/worship/4.png", "false", "", "", "false"),
    Content("الكعبة", "assets/IconLib/worship/5.jpg", "false", "", "", "false"),
    Content("صلاة ليلة القدر", "assets/IconLib/worship/6.jpg", "false", "", "",
        "false"),
    Content("دعاء", "assets/IconLib/worship/7.png", "false", "", "", "false"),
    Content(
        "السلام", "assets/IconLib/worship/77.png", "false", "", "", "false"),
    Content(
        "الصلاة", "assets/IconLib/worship/pray.png", "false", "", "", "false"),
    Content("صلاة القيام", "assets/IconLib/worship/8.png", "false", "", "",
        "false"),
    Content("الصيام", "assets/IconLib/worship/fasting.png", "false", "", "",
        "false"),
    Content("ركوع", "assets/IconLib/worship/9.png", "false", "", "", "false"),
    Content("سجود", "assets/IconLib/worship/10.png", "false", "", "", "false"),
    Content("تكبير", "assets/IconLib/worship/11.png", "false", "", "", "false"),
    Content(
        "التشهد", "assets/IconLib/worship/12.png", "false", "", "", "false"),
    Content(
        "الطواف", "assets/IconLib/worship/13.png", "false", "", "", "false"),
  ]),
  lib("أشكال", "assets/IconLib/Shapes/shapes.png", "yes", [
    Content("دائرة  ", "assets/IconLib/Shapes/circle.png", "false", "", "",
        "false"),
    Content(
        " مربع", "assets/IconLib/Shapes/square.png", "false", "", "", "false"),
    Content("معين", "assets/IconLib/Shapes/oval.png", "false", "", "", "false"),
    Content(
        "مثلث", "assets/IconLib/Shapes/tringle.png", "false", "", "", "false"),
    Content("نجمة", "assets/IconLib/Shapes/star.png", "false", "", "", "false"),
    Content("مستطيل", "assets/IconLib/Shapes/rectangle1.png", "false", "", "",
        "false")
  ]),
  lib("اتجاهات", "assets/IconLib/directione/postions.png", "yes", [
    Content("جنوب ", "assets/IconLib/directione/direction.png", "false", "", "",
        "false"),
    Content(
        "شرق", "assets/IconLib/directione/west.png", "false", "", "", "false"),
    Content(
        "غرب ", "assets/IconLib/directione/east.png", "false", "", "", "false"),
    Content("شمال ", "assets/IconLib/directione/direction (1).png", "false", "",
        "", "false"),
    //-------------------------------------------------------------------
    Content(
        "على  ", "assets/IconLib/directione/on.png", "false", "", "", "false"),
    Content(" مقابل", "assets/IconLib/directione/front.jpg", "false", "", "",
        "false"),
    Content(
        "أسفل", "assets/IconLib/directione/down.png", "false", "", "", "false"),
    Content("يمين", "assets/IconLib/directione/right.png", "false", "", "",
        "false"),
    Content("بين", "assets/IconLib/directione/between.png", "false", "", "",
        "false"),
    Content("يسار", "assets/IconLib/directione/left-arrow.png", "false", "", "",
        "false"),
  ]),
];
