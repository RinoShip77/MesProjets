package ca.qc.cstj.consortium.presentation.ui.splash;

import java.lang.System;

@kotlin.Metadata(mv = {1, 6, 0}, k = 1, d1 = {"\u0000>\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0007\n\u0002\b\u0005\u0018\u00002\u00020\u0001B\r\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004J6\u0010\u000e\u001a\u00020\u000f2\u0006\u0010\u0010\u001a\u00020\u00112\u0006\u0010\u0012\u001a\u00020\u00132\u0006\u0010\u0014\u001a\u00020\u00132\u0006\u0010\u0015\u001a\u00020\u00132\u0006\u0010\u0016\u001a\u00020\u00132\u0006\u0010\u0017\u001a\u00020\u0013R\u0014\u0010\u0005\u001a\b\u0012\u0004\u0012\u00020\u00070\u0006X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0017\u0010\b\u001a\b\u0012\u0004\u0012\u00020\u00070\t8F\u00a2\u0006\u0006\u001a\u0004\b\n\u0010\u000bR\u000e\u0010\f\u001a\u00020\rX\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0018"}, d2 = {"Lca/qc/cstj/consortium/presentation/ui/splash/SplashViewModel;", "Landroidx/lifecycle/AndroidViewModel;", "application", "Landroid/app/Application;", "(Landroid/app/Application;)V", "_trader", "Landroidx/lifecycle/MutableLiveData;", "Lca/qc/cstj/consortium/domain/models/Trader;", "trader", "Landroidx/lifecycle/LiveData;", "getTrader", "()Landroidx/lifecycle/LiveData;", "traderRepository", "Lca/qc/cstj/consortium/data/repositories/TraderRepository;", "save", "", "name", "", "vethyx", "", "lukryx", "smiathil", "bilerium", "gloylium", "app_debug"})
public final class SplashViewModel extends androidx.lifecycle.AndroidViewModel {
    private final androidx.lifecycle.MutableLiveData<ca.qc.cstj.consortium.domain.models.Trader> _trader = null;
    private final ca.qc.cstj.consortium.data.repositories.TraderRepository traderRepository = null;
    
    public SplashViewModel(@org.jetbrains.annotations.NotNull()
    android.app.Application application) {
        super(null);
    }
    
    @org.jetbrains.annotations.NotNull()
    public final androidx.lifecycle.LiveData<ca.qc.cstj.consortium.domain.models.Trader> getTrader() {
        return null;
    }
    
    public final void save(@org.jetbrains.annotations.NotNull()
    java.lang.String name, float vethyx, float lukryx, float smiathil, float bilerium, float gloylium) {
    }
}