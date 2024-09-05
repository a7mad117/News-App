import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import '../../modules/web_view/web_view_screen.dart';


Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType textInputType,
  void Function(String)? onSubmit,
  void Function(String)? onChang,
  void Function()? onTap,
  bool isPassword = false,
  required String? Function(String?) validator,
  required String labelText,
  required IconData prefixIcon,
  IconData? suffixIcon,
  void Function()? suffixPress,
  bool? showCursor,
  bool readOnly = false,
  bool autofocus = false,
}) =>
    TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: textInputType,
      onFieldSubmitted: onSubmit,
      onChanged: onChang,
      onTap: onTap,
      autofocus: autofocus,
      showCursor: showCursor,
      readOnly: readOnly,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon),
                onPressed: suffixPress,
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );



Widget buildArticleItem(article, BuildContext context) {
  ImageProvider<Object>? isImage =
  (article['urlToImage'] != null? NetworkImage(
      '${article['urlToImage']}'):const AssetImage('assets/images/no_image.jpg')) as ImageProvider<Object>?;
  return InkWell(
    onTap: (){navigateTo(context, WebViewScreen(url: article['url'],));},
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: isImage!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: const TextStyle(
                      color: Colors.grey,
                      // fontWeight: FontWeight.bold,
                      // fontSize: 20,
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget myDivider() {
  return const Divider(
    color: Colors.grey,
    thickness: 1,
    indent: 20,
  );
}

Widget articleBuilder(List<dynamic> list,BuildContext context ,{bool? condition}) {
  return BuildCondition(
    condition: condition ?? list.isNotEmpty,
    fallback: (context) => const Center(child: CircularProgressIndicator()),
    builder: (context) => ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return buildArticleItem(list[index], context);
      },
      separatorBuilder: (context, index) => myDivider(),
      itemCount: list.length,
    ),
  );
}

void navigateTo( BuildContext context,Widget screen) => Navigator.push(context,
    MaterialPageRoute(
        builder: (context) => screen
    )
);

