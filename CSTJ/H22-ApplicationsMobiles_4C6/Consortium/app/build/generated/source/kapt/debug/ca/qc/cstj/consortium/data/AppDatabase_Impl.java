package ca.qc.cstj.consortium.data;

import androidx.annotation.NonNull;
import androidx.room.DatabaseConfiguration;
import androidx.room.InvalidationTracker;
import androidx.room.RoomOpenHelper;
import androidx.room.RoomOpenHelper.Delegate;
import androidx.room.RoomOpenHelper.ValidationResult;
import androidx.room.migration.AutoMigrationSpec;
import androidx.room.migration.Migration;
import androidx.room.util.DBUtil;
import androidx.room.util.TableInfo;
import androidx.room.util.TableInfo.Column;
import androidx.room.util.TableInfo.ForeignKey;
import androidx.room.util.TableInfo.Index;
import androidx.sqlite.db.SupportSQLiteDatabase;
import androidx.sqlite.db.SupportSQLiteOpenHelper;
import androidx.sqlite.db.SupportSQLiteOpenHelper.Callback;
import androidx.sqlite.db.SupportSQLiteOpenHelper.Configuration;
import ca.qc.cstj.consortium.data.repositories.DeliveryRepository;
import ca.qc.cstj.consortium.data.repositories.DeliveryRepository_Impl;
import java.lang.Class;
import java.lang.Override;
import java.lang.String;
import java.lang.SuppressWarnings;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

@SuppressWarnings({"unchecked", "deprecation"})
public final class AppDatabase_Impl extends AppDatabase {
  private volatile DeliveryRepository _deliveryRepository;

  @Override
  protected SupportSQLiteOpenHelper createOpenHelper(DatabaseConfiguration configuration) {
    final SupportSQLiteOpenHelper.Callback _openCallback = new RoomOpenHelper(configuration, new RoomOpenHelper.Delegate(1) {
      @Override
      public void createAllTables(SupportSQLiteDatabase _db) {
        _db.execSQL("CREATE TABLE IF NOT EXISTS `deliveries` (`vethyx` REAL NOT NULL, `lukryx` REAL NOT NULL, `smiathil` REAL NOT NULL, `bilerium` REAL NOT NULL, `gloylium` REAL NOT NULL, `idDelivery` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL)");
        _db.execSQL("CREATE TABLE IF NOT EXISTS room_master_table (id INTEGER PRIMARY KEY,identity_hash TEXT)");
        _db.execSQL("INSERT OR REPLACE INTO room_master_table (id,identity_hash) VALUES(42, '9e62cd7f91f7aec81d1902c51ed3f958')");
      }

      @Override
      public void dropAllTables(SupportSQLiteDatabase _db) {
        _db.execSQL("DROP TABLE IF EXISTS `deliveries`");
        if (mCallbacks != null) {
          for (int _i = 0, _size = mCallbacks.size(); _i < _size; _i++) {
            mCallbacks.get(_i).onDestructiveMigration(_db);
          }
        }
      }

      @Override
      protected void onCreate(SupportSQLiteDatabase _db) {
        if (mCallbacks != null) {
          for (int _i = 0, _size = mCallbacks.size(); _i < _size; _i++) {
            mCallbacks.get(_i).onCreate(_db);
          }
        }
      }

      @Override
      public void onOpen(SupportSQLiteDatabase _db) {
        mDatabase = _db;
        internalInitInvalidationTracker(_db);
        if (mCallbacks != null) {
          for (int _i = 0, _size = mCallbacks.size(); _i < _size; _i++) {
            mCallbacks.get(_i).onOpen(_db);
          }
        }
      }

      @Override
      public void onPreMigrate(SupportSQLiteDatabase _db) {
        DBUtil.dropFtsSyncTriggers(_db);
      }

      @Override
      public void onPostMigrate(SupportSQLiteDatabase _db) {
      }

      @Override
      protected RoomOpenHelper.ValidationResult onValidateSchema(SupportSQLiteDatabase _db) {
        final HashMap<String, TableInfo.Column> _columnsDeliveries = new HashMap<String, TableInfo.Column>(6);
        _columnsDeliveries.put("vethyx", new TableInfo.Column("vethyx", "REAL", true, 0, null, TableInfo.CREATED_FROM_ENTITY));
        _columnsDeliveries.put("lukryx", new TableInfo.Column("lukryx", "REAL", true, 0, null, TableInfo.CREATED_FROM_ENTITY));
        _columnsDeliveries.put("smiathil", new TableInfo.Column("smiathil", "REAL", true, 0, null, TableInfo.CREATED_FROM_ENTITY));
        _columnsDeliveries.put("bilerium", new TableInfo.Column("bilerium", "REAL", true, 0, null, TableInfo.CREATED_FROM_ENTITY));
        _columnsDeliveries.put("gloylium", new TableInfo.Column("gloylium", "REAL", true, 0, null, TableInfo.CREATED_FROM_ENTITY));
        _columnsDeliveries.put("idDelivery", new TableInfo.Column("idDelivery", "INTEGER", true, 1, null, TableInfo.CREATED_FROM_ENTITY));
        final HashSet<TableInfo.ForeignKey> _foreignKeysDeliveries = new HashSet<TableInfo.ForeignKey>(0);
        final HashSet<TableInfo.Index> _indicesDeliveries = new HashSet<TableInfo.Index>(0);
        final TableInfo _infoDeliveries = new TableInfo("deliveries", _columnsDeliveries, _foreignKeysDeliveries, _indicesDeliveries);
        final TableInfo _existingDeliveries = TableInfo.read(_db, "deliveries");
        if (! _infoDeliveries.equals(_existingDeliveries)) {
          return new RoomOpenHelper.ValidationResult(false, "deliveries(ca.qc.cstj.consortium.domain.models.Delivery).\n"
                  + " Expected:\n" + _infoDeliveries + "\n"
                  + " Found:\n" + _existingDeliveries);
        }
        return new RoomOpenHelper.ValidationResult(true, null);
      }
    }, "9e62cd7f91f7aec81d1902c51ed3f958", "cce0a304e2a57599c05dcad4b8cf3ac4");
    final SupportSQLiteOpenHelper.Configuration _sqliteConfig = SupportSQLiteOpenHelper.Configuration.builder(configuration.context)
        .name(configuration.name)
        .callback(_openCallback)
        .build();
    final SupportSQLiteOpenHelper _helper = configuration.sqliteOpenHelperFactory.create(_sqliteConfig);
    return _helper;
  }

  @Override
  protected InvalidationTracker createInvalidationTracker() {
    final HashMap<String, String> _shadowTablesMap = new HashMap<String, String>(0);
    HashMap<String, Set<String>> _viewTables = new HashMap<String, Set<String>>(0);
    return new InvalidationTracker(this, _shadowTablesMap, _viewTables, "deliveries");
  }

  @Override
  public void clearAllTables() {
    super.assertNotMainThread();
    final SupportSQLiteDatabase _db = super.getOpenHelper().getWritableDatabase();
    try {
      super.beginTransaction();
      _db.execSQL("DELETE FROM `deliveries`");
      super.setTransactionSuccessful();
    } finally {
      super.endTransaction();
      _db.query("PRAGMA wal_checkpoint(FULL)").close();
      if (!_db.inTransaction()) {
        _db.execSQL("VACUUM");
      }
    }
  }

  @Override
  protected Map<Class<?>, List<Class<?>>> getRequiredTypeConverters() {
    final HashMap<Class<?>, List<Class<?>>> _typeConvertersMap = new HashMap<Class<?>, List<Class<?>>>();
    _typeConvertersMap.put(DeliveryRepository.class, DeliveryRepository_Impl.getRequiredConverters());
    return _typeConvertersMap;
  }

  @Override
  public Set<Class<? extends AutoMigrationSpec>> getRequiredAutoMigrationSpecs() {
    final HashSet<Class<? extends AutoMigrationSpec>> _autoMigrationSpecsSet = new HashSet<Class<? extends AutoMigrationSpec>>();
    return _autoMigrationSpecsSet;
  }

  @Override
  public List<Migration> getAutoMigrations(
      @NonNull Map<Class<? extends AutoMigrationSpec>, AutoMigrationSpec> autoMigrationSpecsMap) {
    return Arrays.asList();
  }

  @Override
  public DeliveryRepository deliveryRepository() {
    if (_deliveryRepository != null) {
      return _deliveryRepository;
    } else {
      synchronized(this) {
        if(_deliveryRepository == null) {
          _deliveryRepository = new DeliveryRepository_Impl(this);
        }
        return _deliveryRepository;
      }
    }
  }
}
