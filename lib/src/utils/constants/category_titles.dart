class CategoryTitles {
  // static String getRelatedCollectionName(String category) {}

  static final Set<String> _homeCategory = {
    'flutter',
    'go',
    'java',
    'python',
    'ruby',
    'kotlin',
    'typescript',
    'rust',
    'js',
    'react',
    'csharp',
    'nodejs',
    'perl',
    'php',
    'scala',
    'swift',
    'cplusplus',
    'git',
    'cybersecurity',
    'backend',
    'dataanalyst',
    'datascientist',
    'engineer',
    'frontend',
  };

  static List<String> get homeCategory {
    return List<String>.unmodifiable(_homeCategory);
  }
}
