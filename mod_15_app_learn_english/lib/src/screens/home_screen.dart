import 'package:flutter/material.dart';
import 'package:mod_15_app_learn_english/src/screens/animals.dart';
import 'package:mod_15_app_learn_english/src/screens/numbers.dart';
import 'package:mod_15_app_learn_english/src/screens/vowels.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Aprenda Inglês',
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 6,
          indicatorSize: TabBarIndicatorSize.tab,
          // labelColor: Colors.white,
          // unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            color: Color.fromARGB(168, 255, 255, 255),
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
          tabs: const [
            Tab(text: 'Animais'),
            Tab(text: 'Números'),
            Tab(text: 'Vogais'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Animals(),
          Numbers(),
          Vowels(),
        ],
      ),
    );
  }
}
