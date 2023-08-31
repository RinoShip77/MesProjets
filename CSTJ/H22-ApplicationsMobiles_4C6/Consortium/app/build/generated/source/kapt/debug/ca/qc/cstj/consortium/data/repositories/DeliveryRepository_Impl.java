package ca.qc.cstj.consortium.data.repositories;

import android.database.Cursor;
import androidx.room.CoroutinesRoom;
import androidx.room.EntityInsertionAdapter;
import androidx.room.RoomDatabase;
import androidx.room.RoomSQLiteQuery;
import androidx.room.SharedSQLiteStatement;
import androidx.room.util.CursorUtil;
import androidx.room.util.DBUtil;
import androidx.sqlite.db.SupportSQLiteStatement;
import ca.qc.cstj.consortium.domain.models.Delivery;
import java.lang.Class;
import java.lang.Exception;
import java.lang.Object;
import java.lang.Override;
import java.lang.String;
import java.lang.SuppressWarnings;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.Callable;
import kotlin.Unit;
import kotlin.coroutines.Continuation;
import kotlinx.coroutines.flow.Flow;

@SuppressWarnings({"unchecked", "deprecation"})
public final class DeliveryRepository_Impl implements DeliveryRepository {
  private final RoomDatabase __db;

  private final EntityInsertionAdapter<Delivery> __insertionAdapterOfDelivery;

  private final SharedSQLiteStatement __preparedStmtOfDeleteAll;

  public DeliveryRepository_Impl(RoomDatabase __db) {
    this.__db = __db;
    this.__insertionAdapterOfDelivery = new EntityInsertionAdapter<Delivery>(__db) {
      @Override
      public String createQuery() {
        return "INSERT OR ABORT INTO `deliveries` (`vethyx`,`lukryx`,`smiathil`,`bilerium`,`gloylium`,`idDelivery`) VALUES (?,?,?,?,?,nullif(?, 0))";
      }

      @Override
      public void bind(SupportSQLiteStatement stmt, Delivery value) {
        stmt.bindDouble(1, value.getVethyx());
        stmt.bindDouble(2, value.getLukryx());
        stmt.bindDouble(3, value.getSmiathil());
        stmt.bindDouble(4, value.getBilerium());
        stmt.bindDouble(5, value.getGloylium());
        stmt.bindLong(6, value.getIdDelivery());
      }
    };
    this.__preparedStmtOfDeleteAll = new SharedSQLiteStatement(__db) {
      @Override
      public String createQuery() {
        final String _query = "DELETE FROM deliveries";
        return _query;
      }
    };
  }

  @Override
  public void insert(final List<Delivery> deliveries) {
    __db.assertNotSuspendingTransaction();
    __db.beginTransaction();
    try {
      __insertionAdapterOfDelivery.insert(deliveries);
      __db.setTransactionSuccessful();
    } finally {
      __db.endTransaction();
    }
  }

  @Override
  public Object create(final Delivery delivery, final Continuation<? super Unit> continuation) {
    return CoroutinesRoom.execute(__db, true, new Callable<Unit>() {
      @Override
      public Unit call() throws Exception {
        __db.beginTransaction();
        try {
          __insertionAdapterOfDelivery.insert(delivery);
          __db.setTransactionSuccessful();
          return Unit.INSTANCE;
        } finally {
          __db.endTransaction();
        }
      }
    }, continuation);
  }

  @Override
  public Object deleteAll(final Continuation<? super Unit> continuation) {
    return CoroutinesRoom.execute(__db, true, new Callable<Unit>() {
      @Override
      public Unit call() throws Exception {
        final SupportSQLiteStatement _stmt = __preparedStmtOfDeleteAll.acquire();
        __db.beginTransaction();
        try {
          _stmt.executeUpdateDelete();
          __db.setTransactionSuccessful();
          return Unit.INSTANCE;
        } finally {
          __db.endTransaction();
          __preparedStmtOfDeleteAll.release(_stmt);
        }
      }
    }, continuation);
  }

  @Override
  public Flow<List<Delivery>> retrieveAll() {
    final String _sql = "SELECT * FROM deliveries";
    final RoomSQLiteQuery _statement = RoomSQLiteQuery.acquire(_sql, 0);
    return CoroutinesRoom.createFlow(__db, false, new String[]{"deliveries"}, new Callable<List<Delivery>>() {
      @Override
      public List<Delivery> call() throws Exception {
        final Cursor _cursor = DBUtil.query(__db, _statement, false, null);
        try {
          final int _cursorIndexOfVethyx = CursorUtil.getColumnIndexOrThrow(_cursor, "vethyx");
          final int _cursorIndexOfLukryx = CursorUtil.getColumnIndexOrThrow(_cursor, "lukryx");
          final int _cursorIndexOfSmiathil = CursorUtil.getColumnIndexOrThrow(_cursor, "smiathil");
          final int _cursorIndexOfBilerium = CursorUtil.getColumnIndexOrThrow(_cursor, "bilerium");
          final int _cursorIndexOfGloylium = CursorUtil.getColumnIndexOrThrow(_cursor, "gloylium");
          final int _cursorIndexOfIdDelivery = CursorUtil.getColumnIndexOrThrow(_cursor, "idDelivery");
          final List<Delivery> _result = new ArrayList<Delivery>(_cursor.getCount());
          while(_cursor.moveToNext()) {
            final Delivery _item;
            final float _tmpVethyx;
            _tmpVethyx = _cursor.getFloat(_cursorIndexOfVethyx);
            final float _tmpLukryx;
            _tmpLukryx = _cursor.getFloat(_cursorIndexOfLukryx);
            final float _tmpSmiathil;
            _tmpSmiathil = _cursor.getFloat(_cursorIndexOfSmiathil);
            final float _tmpBilerium;
            _tmpBilerium = _cursor.getFloat(_cursorIndexOfBilerium);
            final float _tmpGloylium;
            _tmpGloylium = _cursor.getFloat(_cursorIndexOfGloylium);
            _item = new Delivery(_tmpVethyx,_tmpLukryx,_tmpSmiathil,_tmpBilerium,_tmpGloylium);
            final int _tmpIdDelivery;
            _tmpIdDelivery = _cursor.getInt(_cursorIndexOfIdDelivery);
            _item.setIdDelivery(_tmpIdDelivery);
            _result.add(_item);
          }
          return _result;
        } finally {
          _cursor.close();
        }
      }

      @Override
      protected void finalize() {
        _statement.release();
      }
    });
  }

  public static List<Class<?>> getRequiredConverters() {
    return Collections.emptyList();
  }
}
