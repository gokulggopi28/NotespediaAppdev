import '../../../utils/constants/app_export.dart';

Widget greenContainer (BuildContext context,String heading,String subText,String buttonText ,void Function()? onTap){
  return Container(
    width: 361,
    decoration: BoxDecoration(color: Color.fromRGBO(5, 207, 100, 1)),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16,24,16,16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading,
                style: TextStyle(
                    fontFamily: "Inter",
                    height: 29.05 / 24,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              SizedBox(height: 8,),
              Text(
                subText,
                style: TextStyle(
                    fontFamily: "Inter-Medium",
                    fontSize: 14,
                    height: 16.94/14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              SizedBox(height: 32,),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  height: 36,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2)),
                  child: Center(
                      child: Text(
                        buttonText,
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      )),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}