import 'package:flutter/material.dart';
import 'package:personal_village/utility/get_it_handler.dart';
class NotificationItem {
  final String title;
  final String message;
  final String time;

  NotificationItem(this.title, this.message, this.time);
}

class ActivityItem {
  final String title;
  final String description;
  final String time;

  ActivityItem(this.title, this.description, this.time);
}

class DashboardWidget extends StatefulWidget {
  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  List<NotificationItem> notifications = [
    NotificationItem(
        'New Message', 'You have a new message from John Doe.', '10:00 AM'),
    NotificationItem(
        'your prescription is ready', 'We can deliver it to you.', 'Yesterday'),
    NotificationItem('monthly Checkup Due date',
        'please adjust a time for your blood test', 'Oct 15'),
    NotificationItem(
        'New Message', 'You have a new message from John Doe.', '10:00 AM'),
    NotificationItem(
        'your prescription is ready', 'We can deliver it to you.', 'Yesterday'),
    NotificationItem('monthly Checkup Due date',
        'please adjust a time for your blood test', 'Oct 15'),
  ];

  List<ActivityItem> activities = [
    ActivityItem('Jn is your close friend now',
        'you have updated your relations.', '10:00 AM'),
    ActivityItem('My Village', 'you have added new caregiver to your village',
        '12:30 PM'),
    ActivityItem('you ordered Groceries', 'you order is on the way', '3:00 PM'),
    ActivityItem('John is your close friend now',
        'you have updated your relations.', '10:00 AM'),
    ActivityItem('My Village', 'you have added new caregiver to your village',
        '12:30 PM'),
    ActivityItem('you ordered Groceries', 'you order is on the way', '3:00 PM'),
  ];

  @override
  Widget build(BuildContext context) {
    print(activities[0].title);
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            //background: Ink.image(image: 'assets/images/LightLogo.png')
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset('assets/images/LightLogo.png'),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Hey ${pvSettingsLogic.currentUserInfo.value.userfullname}!  ",
                    style: TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'My Dashboard',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recent Activities',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return ActivityCard(activity: activities[index]);
            }, childCount: activities.length),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recent Notifications',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return NotificationCard(notification: notifications[index]);
            }, childCount: notifications.length),
          ),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationItem notification;

  const NotificationCard({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Colors.red[200], // Change here
          child: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
        ),
        title: Text(notification.title),
        subtitle: Text(notification.message),
        trailing: Text(notification.time),
      ),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final ActivityItem activity;

  const ActivityCard({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Colors.green[900], // Change here
          child: Icon(
            Icons.access_time,
            color: Colors.white,
          ),
        ),
        title: Text(activity.title),
        subtitle: Text(activity.description),
        trailing: Text(activity.time),
      ),
    );
  }
}
