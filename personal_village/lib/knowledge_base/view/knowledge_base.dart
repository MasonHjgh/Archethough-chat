import 'package:flutter/material.dart';
import 'package:personal_village/knowledge_base/widgets/sliver_search_app_bar.dart';

class KnowledgeBase extends StatelessWidget {
  const KnowledgeBase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(delegate: SliverSearchAppBar()),
        SliverToBoxAdapter(
          child: SizedBox(
            height: MediaQuery.of(context).size.width * 0.7,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: GridView(
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                  mainAxisSpacing: 12.0,
                  crossAxisSpacing: 12.0,
                ),
                children: [
                  HorizontalIcon(
                    Icon(
                      Icons.add,
                      size: 66,
                      color: Color(0xFFC60000),
                    ),
                    Text(
                      "Emergency Services",
                      style: TextStyle(
                        color: Color(0xFFC60000),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  HorizontalIcon(
                    Icon(
                      Icons.medical_information,
                      size: 66,
                      color: Color(0xFF00A36C),
                    ),
                    Text(
                      "First Aid Info",
                      style: TextStyle(
                          color: Color(0xFF00A36C),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  HorizontalIcon(
                    Icon(
                      Icons.person_outline,
                      size: 66,
                      color: Colors.black,
                    ),
                    Text(
                      "Contact Village Members",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  HorizontalIcon(
                    Icon(
                      Icons.add,
                      size: 66,
                      color: Color(0xFFC60000),
                    ),
                    Text(
                      "Emergency Services",
                      style: TextStyle(
                          color: Color(0xFFC60000),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  HorizontalIcon(
                    Icon(
                      Icons.medical_information,
                      size: 66,
                      color: Color(0xFF00A36C),
                    ),
                    Text(
                      "First Aid Info",
                      style: TextStyle(
                          color: Color(0xFF00A36C),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  HorizontalIcon(
                    Icon(
                      Icons.person_outline,
                      size: 66,
                      color: Colors.black,
                    ),
                    Text(
                      "Contact Village Members",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Padding(
            padding: EdgeInsets.only(top: 28, left: 10, bottom: 3),
            child: Text(
              "App How-To's",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          KnowledgeBaseItem(),
          KnowledgeBaseItem(),
          KnowledgeBaseItem(),
          KnowledgeBaseItem(),
          KnowledgeBaseItem(),
          KnowledgeBaseItem(),
          KnowledgeBaseItem(),
          KnowledgeBaseItem(),
        ]))
      ],
    );
  }
}

class HorizontalIcon extends StatelessWidget {
  const HorizontalIcon(this.icon, this.text, {Key? key}) : super(key: key);
  final Widget icon;
  final Widget text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3),
      margin: EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
          color: Color(0xFFF0F0F0), borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          Flexible(child: text),
        ],
      ),
    );
  }
}

class KnowledgeBaseItem extends StatelessWidget {
  const KnowledgeBaseItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFE0E0E0), borderRadius: BorderRadius.circular(24)),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          Flexible(
            child: Icon(
              Icons.book,
              size: 120,
              color: Colors.orange,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FittedBox(
                  child: Text(
                    "A very interesting thing",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "You must learn how to do your taxes efficiently lorem ipsum dolor sit amet lorem ipsum dolor sit amet  how to do your taxes efficiently lorem ipsum dolor sit amet lorem ipsum dolor sit amet  how to do your taxes efficiently lorem ipsum dolor sit amet lorem ipsum dolor sit amet",
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black45,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
