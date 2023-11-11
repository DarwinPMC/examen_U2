// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ActividadDao? _actividadDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `actividad` (`id` INTEGER NOT NULL, `nombre_actividad` TEXT NOT NULL, `fecha` TEXT NOT NULL, `horai` TEXT NOT NULL, `min_toler` TEXT NOT NULL, `latitud` TEXT NOT NULL, `longitud` TEXT NOT NULL, `estado` TEXT NOT NULL, `evaluar` TEXT NOT NULL, `user_create` TEXT NOT NULL, `mater` TEXT NOT NULL, `valid_insc` TEXT NOT NULL, `asis_subact` TEXT NOT NULL, `entsal` TEXT NOT NULL, `offlinex` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ActividadDao get actividadDao {
    return _actividadDaoInstance ??= _$ActividadDao(database, changeListener);
  }
}

class _$ActividadDao extends ActividadDao {
  _$ActividadDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _actividadModeloInsertionAdapter = InsertionAdapter(
            database,
            'actividad',
            (ActividadModelo item) => <String, Object?>{
                  'id': item.id,
                  'nombre_actividad': item.nombreActividad,
                  'fecha': item.fecha,
                  'horai': item.horai,
                  'min_toler': item.minToler,
                  'latitud': item.latitud,
                  'longitud': item.longitud,
                  'estado': item.estado,
                  'evaluar': item.evaluar,
                  'user_create': item.userCreate,
                  'mater': item.mater,
                  'valid_insc': item.validInsc,
                  'asis_subact': item.asisSubact,
                  'entsal': item.entsal,
                  'offlinex': item.offlinex
                },
            changeListener),
        _actividadModeloUpdateAdapter = UpdateAdapter(
            database,
            'actividad',
            ['id'],
            (ActividadModelo item) => <String, Object?>{
                  'id': item.id,
                  'nombre_actividad': item.nombreActividad,
                  'fecha': item.fecha,
                  'horai': item.horai,
                  'min_toler': item.minToler,
                  'latitud': item.latitud,
                  'longitud': item.longitud,
                  'estado': item.estado,
                  'evaluar': item.evaluar,
                  'user_create': item.userCreate,
                  'mater': item.mater,
                  'valid_insc': item.validInsc,
                  'asis_subact': item.asisSubact,
                  'entsal': item.entsal,
                  'offlinex': item.offlinex
                },
            changeListener),
        _actividadModeloDeletionAdapter = DeletionAdapter(
            database,
            'actividad',
            ['id'],
            (ActividadModelo item) => <String, Object?>{
                  'id': item.id,
                  'nombre_actividad': item.nombreActividad,
                  'fecha': item.fecha,
                  'horai': item.horai,
                  'min_toler': item.minToler,
                  'latitud': item.latitud,
                  'longitud': item.longitud,
                  'estado': item.estado,
                  'evaluar': item.evaluar,
                  'user_create': item.userCreate,
                  'mater': item.mater,
                  'valid_insc': item.validInsc,
                  'asis_subact': item.asisSubact,
                  'entsal': item.entsal,
                  'offlinex': item.offlinex
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ActividadModelo> _actividadModeloInsertionAdapter;

  final UpdateAdapter<ActividadModelo> _actividadModeloUpdateAdapter;

  final DeletionAdapter<ActividadModelo> _actividadModeloDeletionAdapter;

  @override
  Future<List<ActividadModelo>> findAllActidad() async {
    return _queryAdapter.queryList('SELECT * FROM Actividad',
        mapper: (Map<String, Object?> row) => ActividadModelo(
            id: row['id'] as int,
            nombreActividad: row['nombre_actividad'] as String,
            fecha: row['fecha'] as String,
            horai: row['horai'] as String,
            minToler: row['min_toler'] as String,
            latitud: row['latitud'] as String,
            longitud: row['longitud'] as String,
            estado: row['estado'] as String,
            evaluar: row['evaluar'] as String,
            userCreate: row['user_create'] as String,
            mater: row['mater'] as String,
            validInsc: row['valid_insc'] as String,
            asisSubact: row['asis_subact'] as String,
            entsal: row['entsal'] as String,
            offlinex: row['offlinex'] as String));
  }

  @override
  Stream<List<String>> findAllActivdadName() {
    return _queryAdapter.queryListStream(
        'SELECT nombreActividad FROM Actividad',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        queryableName: 'Actividad',
        isView: false);
  }

  @override
  Stream<ActividadModelo?> findActividadById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Actividad WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ActividadModelo(
            id: row['id'] as int,
            nombreActividad: row['nombre_actividad'] as String,
            fecha: row['fecha'] as String,
            horai: row['horai'] as String,
            minToler: row['min_toler'] as String,
            latitud: row['latitud'] as String,
            longitud: row['longitud'] as String,
            estado: row['estado'] as String,
            evaluar: row['evaluar'] as String,
            userCreate: row['user_create'] as String,
            mater: row['mater'] as String,
            validInsc: row['valid_insc'] as String,
            asisSubact: row['asis_subact'] as String,
            entsal: row['entsal'] as String,
            offlinex: row['offlinex'] as String),
        arguments: [id],
        queryableName: 'Actividad',
        isView: false);
  }

  @override
  Future<void> deleteActividad(int id) async {
    await _queryAdapter
        .queryNoReturn('delete from Actividad where id = ?1', arguments: [id]);
  }

  @override
  Future<void> insertActividad(ActividadModelo actividad) async {
    await _actividadModeloInsertionAdapter.insert(
        actividad, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllActividad(List<ActividadModelo> todo) async {
    await _actividadModeloInsertionAdapter.insertList(
        todo, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateActividad(ActividadModelo actividad) async {
    await _actividadModeloUpdateAdapter.update(
        actividad, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteAll(List<ActividadModelo> list) async {
    await _actividadModeloDeletionAdapter.deleteList(list);
  }
}
