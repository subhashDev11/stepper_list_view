import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stepper_list_view/stepper_list_view.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Stepper List Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _stepperData = List.generate(
      10,
          (index) => StepperItemData(
        id: '$index',
        content: ({
          'name': 'Subhash Chandra Shukla',
          'occupation': 'Flutter Development',
          'mobileNumber': '7318459902',
          'email': 'subhashchandras7318@gmail.com',
          'born_date': '12\nAug',
          "contact_list": {
            "LinkedIn": "https://www.linkedin.com/in/subhashcs/",
            "Portfolio": "https://subhashdev121.github.io/subhash/#/",
          }
        }),
        avatar: 'https://avatars.githubusercontent.com/u/70679949?v=4',
      )).toList();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StepperListView(
          showStepperInLast: true,
          stepperData: _stepperData,
          stepAvatar: (_, data) {
            final stepData = data as StepperItemData;
            return PreferredSize(
              preferredSize: const Size.fromRadius(20),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  stepData.avatar!,
                ),
              ),
            );
          },
          stepWidget: (_, data) {
            final stepData = data as StepperItemData;
            return PreferredSize(
              preferredSize: const Size.fromWidth(30),
              child: Text(
                stepData.content['born_date'] ?? '',
                style: TextStyle(
                  color: theme.primaryColor,
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
            );
          },
          stepContentWidget: (_, data) {
            final stepData = data as StepperItemData;
            return Container(
              margin: const EdgeInsets.only(
                top: 20,
              ),
              padding: const EdgeInsets.all(
                15,
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(7),
                visualDensity: const VisualDensity(
                  vertical: -4,
                  horizontal: -4,
                ),
                title: Text(stepData.content['name'] ?? ''),
                subtitle: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          flex: 3,
                          child: Icon(Icons.work),
                        ),
                        Expanded(
                          flex: 7,
                          child: Text(stepData.content['occupation'] ?? ''),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          flex: 3,
                          child: Icon(Icons.phone),
                        ),
                        Expanded(
                          flex: 7,
                          child: Text(stepData.content['mobileNumber'] ?? ''),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          flex: 3,
                          child: Icon(Icons.email),
                        ),
                        Expanded(
                          flex: 7,
                          child: Text(stepData.content['email'] ?? ''),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Contact Link',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Linked-In',
                                  style: theme.textTheme.bodySmall,
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: GestureDetector(
                                  onTap: () {
                                    _launchURL(stepData.content['contact_list']
                                    ['LinkedIn']);
                                  },
                                  child: Text(
                                    stepData.content['contact_list']
                                    ['LinkedIn'] ??
                                        '',
                                    style:
                                    theme.textTheme.titleMedium?.copyWith(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Portfolio',
                                  style: theme.textTheme.bodySmall,
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: GestureDetector(
                                  onTap: () {
                                    _launchURL(stepData.content['contact_list']
                                    ['Portfolio']);
                                  },
                                  child: Text(
                                    stepData.content['contact_list']
                                    ['Portfolio'] ??
                                        '',
                                    style:
                                    theme.textTheme.titleMedium?.copyWith(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: theme.dividerColor,
                    width: 0.8,
                  ),
                ),
              ),
            );
          },
          stepperThemeData: StepperThemeData(
            lineColor: theme.primaryColor,
            lineWidth: 5,
          ),
          physics: const BouncingScrollPhysics(),
        ),
      ),
    );
  }

  Future<void> _launchURL(String? url) async {
    if (url == null) {
      return;
    }
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      }
      return;
    } catch (e) {
      if (kDebugMode) {
        print('Failed to launch URL - $e');
      }
    }
  }
}

