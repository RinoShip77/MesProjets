import 'package:flutter/material.dart';
import 'package:macro_vision/utils/l10n_extension.dart';

class AvatarPicker extends StatefulWidget {
  final String currentEmoji;
  final int currentColor;
  final Function(String emoji, int color) onSave;

  const AvatarPicker({
    super.key,
    required this.currentEmoji,
    required this.currentColor,
    required this.onSave,
  });

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  late String _selectedEmoji;
  late int _selectedColor;
  
  // 1. Curated Colors (Pastels & Vibrants)
  final List<int> _colors = [
    // Cool Tones (Blues/Greens)
    0xFF2196F3, // Blue
    0xFF03A9F4, // Light Blue
    0xFF00BCD4, // Cyan
    0xFF009688, // Teal
    0xFF4CAF50, // Green
    0xFF8BC34A, // Light Green
    0xFFCDDC39, // Lime
    0xFF3F51B5, // Indigo
    0xFF673AB7, // Deep Purple
    
    // Warm Tones (Reds/Oranges)
    0xFFF44336, // Red
    0xFFFF5722, // Deep Orange
    0xFFFF9800, // Orange
    0xFFFFC107, // Amber
    0xFFFFEB3B, // Yellow
    0xFFE91E63, // Pink
    0xFF9C27B0, // Purple
    
    // Pastels & Accents
    0xFFF06292, // Light Pink
    0xFFBA68C8, // Light Purple
    0xFF9575CD, // Light Indigo
    0xFF7986CB, // Light Blue
    0xFF4DB6AC, // Light Teal
    0xFFAED581, // Pale Green
    
    // Neutrals
    0xFF795548, // Brown
    0xFF8D6E63, // Light Brown
    0xFF607D8B, // Blue Grey
    0xFF9E9E9E, // Grey
    0xFF424242, // Dark Grey
    0xFF000000, // Black
  ];

  // 2. Curated Emojis (Fitness, Food, Faces)
  final List<String> _emojis = [
    // FACES & PEOPLE
    '👤', '😎', '🤩', '🤠', '🤖', '👽', '👻', '💀', 
    '👨‍🍳', '👩‍⚕️', '🥷', '🦸', '🤴', '🧘', '💆', '💇',
    
    // BODY & FITNESS
    '💪', '🧠', '🫀', '🦵', '🦶', '🏃', '🏋️', '🚴',
    '🤸', '🤼', '🥊', '🏊', '🧘‍♀️', '🔥', '⚡', '💧',

    // HEALTHY FOOD
    '🍎', '🍐', '🍊', '🍋', '🍌', '🍉', '🍇', '🍓',
    '🫐', '🥑', '🥦', '🥕', '🌽', '🥗', '🥚', '🥜',

    // MEALS & TREATS
    '🥩', '🍗', '🍔', '🍕', '🌮', '🍱', '🍜', '🍣',
    '☕', '🍵', '🥛', '🍯', '🍪', '🍫', '🍿', '🥤',

    // ANIMALS (SPIRIT ANIMALS)
    '🦁', '🐯', '🐻', '🐼', '🐨', '🦊', '🐺', '🐗',
    '🦄', '🦅', '🦉', '🦍', '🦈', '🐋', '🐙', '🦖',
  ];

  @override
  void initState() {
    super.initState();
    _selectedEmoji = widget.currentEmoji;
    _selectedColor = widget.currentColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 450, // Height of the bottom sheet
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Center(
            child: Container(
              width: 40, height: 5,
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 20),
          
          // PREVIEW
          Center(
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Color(_selectedColor),
              child: Text(_selectedEmoji, style: const TextStyle(fontSize: 40)),
            ),
          ),
          const SizedBox(height: 30),

          // TAB 1: COLORS
          Text(
            context.l10n.profileScreenAvatarBackgroundLbl,
          style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _colors.length,
              itemBuilder: (context, index) {
                final colorVal = _colors[index];
                final isSelected = colorVal == _selectedColor;
                return GestureDetector(
                  onTap: () => setState(() => _selectedColor = colorVal),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(colorVal),
                      shape: BoxShape.circle,
                      border: isSelected ? Border.all(color: Colors.black, width: 3) : null,
                    ),
                    child: isSelected ? const Icon(Icons.check, color: Colors.white) : null,
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // TAB 2: EMOJIS
          const Text('Avatar', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: _emojis.length,
              itemBuilder: (context, index) {
                final emoji = _emojis[index];
                final isSelected = emoji == _selectedEmoji;
                return GestureDetector(
                  onTap: () => setState(() => _selectedEmoji = emoji),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.grey[200] : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: isSelected ? Border.all(color: Colors.blue) : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(emoji, style: const TextStyle(fontSize: 28)),
                  ),
                );
              },
            ),
          ),

          // SAVE BUTTON
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                widget.onSave(_selectedEmoji, _selectedColor);
                Navigator.pop(context);
              },
              child: Text(context.l10n.profileScreenSaveAvatarBtn),
            ),
          ),
        ],
      ),
    );
  }
}