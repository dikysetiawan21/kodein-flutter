import 'package:flutter/material.dart';
import '../../courses/view/course_detail_page.dart';
import '../../courses/data/courses_data.dart';
import '../../courses/model/course.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Filter state
  String? selectedLevel;
  String? selectedCategory;

  // Daftar kategori (bisa diimprove dari data)
  final List<String> categories = [
    'Desain',
    'Data Science',
    'Mobile',
    'Web',
    'Security',
    'Cloud',
    'Programming',
    'DevOps',
    'Game',
    'Project Management',
    'UI/UX',
    'AI',
  ];

  // Mapping kategori per course
  String getCategory(Course course) {
    final title = course.title.toLowerCase();
    if (title.contains('ui') ||
        title.contains('figma') ||
        title.contains('photoshop'))
      return 'Desain';
    if (title.contains('data') ||
        title.contains('machine learning') ||
        title.contains('excel'))
      return 'Data Science';
    if (title.contains('mobile') ||
        title.contains('android') ||
        title.contains('react native') ||
        title.contains('flutter'))
      return 'Mobile';
    if (title.contains('web') ||
        title.contains('rest api') ||
        title.contains('vue') ||
        title.contains('react'))
      return 'Web';
    if (title.contains('security') ||
        title.contains('hacking') ||
        title.contains('penetration') ||
        title.contains('forensics') ||
        title.contains('cloud'))
      return 'Security';
    if (title.contains('cloud')) return 'Cloud';
    if (title.contains('programming') ||
        title.contains('python') ||
        title.contains('javascript') ||
        title.contains('cpp') ||
        title.contains('kotlin'))
      return 'Programming';
    if (title.contains('devops') || title.contains('docker')) return 'DevOps';
    if (title.contains('game') || title.contains('unity')) return 'Game';
    if (title.contains('project') || title.contains('agile'))
      return 'Project Management';
    if (title.contains('ai') || title.contains('artificial intelligence'))
      return 'AI';
    return 'Other';
  }

  List<Course> get filteredCourses {
    final query = _searchQuery.toLowerCase();
    return allCourses.where((course) {
      final matchesQuery =
          _searchQuery.isEmpty ||
          course.title.toString().toLowerCase().contains(query) ||
          course.description.toString().toLowerCase().contains(query);
      final matchesLevel = selectedLevel == null || '' == selectedLevel;
      final matchesCategory =
          selectedCategory == null || getCategory(course) == selectedCategory;
      return matchesQuery && matchesLevel && matchesCategory;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 4),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari topik pembelajaran...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 18,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(fontSize: 14),
              onChanged: (val) {
                setState(() {
                  _searchQuery = val;
                });
              },
            ),
          ),
          // Filter
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "FILTER BY",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    letterSpacing: 1,
                    fontSize: 12,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                      ),
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (
                            BuildContext context,
                            StateSetter setModalState,
                          ) {
                            return SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 18,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Filter by Level',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Wrap(
                                      spacing: 8,
                                      children: [
                                        FilterChip(
                                          label: const Text('Semua'),
                                          selected: selectedLevel == null,
                                          onSelected: (_) {
                                            setModalState(() {
                                              selectedLevel = null;
                                            });
                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ...['Pemula', 'Menengah', 'Expert'].map(
                                          (lvl) => FilterChip(
                                            label: Text(lvl),
                                            selected: selectedLevel == lvl,
                                            onSelected: (_) {
                                              setModalState(() {
                                                selectedLevel = lvl;
                                              });
                                              setState(() {});
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 18),
                                    const Text(
                                      'Filter by Kategori',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Wrap(
                                      spacing: 8,
                                      children: [
                                        FilterChip(
                                          label: const Text('Semua'),
                                          selected: selectedCategory == null,
                                          onSelected: (_) {
                                            setModalState(() {
                                              selectedCategory = null;
                                            });
                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ...categories.map(
                                          (cat) => FilterChip(
                                            label: Text(cat),
                                            selected: selectedCategory == cat,
                                            onSelected: (_) {
                                              setModalState(() {
                                                selectedCategory = cat;
                                              });
                                              setState(() {});
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 80,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.filter_list,
                          size: 18,
                          color: Color(0xFF616161),
                        ),
                        const SizedBox(width: 5),
                        selectedLevel != null || selectedCategory != null
                            ? const Icon(
                              Icons.check_circle,
                              size: 18,
                              color: Colors.blue,
                            )
                            : const Icon(
                              Icons.expand_more,
                              size: 15,
                              color: Color(0xFF616161),
                            ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Daftar kursus
          Expanded(
            child: Builder(
              builder: (context) {
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: filteredCourses.length,
                  itemBuilder: (context, index) {
                    final course = filteredCourses[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => CourseDetailPage(course: course),
                          ),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Builder(
                                  builder: (context) {
                                    final imagePath = course.image;
                                    final availableImages = [
                                      'assets/images/ai.jpeg',
                                      'assets/images/blockchain.jpeg',
                                      'assets/images/cloudcomputing.jpeg',
                                      'assets/images/cloudsecurity.jpeg',
                                      'assets/images/cybersecurity.jpeg',
                                      'assets/images/datascience.jpeg',
                                      'assets/images/devops.jpeg',
                                      'assets/images/docker.jpeg',
                                      'assets/images/excelfordata.jpeg',
                                      'assets/images/fluttermobile.jpeg',
                                      'assets/images/gamedevelopment.jpg',
                                      'assets/images/javascriptdasar.jpeg',
                                      'assets/images/mobileappdevelopment.jpeg',
                                      'assets/images/mobileappdevelopment.jpg',
                                      'assets/images/penetrationtesting.jpeg',
                                      'assets/images/profile.jpg',
                                      'assets/images/pythonprogramming.jpeg',
                                      'assets/images/reactweb.jpeg',
                                      'assets/images/uianimation.jpeg',
                                      'assets/images/uiux.jpg',
                                      'assets/images/unity3dgame.jpeg',
                                      'assets/images/webdevelopment.jpg',
                                    ];
                                    bool exists = availableImages.contains(
                                      imagePath,
                                    );
                                    final random =
                                        availableImages[(index +
                                                course.title.hashCode) %
                                            availableImages.length];
                                    return Image.asset(
                                      exists ? imagePath : random,
                                      fit: BoxFit.cover,
                                      width: 70,
                                      height: 70,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      course.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      course.description,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[700],
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
