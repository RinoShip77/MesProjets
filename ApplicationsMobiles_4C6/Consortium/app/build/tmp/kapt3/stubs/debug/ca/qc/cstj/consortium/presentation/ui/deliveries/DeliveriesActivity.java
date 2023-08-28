package ca.qc.cstj.consortium.presentation.ui.deliveries;

import java.lang.System;

@kotlin.Metadata(mv = {1, 6, 0}, k = 1, d1 = {"\u0000.\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u0005\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u0002\u0018\u0000 \u00112\u00020\u0001:\u0001\u0011B\u0005\u00a2\u0006\u0002\u0010\u0002J\u0012\u0010\r\u001a\u00020\u000e2\b\u0010\u000f\u001a\u0004\u0018\u00010\u0010H\u0014R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082.\u00a2\u0006\u0002\n\u0000R\u001b\u0010\u0007\u001a\u00020\b8BX\u0082\u0084\u0002\u00a2\u0006\f\n\u0004\b\u000b\u0010\f\u001a\u0004\b\t\u0010\n\u00a8\u0006\u0012"}, d2 = {"Lca/qc/cstj/consortium/presentation/ui/deliveries/DeliveriesActivity;", "Landroidx/appcompat/app/AppCompatActivity;", "()V", "binding", "Lca/qc/cstj/consortium/databinding/ActivityDeliveriesBinding;", "deliveryRecyclerViewAdapter", "Lca/qc/cstj/consortium/presentation/adapters/DeliveryRecyclerViewAdapter;", "viewModel", "Lca/qc/cstj/consortium/presentation/ui/deliveries/DeliveriesViewModel;", "getViewModel", "()Lca/qc/cstj/consortium/presentation/ui/deliveries/DeliveriesViewModel;", "viewModel$delegate", "Lkotlin/Lazy;", "onCreate", "", "savedInstanceState", "Landroid/os/Bundle;", "Companion", "app_debug"})
public final class DeliveriesActivity extends androidx.appcompat.app.AppCompatActivity {
    private ca.qc.cstj.consortium.databinding.ActivityDeliveriesBinding binding;
    private final kotlin.Lazy viewModel$delegate = null;
    private ca.qc.cstj.consortium.presentation.adapters.DeliveryRecyclerViewAdapter deliveryRecyclerViewAdapter;
    @org.jetbrains.annotations.NotNull()
    public static final ca.qc.cstj.consortium.presentation.ui.deliveries.DeliveriesActivity.Companion Companion = null;
    
    public DeliveriesActivity() {
        super();
    }
    
    private final ca.qc.cstj.consortium.presentation.ui.deliveries.DeliveriesViewModel getViewModel() {
        return null;
    }
    
    @java.lang.Override()
    protected void onCreate(@org.jetbrains.annotations.Nullable()
    android.os.Bundle savedInstanceState) {
    }
    
    @kotlin.Metadata(mv = {1, 6, 0}, k = 1, d1 = {"\u0000\u0018\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\b\u0086\u0003\u0018\u00002\u00020\u0001B\u0007\b\u0002\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\u0003\u001a\u00020\u00042\u0006\u0010\u0005\u001a\u00020\u0006\u00a8\u0006\u0007"}, d2 = {"Lca/qc/cstj/consortium/presentation/ui/deliveries/DeliveriesActivity$Companion;", "", "()V", "newIntent", "Landroid/content/Intent;", "context", "Landroid/content/Context;", "app_debug"})
    public static final class Companion {
        
        private Companion() {
            super();
        }
        
        @org.jetbrains.annotations.NotNull()
        public final android.content.Intent newIntent(@org.jetbrains.annotations.NotNull()
        android.content.Context context) {
            return null;
        }
    }
}