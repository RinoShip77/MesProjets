package ca.qc.cstj.consortium.domain.models;

import java.lang.System;

@androidx.room.Entity(tableName = "deliveries")
@kotlin.Metadata(mv = {1, 6, 0}, k = 1, d1 = {"\u0000(\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0007\n\u0002\b\t\n\u0002\u0010\b\n\u0002\b\u000e\n\u0002\u0010\u000b\n\u0002\b\u0003\n\u0002\u0010\u000e\n\u0000\b\u0087\b\u0018\u00002\u00020\u0001B-\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u0006\u0010\u0004\u001a\u00020\u0003\u0012\u0006\u0010\u0005\u001a\u00020\u0003\u0012\u0006\u0010\u0006\u001a\u00020\u0003\u0012\u0006\u0010\u0007\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\bJ\t\u0010\u0015\u001a\u00020\u0003H\u00c6\u0003J\t\u0010\u0016\u001a\u00020\u0003H\u00c6\u0003J\t\u0010\u0017\u001a\u00020\u0003H\u00c6\u0003J\t\u0010\u0018\u001a\u00020\u0003H\u00c6\u0003J\t\u0010\u0019\u001a\u00020\u0003H\u00c6\u0003J;\u0010\u001a\u001a\u00020\u00002\b\b\u0002\u0010\u0002\u001a\u00020\u00032\b\b\u0002\u0010\u0004\u001a\u00020\u00032\b\b\u0002\u0010\u0005\u001a\u00020\u00032\b\b\u0002\u0010\u0006\u001a\u00020\u00032\b\b\u0002\u0010\u0007\u001a\u00020\u0003H\u00c6\u0001J\u0013\u0010\u001b\u001a\u00020\u001c2\b\u0010\u001d\u001a\u0004\u0018\u00010\u0001H\u00d6\u0003J\t\u0010\u001e\u001a\u00020\rH\u00d6\u0001J\t\u0010\u001f\u001a\u00020 H\u00d6\u0001R\u0016\u0010\u0006\u001a\u00020\u00038\u0006X\u0087\u0004\u00a2\u0006\b\n\u0000\u001a\u0004\b\t\u0010\nR\u0016\u0010\u0007\u001a\u00020\u00038\u0006X\u0087\u0004\u00a2\u0006\b\n\u0000\u001a\u0004\b\u000b\u0010\nR\u001e\u0010\f\u001a\u00020\r8\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\b\u000e\u0010\u000f\"\u0004\b\u0010\u0010\u0011R\u0016\u0010\u0004\u001a\u00020\u00038\u0006X\u0087\u0004\u00a2\u0006\b\n\u0000\u001a\u0004\b\u0012\u0010\nR\u0016\u0010\u0005\u001a\u00020\u00038\u0006X\u0087\u0004\u00a2\u0006\b\n\u0000\u001a\u0004\b\u0013\u0010\nR\u0016\u0010\u0002\u001a\u00020\u00038\u0006X\u0087\u0004\u00a2\u0006\b\n\u0000\u001a\u0004\b\u0014\u0010\n\u00a8\u0006!"}, d2 = {"Lca/qc/cstj/consortium/domain/models/Delivery;", "", "vethyx", "", "lukryx", "smiathil", "bilerium", "gloylium", "(FFFFF)V", "getBilerium", "()F", "getGloylium", "idDelivery", "", "getIdDelivery", "()I", "setIdDelivery", "(I)V", "getLukryx", "getSmiathil", "getVethyx", "component1", "component2", "component3", "component4", "component5", "copy", "equals", "", "other", "hashCode", "toString", "", "app_debug"})
public final class Delivery {
    @androidx.room.ColumnInfo(name = "vethyx")
    private final float vethyx = 0.0F;
    @androidx.room.ColumnInfo(name = "lukryx")
    private final float lukryx = 0.0F;
    @androidx.room.ColumnInfo(name = "smiathil")
    private final float smiathil = 0.0F;
    @androidx.room.ColumnInfo(name = "bilerium")
    private final float bilerium = 0.0F;
    @androidx.room.ColumnInfo(name = "gloylium")
    private final float gloylium = 0.0F;
    @androidx.room.PrimaryKey(autoGenerate = true)
    private int idDelivery = 0;
    
    @org.jetbrains.annotations.NotNull()
    public final ca.qc.cstj.consortium.domain.models.Delivery copy(float vethyx, float lukryx, float smiathil, float bilerium, float gloylium) {
        return null;
    }
    
    @java.lang.Override()
    public boolean equals(@org.jetbrains.annotations.Nullable()
    java.lang.Object other) {
        return false;
    }
    
    @java.lang.Override()
    public int hashCode() {
        return 0;
    }
    
    @org.jetbrains.annotations.NotNull()
    @java.lang.Override()
    public java.lang.String toString() {
        return null;
    }
    
    public Delivery(float vethyx, float lukryx, float smiathil, float bilerium, float gloylium) {
        super();
    }
    
    public final float component1() {
        return 0.0F;
    }
    
    public final float getVethyx() {
        return 0.0F;
    }
    
    public final float component2() {
        return 0.0F;
    }
    
    public final float getLukryx() {
        return 0.0F;
    }
    
    public final float component3() {
        return 0.0F;
    }
    
    public final float getSmiathil() {
        return 0.0F;
    }
    
    public final float component4() {
        return 0.0F;
    }
    
    public final float getBilerium() {
        return 0.0F;
    }
    
    public final float component5() {
        return 0.0F;
    }
    
    public final float getGloylium() {
        return 0.0F;
    }
    
    public final int getIdDelivery() {
        return 0;
    }
    
    public final void setIdDelivery(int p0) {
    }
}