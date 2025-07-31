import 'package:flutter/material.dart';

class AnatomyScreen extends StatefulWidget {
  const AnatomyScreen({super.key});

  @override
  State<AnatomyScreen> createState() => _AnatomyScreenState();
}

class _AnatomyScreenState extends State<AnatomyScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  int _currentStep = 0;

  final List<AnatomyStep> _steps = [
    AnatomyStep(
      title: 'Волоски на теле',
      description: 'На теле человека находится миллионы волосков. Каждый волосок имеет луковицу и корни.',
      icon: Icons.face,
      color: Colors.orange,
    ),
    AnatomyStep(
      title: 'Нервные окончания',
      description: 'По телу проходят миллионы нервных окончаний, которые соединены с корнями РАЗНЫХ луковиц.',
      icon: Icons.psychology,
      color: Colors.red,
    ),
    AnatomyStep(
      title: 'Голограмма',
      description: 'От волоска мозг получает голограмму с 3D моделью того, во что помещено тело.',
      icon: Icons.view_in_ar,
      color: Colors.blue,
    ),
    AnatomyStep(
      title: 'Адаптация тела',
      description: 'Мозг подстраивает анатомию тела (физической оболочки) под одежду.',
      icon: Icons.accessibility_new,
      color: Colors.green,
    ),
    AnatomyStep(
      title: 'Примеры',
      description: 'Арбуз в кубе → кубический арбуз\nНога в узкой обуви → деформированная стопа',
      icon: Icons.lightbulb,
      color: Colors.purple,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
      setState(() {
        _currentStep++;
      });
      _animationController.reset();
      _animationController.forward();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Анатомия'),
        backgroundColor: Colors.deepPurple.shade900,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade900,
              Colors.deepPurple.shade700,
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Progress indicator
                    LinearProgressIndicator(
                      value: (_currentStep + 1) / _steps.length,
                      backgroundColor: Colors.white24,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _steps[_currentStep].color,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Step indicator
                    Text(
                      'Шаг ${_currentStep + 1} из ${_steps.length}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 40),
                    
                    // Current step content
                    Expanded(
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: _buildStepContent(_steps[_currentStep]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Navigation buttons
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: _currentStep > 0 ? _previousStep : null,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Назад'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white24,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _currentStep < _steps.length - 1 ? _nextStep : null,
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Далее'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _steps[_currentStep].color,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent(AnatomyStep step) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Icon
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: step.color.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(
              color: step.color,
              width: 3,
            ),
          ),
          child: Icon(
            step.icon,
            size: 60,
            color: step.color,
          ),
        ),
        const SizedBox(height: 30),
        
        // Title
        Text(
          step.title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        
        // Description
        Text(
          step.description,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.white70,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        
        // Interactive elements for specific steps
        if (_currentStep == 0) ...[
          const SizedBox(height: 30),
          _buildHairFollicleDemo(),
        ] else if (_currentStep == 1) ...[
          const SizedBox(height: 30),
          _buildNerveEndingsDemo(),
        ] else if (_currentStep == 4) ...[
          const SizedBox(height: 30),
          _buildExamplesDemo(),
        ],
      ],
    );
  }

  Widget _buildHairFollicleDemo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            'Интерактивная модель волоска',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFolliclePart('Луковица', Colors.orange),
              _buildFolliclePart('Корни', Colors.brown),
              _buildFolliclePart('Волосок', Colors.black),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFolliclePart(String name, Color color) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildNerveEndingsDemo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            'Связь нервов с волосками',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNerveConnection('Нерв', Colors.red),
              const Icon(Icons.arrow_forward, color: Colors.white70),
              _buildNerveConnection('Волосок', Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNerveConnection(String name, Color color) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildExamplesDemo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            'Примеры адаптации',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildExample('Арбуз', '🍉', 'Куб', '⬜'),
              _buildExample('Нога', '🦶', 'Узкая обувь', '👟'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExample(String before, String beforeIcon, String after, String afterIcon) {
    return Column(
      children: [
        Text(
          before,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        Text(beforeIcon, style: const TextStyle(fontSize: 24)),
        const Icon(Icons.arrow_downward, color: Colors.white70, size: 16),
        Text(
          after,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        Text(afterIcon, style: const TextStyle(fontSize: 24)),
      ],
    );
  }
}

class AnatomyStep {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  AnatomyStep({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
} 