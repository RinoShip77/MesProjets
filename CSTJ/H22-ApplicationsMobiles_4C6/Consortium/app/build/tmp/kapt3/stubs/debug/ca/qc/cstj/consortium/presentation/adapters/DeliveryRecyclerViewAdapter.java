package ca.qc.cstj.consortium.presentation.adapters;

import java.lang.System;

@kotlin.Metadata(mv = {1, 6, 0}, k = 1, d1 = {"\u00000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\b\u0005\n\u0002\u0010\b\n\u0000\n\u0002\u0010\u0002\n\u0002\b\u0004\n\u0002\u0018\u0002\n\u0002\b\u0003\u0018\u00002\f\u0012\b\u0012\u00060\u0002R\u00020\u00000\u0001:\u0001\u0014B\u0013\u0012\f\u0010\u0003\u001a\b\u0012\u0004\u0012\u00020\u00050\u0004\u00a2\u0006\u0002\u0010\u0006J\b\u0010\n\u001a\u00020\u000bH\u0016J\u001c\u0010\f\u001a\u00020\r2\n\u0010\u000e\u001a\u00060\u0002R\u00020\u00002\u0006\u0010\u000f\u001a\u00020\u000bH\u0016J\u001c\u0010\u0010\u001a\u00060\u0002R\u00020\u00002\u0006\u0010\u0011\u001a\u00020\u00122\u0006\u0010\u0013\u001a\u00020\u000bH\u0016R \u0010\u0003\u001a\b\u0012\u0004\u0012\u00020\u00050\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\b\u0007\u0010\b\"\u0004\b\t\u0010\u0006\u00a8\u0006\u0015"}, d2 = {"Lca/qc/cstj/consortium/presentation/adapters/DeliveryRecyclerViewAdapter;", "Landroidx/recyclerview/widget/RecyclerView$Adapter;", "Lca/qc/cstj/consortium/presentation/adapters/DeliveryRecyclerViewAdapter$ViewHolder;", "deliveries", "", "Lca/qc/cstj/consortium/domain/models/Delivery;", "(Ljava/util/List;)V", "getDeliveries", "()Ljava/util/List;", "setDeliveries", "getItemCount", "", "onBindViewHolder", "", "holder", "position", "onCreateViewHolder", "parent", "Landroid/view/ViewGroup;", "viewType", "ViewHolder", "app_debug"})
public final class DeliveryRecyclerViewAdapter extends androidx.recyclerview.widget.RecyclerView.Adapter<ca.qc.cstj.consortium.presentation.adapters.DeliveryRecyclerViewAdapter.ViewHolder> {
    @org.jetbrains.annotations.NotNull()
    private java.util.List<ca.qc.cstj.consortium.domain.models.Delivery> deliveries;
    
    public DeliveryRecyclerViewAdapter(@org.jetbrains.annotations.NotNull()
    java.util.List<ca.qc.cstj.consortium.domain.models.Delivery> deliveries) {
        super();
    }
    
    @org.jetbrains.annotations.NotNull()
    public final java.util.List<ca.qc.cstj.consortium.domain.models.Delivery> getDeliveries() {
        return null;
    }
    
    public final void setDeliveries(@org.jetbrains.annotations.NotNull()
    java.util.List<ca.qc.cstj.consortium.domain.models.Delivery> p0) {
    }
    
    @org.jetbrains.annotations.NotNull()
    @java.lang.Override()
    public ca.qc.cstj.consortium.presentation.adapters.DeliveryRecyclerViewAdapter.ViewHolder onCreateViewHolder(@org.jetbrains.annotations.NotNull()
    android.view.ViewGroup parent, int viewType) {
        return null;
    }
    
    @java.lang.Override()
    public void onBindViewHolder(@org.jetbrains.annotations.NotNull()
    ca.qc.cstj.consortium.presentation.adapters.DeliveryRecyclerViewAdapter.ViewHolder holder, int position) {
    }
    
    @java.lang.Override()
    public int getItemCount() {
        return 0;
    }
    
    @kotlin.Metadata(mv = {1, 6, 0}, k = 1, d1 = {"\u0000$\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\b\u0086\u0004\u0018\u00002\u00020\u0001B\r\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004J\u000e\u0010\u0007\u001a\u00020\b2\u0006\u0010\t\u001a\u00020\nR\u000e\u0010\u0005\u001a\u00020\u0006X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u000b"}, d2 = {"Lca/qc/cstj/consortium/presentation/adapters/DeliveryRecyclerViewAdapter$ViewHolder;", "Landroidx/recyclerview/widget/RecyclerView$ViewHolder;", "view", "Landroid/view/View;", "(Lca/qc/cstj/consortium/presentation/adapters/DeliveryRecyclerViewAdapter;Landroid/view/View;)V", "binding", "Lca/qc/cstj/consortium/databinding/ItemDeliveryBinding;", "bind", "", "delivery", "Lca/qc/cstj/consortium/domain/models/Delivery;", "app_debug"})
    public final class ViewHolder extends androidx.recyclerview.widget.RecyclerView.ViewHolder {
        private final ca.qc.cstj.consortium.databinding.ItemDeliveryBinding binding = null;
        
        public ViewHolder(@org.jetbrains.annotations.NotNull()
        android.view.View view) {
            super(null);
        }
        
        public final void bind(@org.jetbrains.annotations.NotNull()
        ca.qc.cstj.consortium.domain.models.Delivery delivery) {
        }
    }
}