import 'package:flutter/material.dart';
import '../../app_router.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  late PageController _pageController;

  final List<Map<String, String>> _onboardingData = [
    {"title": "Gerencie suas tarefas", "description": "Organize suas tarefas facilmente."},
    {"title": "Crie rotinas", "description": "Defina hábitos e rotinas diárias."},
    {"title": "Organize categorias", "description": "Classifique tarefas por categorias."},
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage == _onboardingData.length - 1) {
      Navigator.pushReplacementNamed(context, AppRouter.login);
    } else {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87, 
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _onboardingData.length,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _onboardingData[index]['title']!,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // texto branco para contraste
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      _onboardingData[index]['description']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70), // descrição levemente transparente
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, AppRouter.login),
                child: Text("Pular", style: TextStyle(color: Colors.white)),
              ),
              Row(
                children: List.generate(
                  _onboardingData.length,
                  (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 3),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: _nextPage,
                child: Text("Avançar", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
