package ca.qc.cstj.tenretni.presentation.ui.tickets;

import android.os.Bundle;
import android.os.Parcelable;
import androidx.annotation.NonNull;
import androidx.navigation.NavDirections;
import ca.qc.cstj.tenretni.R;
import com.google.android.gms.maps.model.LatLng;
import java.io.Serializable;
import java.lang.IllegalArgumentException;
import java.lang.Object;
import java.lang.Override;
import java.lang.String;
import java.lang.SuppressWarnings;
import java.util.HashMap;

public class DetailTicketFragmentDirections {
  private DetailTicketFragmentDirections() {
  }

  @NonNull
  public static ActionNavDetailTicketToMapsActivity actionNavDetailTicketToMapsActivity(
      @NonNull LatLng position, @NonNull String customerName) {
    return new ActionNavDetailTicketToMapsActivity(position, customerName);
  }

  @NonNull
  public static ActionNavDetailTicketToQRFragment actionNavDetailTicketToQRFragment(
      @NonNull String customerId, @NonNull String href) {
    return new ActionNavDetailTicketToQRFragment(customerId, href);
  }

  public static class ActionNavDetailTicketToMapsActivity implements NavDirections {
    private final HashMap arguments = new HashMap();

    @SuppressWarnings("unchecked")
    private ActionNavDetailTicketToMapsActivity(@NonNull LatLng position,
        @NonNull String customerName) {
      if (position == null) {
        throw new IllegalArgumentException("Argument \"position\" is marked as non-null but was passed a null value.");
      }
      this.arguments.put("position", position);
      if (customerName == null) {
        throw new IllegalArgumentException("Argument \"customerName\" is marked as non-null but was passed a null value.");
      }
      this.arguments.put("customerName", customerName);
    }

    @NonNull
    @SuppressWarnings("unchecked")
    public ActionNavDetailTicketToMapsActivity setPosition(@NonNull LatLng position) {
      if (position == null) {
        throw new IllegalArgumentException("Argument \"position\" is marked as non-null but was passed a null value.");
      }
      this.arguments.put("position", position);
      return this;
    }

    @NonNull
    @SuppressWarnings("unchecked")
    public ActionNavDetailTicketToMapsActivity setCustomerName(@NonNull String customerName) {
      if (customerName == null) {
        throw new IllegalArgumentException("Argument \"customerName\" is marked as non-null but was passed a null value.");
      }
      this.arguments.put("customerName", customerName);
      return this;
    }

    @Override
    @SuppressWarnings("unchecked")
    @NonNull
    public Bundle getArguments() {
      Bundle __result = new Bundle();
      if (arguments.containsKey("position")) {
        LatLng position = (LatLng) arguments.get("position");
        if (Parcelable.class.isAssignableFrom(LatLng.class) || position == null) {
          __result.putParcelable("position", Parcelable.class.cast(position));
        } else if (Serializable.class.isAssignableFrom(LatLng.class)) {
          __result.putSerializable("position", Serializable.class.cast(position));
        } else {
          throw new UnsupportedOperationException(LatLng.class.getName() + " must implement Parcelable or Serializable or must be an Enum.");
        }
      }
      if (arguments.containsKey("customerName")) {
        String customerName = (String) arguments.get("customerName");
        __result.putString("customerName", customerName);
      }
      return __result;
    }

    @Override
    public int getActionId() {
      return R.id.action_nav_detail_ticket_to_mapsActivity;
    }

    @SuppressWarnings("unchecked")
    @NonNull
    public LatLng getPosition() {
      return (LatLng) arguments.get("position");
    }

    @SuppressWarnings("unchecked")
    @NonNull
    public String getCustomerName() {
      return (String) arguments.get("customerName");
    }

    @Override
    public boolean equals(Object object) {
      if (this == object) {
          return true;
      }
      if (object == null || getClass() != object.getClass()) {
          return false;
      }
      ActionNavDetailTicketToMapsActivity that = (ActionNavDetailTicketToMapsActivity) object;
      if (arguments.containsKey("position") != that.arguments.containsKey("position")) {
        return false;
      }
      if (getPosition() != null ? !getPosition().equals(that.getPosition()) : that.getPosition() != null) {
        return false;
      }
      if (arguments.containsKey("customerName") != that.arguments.containsKey("customerName")) {
        return false;
      }
      if (getCustomerName() != null ? !getCustomerName().equals(that.getCustomerName()) : that.getCustomerName() != null) {
        return false;
      }
      if (getActionId() != that.getActionId()) {
        return false;
      }
      return true;
    }

    @Override
    public int hashCode() {
      int result = 1;
      result = 31 * result + (getPosition() != null ? getPosition().hashCode() : 0);
      result = 31 * result + (getCustomerName() != null ? getCustomerName().hashCode() : 0);
      result = 31 * result + getActionId();
      return result;
    }

    @Override
    public String toString() {
      return "ActionNavDetailTicketToMapsActivity(actionId=" + getActionId() + "){"
          + "position=" + getPosition()
          + ", customerName=" + getCustomerName()
          + "}";
    }
  }

  public static class ActionNavDetailTicketToQRFragment implements NavDirections {
    private final HashMap arguments = new HashMap();

    @SuppressWarnings("unchecked")
    private ActionNavDetailTicketToQRFragment(@NonNull String customerId, @NonNull String href) {
      if (customerId == null) {
        throw new IllegalArgumentException("Argument \"customerId\" is marked as non-null but was passed a null value.");
      }
      this.arguments.put("customerId", customerId);
      if (href == null) {
        throw new IllegalArgumentException("Argument \"href\" is marked as non-null but was passed a null value.");
      }
      this.arguments.put("href", href);
    }

    @NonNull
    @SuppressWarnings("unchecked")
    public ActionNavDetailTicketToQRFragment setCustomerId(@NonNull String customerId) {
      if (customerId == null) {
        throw new IllegalArgumentException("Argument \"customerId\" is marked as non-null but was passed a null value.");
      }
      this.arguments.put("customerId", customerId);
      return this;
    }

    @NonNull
    @SuppressWarnings("unchecked")
    public ActionNavDetailTicketToQRFragment setHref(@NonNull String href) {
      if (href == null) {
        throw new IllegalArgumentException("Argument \"href\" is marked as non-null but was passed a null value.");
      }
      this.arguments.put("href", href);
      return this;
    }

    @Override
    @SuppressWarnings("unchecked")
    @NonNull
    public Bundle getArguments() {
      Bundle __result = new Bundle();
      if (arguments.containsKey("customerId")) {
        String customerId = (String) arguments.get("customerId");
        __result.putString("customerId", customerId);
      }
      if (arguments.containsKey("href")) {
        String href = (String) arguments.get("href");
        __result.putString("href", href);
      }
      return __result;
    }

    @Override
    public int getActionId() {
      return R.id.action_nav_detail_ticket_to_QRFragment;
    }

    @SuppressWarnings("unchecked")
    @NonNull
    public String getCustomerId() {
      return (String) arguments.get("customerId");
    }

    @SuppressWarnings("unchecked")
    @NonNull
    public String getHref() {
      return (String) arguments.get("href");
    }

    @Override
    public boolean equals(Object object) {
      if (this == object) {
          return true;
      }
      if (object == null || getClass() != object.getClass()) {
          return false;
      }
      ActionNavDetailTicketToQRFragment that = (ActionNavDetailTicketToQRFragment) object;
      if (arguments.containsKey("customerId") != that.arguments.containsKey("customerId")) {
        return false;
      }
      if (getCustomerId() != null ? !getCustomerId().equals(that.getCustomerId()) : that.getCustomerId() != null) {
        return false;
      }
      if (arguments.containsKey("href") != that.arguments.containsKey("href")) {
        return false;
      }
      if (getHref() != null ? !getHref().equals(that.getHref()) : that.getHref() != null) {
        return false;
      }
      if (getActionId() != that.getActionId()) {
        return false;
      }
      return true;
    }

    @Override
    public int hashCode() {
      int result = 1;
      result = 31 * result + (getCustomerId() != null ? getCustomerId().hashCode() : 0);
      result = 31 * result + (getHref() != null ? getHref().hashCode() : 0);
      result = 31 * result + getActionId();
      return result;
    }

    @Override
    public String toString() {
      return "ActionNavDetailTicketToQRFragment(actionId=" + getActionId() + "){"
          + "customerId=" + getCustomerId()
          + ", href=" + getHref()
          + "}";
    }
  }
}
