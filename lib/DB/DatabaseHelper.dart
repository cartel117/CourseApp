import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'your_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    // 創建表格的 SQL 語句
    await db.execute('''
      CREATE TABLE Instructors (
        instructor_id INTEGER PRIMARY KEY,
        username TEXT UNIQUE,
        password TEXT,
        name TEXT,
        email TEXT,
        phone TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE InstructorCourses (
        course_id INTEGER PRIMARY KEY,
        instructor_id INTEGER REFERENCES Instructors(instructor_id),
        course_name TEXT,
        course_description TEXT,
        start_date TEXT,
        end_date TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE Students (
        student_id INTEGER PRIMARY KEY,
        username TEXT UNIQUE,
        password TEXT,
        name TEXT,
        email TEXT,
        phone TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE StudentCourses (
        enrollment_id INTEGER PRIMARY KEY,
        student_id INTEGER REFERENCES Students(student_id),
        course_id INTEGER REFERENCES InstructorCourses(course_id),
        enrollment_date TEXT
      );
    ''');
  }

  Future<void> insertDefaultInstructors() async {
    Database db = await database;

    // 插入預設的講師資料
    await db.transaction((txn) async {
      // 講師資料示例
      var instructors = [
        {
          'username': '土撥鼠',
          'password': 'password123',
          'name': 'John Doe',
          'email': 'john.doe@example.com',
          'phone': '123-456-7890',
        },
        {
          'username': '老虎',
          'password': 'pass456',
          'name': 'Jane Smith',
          'email': 'jane.smith@example.com',
          'phone': '987-654-3210',
        },
        // 添加更多預設的講師資料
      ];

      for (var instructor in instructors) {
        await txn.insert(
          'Instructors',
          instructor,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<void> insertDefaultStudent() async {
    Database db = await database;

    // 插入預設的學生資料
    await db.transaction((txn) async {
      var student = {
        'username': '滷肉飯',
        'password': '123456',
        'name': '好吃',
        'email': 'student.one@example.com',
        'phone': '555-1234-987',
      };

      // 插入到學生資料表
      int studentId = await txn.insert(
        'Students',
        student,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // 插入到學生選課資料表
      var course = {
        'student_id': studentId,
        'course_id': 3,
      };

      await txn.insert(
        'StudentCourses',
        course,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<void> insertDefaultCourses() async {
    Database db = await database;

    // 插入預設的課程資料
    await db.transaction((txn) async {
      // 課程資料示例
      var courses = [
        {
          'course_name': 'Flutter Basics',
          'course_description': 'Introduction to Flutter development',
          'start_date': '2022-01-01',
          'end_date': '2022-02-09',
          'instructor_id': 1,
        },
        {
          'course_name': 'C++程式語言',
          'course_description': '介紹如何使用C++',
          'start_date': '2022-02-15',
          'end_date': '2022-03-15',
          'instructor_id': 1,
        },
        {
          'course_name': '演算法',
          'course_description': '介紹常見的演算法',
          'start_date': '2022-01-25',
          'end_date': '2022-08-15',
          'instructor_id': 2,
        },
        {
          'course_name': 'Android',
          'course_description': '介紹如何使用Android studio和開發Android程式',
          'start_date': '2022-01-25',
          'end_date': '2022-08-15',
          'instructor_id': 2,
        },
        {
          'course_name': '資料結構',
          'course_description': '介紹常見的資料結構',
          'start_date': '2023-01-25',
          'end_date': '2023-09-15',
          'instructor_id': 2,
        },
      ];

      for (var course in courses) {
        print("course -> $course");
        await txn.insert(
          'InstructorCourses',
          course,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<List<Map<String, dynamic>>> getDefaultStudentCourses() async {
    Database db = await database;
    return await db.query('StudentCourses');
  }

  Future<List<Map<String, dynamic>>> getDefaultInstructorCourses() async {
    Database db = await database;
    return await db.query('InstructorCourses');
  }

  Future<bool> hasDefaultCourses() async {
    Database db = await database;
    List<Map<String, dynamic>> result =
        await db.query('InstructorCourses', limit: 1);
    return result.isNotEmpty;
  }

  Future<Map<String, dynamic>?> getInstructorById(int instructorId) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'Instructors',
      where: 'instructor_id = ?',
      whereArgs: [instructorId],
      limit: 1,
    );

    return result.isNotEmpty ? result.first : null;
  }

  Future<List<Map<String, dynamic>>> getCoursesByInstructorId(int instructorId) async {
    Database db = await database;
    return await db.rawQuery('''
      SELECT InstructorCourses.*, Instructors.name as instructor_name
      FROM InstructorCourses
      INNER JOIN Instructors ON InstructorCourses.instructor_id = Instructors.instructor_id
      WHERE InstructorCourses.instructor_id = ?
    ''', [instructorId]);
  }

  Future<List<Map<String, dynamic>>> getStudentCoursesByStudentId(int studentId) async {
    Database db = await database;
    return await db.rawQuery('''
      SELECT StudentCourses.*, InstructorCourses.course_name, InstructorCourses.course_description
      FROM StudentCourses
      INNER JOIN InstructorCourses ON StudentCourses.course_id = InstructorCourses.course_id
      WHERE StudentCourses.student_id = ?
    ''', [studentId]);
  }
  
  Future<void> deleteStudentCourse(int studentId, int courseId) async {
    Database db = await database;
    await db.delete(
      'StudentCourses',
      where: 'student_id = ? AND course_id = ?',
      whereArgs: [studentId, courseId],
    );
  }

  Future<void> insertStudentCourse(int studentId, int courseId) async {
    Database db = await database;
    var course = {
      'student_id': studentId,
      'course_id': courseId,
    };

    await db.insert(
      'StudentCourses',
      course,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

}
