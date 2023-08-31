package ca.qc.cstj.consortium.presentation.ui.newDelivery;

import java.lang.System;

@kotlin.Metadata(mv = {1, 6, 0}, k = 1, d1 = {"\u0000J\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u0003\n\u0002\u0018\u0002\n\u0002\b\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0007\n\u0002\b\u0005\u0018\u00002\u00020\u0001B\r\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004J.\u0010\u0015\u001a\u00020\u00162\u0006\u0010\u0017\u001a\u00020\u00182\u0006\u0010\u0019\u001a\u00020\u00182\u0006\u0010\u001a\u001a\u00020\u00182\u0006\u0010\u001b\u001a\u00020\u00182\u0006\u0010\u001c\u001a\u00020\u0018R\u001a\u0010\u0005\u001a\u000e\u0012\n\u0012\b\u0012\u0004\u0012\u00020\b0\u00070\u0006X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0014\u0010\t\u001a\b\u0012\u0004\u0012\u00020\n0\u0006X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001d\u0010\u000b\u001a\u000e\u0012\n\u0012\b\u0012\u0004\u0012\u00020\b0\u00070\f8F\u00a2\u0006\u0006\u001a\u0004\b\r\u0010\u000eR\u000e\u0010\u000f\u001a\u00020\u0010X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0017\u0010\u0011\u001a\b\u0012\u0004\u0012\u00020\n0\f8F\u00a2\u0006\u0006\u001a\u0004\b\u0012\u0010\u000eR\u000e\u0010\u0013\u001a\u00020\u0014X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u001d"}, d2 = {"Lca/qc/cstj/consortium/presentation/ui/newDelivery/NewDeliveryViewModel;", "Landroidx/lifecycle/AndroidViewModel;", "application", "Landroid/app/Application;", "(Landroid/app/Application;)V", "_deliveries", "Landroidx/lifecycle/MutableLiveData;", "", "Lca/qc/cstj/consortium/domain/models/Delivery;", "_trader", "Lca/qc/cstj/consortium/domain/models/Trader;", "deliveries", "Landroidx/lifecycle/LiveData;", "getDeliveries", "()Landroidx/lifecycle/LiveData;", "deliveryRepository", "Lca/qc/cstj/consortium/data/repositories/DeliveryRepository;", "trader", "getTrader", "traderRepository", "Lca/qc/cstj/consortium/data/repositories/TraderRepository;", "save", "", "vethyx", "", "lukryx", "smiathil", "bilerium", "gloylium", "app_debug"})
public final class NewDeliveryViewModel extends androidx.lifecycle.AndroidViewModel {
    private final ca.qc.cstj.consortium.data.repositories.DeliveryRepository deliveryRepository = null;
    private final androidx.lifecycle.MutableLiveData<java.util.List<ca.qc.cstj.consortium.domain.models.Delivery>> _deliveries = null;
    private final ca.qc.cstj.consortium.data.repositories.TraderRepository traderRepository = null;
    private final androidx.lifecycle.MutableLiveData<ca.qc.cstj.consortium.domain.models.Trader> _trader = null;
    
    public NewDeliveryViewModel(@org.jetbrains.annotations.NotNull()
    android.app.Application application) {
        super(null);
    }
    
    @org.jetbrains.annotations.NotNull()
    public final androidx.lifecycle.LiveData<java.util.List<ca.qc.cstj.consortium.domain.models.Delivery>> getDeliveries() {
        return null;
    }
    
    @org.jetbrains.annotations.NotNull()
    public final androidx.lifecycle.LiveData<ca.qc.cstj.consortium.domain.models.Trader> getTrader() {
        return null;
    }
    
    public final void save(float vethyx, float lukryx, float smiathil, float bilerium, float gloylium) {
    }
}