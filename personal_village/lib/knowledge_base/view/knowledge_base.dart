import 'package:flutter/material.dart';

class KnowledgeBase extends StatelessWidget {
  const KnowledgeBase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            //background: Ink.image(image: 'assets/images/LightLogo.png')
            expandedHeight: 250.0,
            pinned: true,
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/images/library.jpg",
                fit: BoxFit.fill,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      "Welcome to your Knowledge Library, John!  ",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
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
