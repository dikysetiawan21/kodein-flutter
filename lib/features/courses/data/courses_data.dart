import '../model/course.dart';

final List<Course> allCourses = [
  Course(
    id: 'uiux',
    title: 'UI/UX Design',
    description: 'Belajar desain UI/UX modern dari dasar hingga mahir.',
    image: 'assets/images/uiux.png',
    chapters: [
      Chapter(
        id: 'intro',
        title: 'Pengenalan UI/UX',
        videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        description: 'Dasar-dasar UI/UX dan pentingnya dalam pengembangan produk digital.',
      ),
      Chapter(
        id: 'wireframe',
        title: 'Wireframing',
        videoUrl: 'https://www.youtube.com/watch?v=abcd1234',
        description: 'Membuat wireframe untuk aplikasi dan website.',
      ),
    ],
  ),
  Course(
    id: 'gamedev',
    title: 'Game Development',
    description: 'Pelajari dasar-dasar membuat game sendiri.',
    image: 'assets/images/gamedev.png',
    chapters: [
      Chapter(
        id: 'engine',
        title: 'Game Engine',
        videoUrl: 'https://www.youtube.com/watch?v=efgh5678',
        description: 'Pengenalan engine game populer.',
      ),
    ],
  ),
  Course(
    id: 'ai',
    title: 'Artificial Intelligence',
    description: 'Belajar dasar hingga lanjutan AI dan penerapannya.',
    image: 'assets/images/ai.jpeg',
    chapters: [
      Chapter(
        id: 'ai_intro',
        title: 'Pengenalan AI',
        videoUrl: 'https://www.youtube.com/watch?v=1',
        description: 'Apa itu AI dan mengapa penting?',
      ),
    ],
  ),
  Course(
    id: 'blockchain',
    title: 'Blockchain Fundamentals',
    description: 'Pahami konsep blockchain dan penggunaannya.',
    image: 'assets/images/blockchain.jpeg',
    chapters: [
      Chapter(
        id: 'bc_intro',
        title: 'Pengenalan Blockchain',
        videoUrl: 'https://www.youtube.com/watch?v=2',
        description: 'Dasar-dasar blockchain.',
      ),
    ],
  ),
  Course(
    id: 'cloudcomputing',
    title: 'Cloud Computing',
    description: 'Belajar layanan cloud dan penerapannya.',
    image: 'assets/images/cloudcomputing.jpeg',
    chapters: [
      Chapter(
        id: 'cloud_intro',
        title: 'Dasar Cloud',
        videoUrl: 'https://www.youtube.com/watch?v=3',
        description: 'Apa itu cloud computing?',
      ),
    ],
  ),
  Course(
    id: 'cloudsecurity',
    title: 'Cloud Security',
    description: 'Keamanan pada layanan cloud.',
    image: 'assets/images/cloudsecurity.jpeg',
    chapters: [
      Chapter(
        id: 'cs_intro',
        title: 'Dasar Cloud Security',
        videoUrl: 'https://www.youtube.com/watch?v=4',
        description: 'Keamanan dan best practice di cloud.',
      ),
    ],
  ),
  Course(
    id: 'cybersecurity',
    title: 'Cyber Security',
    description: 'Belajar keamanan siber dan perlindungan data.',
    image: 'assets/images/cybersecurity.jpeg',
    chapters: [
      Chapter(
        id: 'cyber_intro',
        title: 'Pengenalan Cyber Security',
        videoUrl: 'https://www.youtube.com/watch?v=5',
        description: 'Dasar-dasar keamanan siber.',
      ),
    ],
  ),
  Course(
    id: 'datascience',
    title: 'Data Science',
    description: 'Belajar analisis data dan machine learning.',
    image: 'assets/images/datascience.jpeg',
    chapters: [
      Chapter(
        id: 'ds_intro',
        title: 'Dasar Data Science',
        videoUrl: 'https://www.youtube.com/watch?v=6',
        description: 'Apa itu data science?',
      ),
    ],
  ),
  Course(
    id: 'devops',
    title: 'DevOps',
    description: 'Kolaborasi pengembangan dan operasi.',
    image: 'assets/images/devops.jpeg',
    chapters: [
      Chapter(
        id: 'devops_intro',
        title: 'Pengenalan DevOps',
        videoUrl: 'https://www.youtube.com/watch?v=7',
        description: 'Dasar-dasar DevOps.',
      ),
    ],
  ),
  Course(
    id: 'docker',
    title: 'Docker',
    description: 'Belajar containerization dengan Docker.',
    image: 'assets/images/docker.jpeg',
    chapters: [
      Chapter(
        id: 'docker_intro',
        title: 'Pengenalan Docker',
        videoUrl: 'https://www.youtube.com/watch?v=8',
        description: 'Dasar penggunaan Docker.',
      ),
    ],
  ),
  Course(
    id: 'excelfordata',
    title: 'Excel for Data',
    description: 'Mengolah data dengan Microsoft Excel.',
    image: 'assets/images/excelfordata.jpeg',
    chapters: [
      Chapter(
        id: 'excel_intro',
        title: 'Dasar Excel',
        videoUrl: 'https://www.youtube.com/watch?v=9',
        description: 'Fungsi dasar Excel untuk data.',
      ),
    ],
  ),
  Course(
    id: 'fluttermobile',
    title: 'Flutter Mobile Development',
    description: 'Membuat aplikasi mobile dengan Flutter.',
    image: 'assets/images/fluttermobile.jpeg',
    chapters: [
      Chapter(
        id: 'flutter_intro',
        title: 'Pengenalan Flutter',
        videoUrl: 'https://www.youtube.com/watch?v=10',
        description: 'Dasar-dasar Flutter.',
      ),
    ],
  ),
  Course(
    id: 'gamedevelopment',
    title: 'Game Development',
    description: 'Belajar membuat game dari nol.',
    image: 'assets/images/gamedevelopment.jpg',
    chapters: [
      Chapter(
        id: 'game_intro',
        title: 'Pengenalan Game Dev',
        videoUrl: 'https://www.youtube.com/watch?v=11',
        description: 'Langkah awal membuat game.',
      ),
    ],
  ),
  Course(
    id: 'javascriptdasar',
    title: 'JavaScript Dasar',
    description: 'Belajar JavaScript untuk pemula.',
    image: 'assets/images/javascriptdasar.jpeg',
    chapters: [
      Chapter(
        id: 'js_intro',
        title: 'Dasar JavaScript',
        videoUrl: 'https://www.youtube.com/watch?v=12',
        description: 'Sintaks dasar JavaScript.',
      ),
    ],
  ),
  Course(
    id: 'mobileappdevelopment',
    title: 'Mobile App Development',
    description: 'Membuat aplikasi mobile lintas platform.',
    image: 'assets/images/mobileappdevelopment.jpeg',
    chapters: [
      Chapter(
        id: 'mad_intro',
        title: 'Pengenalan Mobile App',
        videoUrl: 'https://www.youtube.com/watch?v=13',
        description: 'Dasar-dasar pengembangan aplikasi mobile.',
      ),
    ],
  ),
  Course(
    id: 'penetrationtesting',
    title: 'Penetration Testing',
    description: 'Teknik pengujian keamanan aplikasi.',
    image: 'assets/images/penetrationtesting.jpeg',
    chapters: [
      Chapter(
        id: 'pentest_intro',
        title: 'Dasar Pentest',
        videoUrl: 'https://www.youtube.com/watch?v=14',
        description: 'Pengenalan penetration testing.',
      ),
    ],
  ),
  Course(
    id: 'pythonprogramming',
    title: 'Python Programming',
    description: 'Belajar Python dari dasar hingga mahir.',
    image: 'assets/images/pythonprogramming.jpeg',
    chapters: [
      Chapter(
        id: 'python_intro',
        title: 'Pengenalan Python',
        videoUrl: 'https://www.youtube.com/watch?v=15',
        description: 'Dasar-dasar bahasa Python.',
      ),
    ],
  ),
  Course(
    id: 'reactweb',
    title: 'React Web Development',
    description: 'Membuat aplikasi web dengan React.',
    image: 'assets/images/reactweb.jpeg',
    chapters: [
      Chapter(
        id: 'react_intro',
        title: 'Dasar React',
        videoUrl: 'https://www.youtube.com/watch?v=16',
        description: 'Pengenalan React untuk web.',
      ),
    ],
  ),
  Course(
    id: 'uianimation',
    title: 'UI Animation',
    description: 'Animasi pada UI aplikasi modern.',
    image: 'assets/images/uianimation.jpeg',
    chapters: [
      Chapter(
        id: 'uianim_intro',
        title: 'Dasar UI Animation',
        videoUrl: 'https://www.youtube.com/watch?v=17',
        description: 'Membuat animasi pada UI.',
      ),
    ],
  ),
  Course(
    id: 'uiuxjpg',
    title: 'UI/UX Design Advanced',
    description: 'Materi lanjutan desain UI/UX.',
    image: 'assets/images/uiux.jpg',
    chapters: [
      Chapter(
        id: 'uiuxadv_intro',
        title: 'UI/UX Advanced',
        videoUrl: 'https://www.youtube.com/watch?v=18',
        description: 'Teknik lanjutan desain UI/UX.',
      ),
    ],
  ),
  Course(
    id: 'unity3dgame',
    title: 'Unity 3D Game',
    description: 'Belajar membuat game dengan Unity 3D.',
    image: 'assets/images/unity3dgame.jpeg',
    chapters: [
      Chapter(
        id: 'unity_intro',
        title: 'Dasar Unity 3D',
        videoUrl: 'https://www.youtube.com/watch?v=19',
        description: 'Pengenalan Unity 3D.',
      ),
    ],
  ),
  Course(
    id: 'webdevelopment',
    title: 'Web Development',
    description: 'Belajar membuat website modern.',
    image: 'assets/images/webdevelopment.jpg',
    chapters: [
      Chapter(
        id: 'webdev_intro',
        title: 'Dasar Web Development',
        videoUrl: 'https://www.youtube.com/watch?v=20',
        description: 'Langkah awal membuat website.',
      ),
    ],
  ),

];
