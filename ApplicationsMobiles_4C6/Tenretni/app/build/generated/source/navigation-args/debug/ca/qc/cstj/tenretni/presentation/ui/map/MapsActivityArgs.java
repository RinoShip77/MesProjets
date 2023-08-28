package ca.qc.cstj.tenretni.presentation.ui.map;

import android.os.Bundle;
import android.os.Parcelable;
import androidx.annotation.NonNull;
import androidx.lifecycle.SavedStateHandle;
import androidx.navigation.NavArgs;
import com.google.android.gms.maps.model.LatLng;
import java.io.Serializable;
import java.lang.IllegalArgumentException;
import java.lang.Object;
import java.lang.Override;
import java.lang.String;
import java.lang.SuppressWarnings;
import java.util.HashMap;

public class MapsActivityArgs implements NavArgs {
  private final HashMap arguments = new HashMap();

  private MapsActivityArgs() {
  }

  @SuppressWarnings("unchecked")
  private MapsActivityArgs(HashMap argumentsMap) {
    this.arguments.putAll(argumentsMap);
  }

  @NonNull
  @SuppressWarnings("unchecked")
  public static MapsActivityArgs fromBundle(@NonNull Bundle bundle) {
    MapsActivityArgs __result = new MapsActivityArgs();
    bundle.setClassLoader(MapsActivityArgs.class.getClassLoader());
    if (bundle.containsKey("position")) {
      LatLng position;
      if (Parcelable.class.isAssignableFrom(LatLng.class) || Serializable.class.isAssignableFrom(LatLng.class)) {
        position = (LatLng) bundle.get("position");
      } else {
        throw new UnsupportedOperationException(LatLng.class.getName() + " must implement Parcelable or Serializable or must be an Enum.");
      }
      if (position == null) {
        throw new IllegalArgumentException("Argument \"position\" is marked as non-null but was passed a null value.");
      }
      __result.arguments.put("position", position);
    } else {
      throw new IllegalArgumentException("Required argument \"position\" is missing and does not have an android:defaultValue");
    }
    if (bundle.containsKey("customerName")) {
      String customerName;
      customerName = bundle.getString("customerName");
      if (customerName == null) {
        throw new IllegalArgumentException("Argument \"customerName\" is marked as non-null but was passed a null value.");
      }
      __result.arguments.put("customerName", customerName);
    } else {
      throw new IllegalArgumentException("Required argument \"customerName\" is missing and does not have an android:defaultValue");
    }
    return __result;
  }

  @NonNull
  @SuppressWarnings("unchecked")
  public static MapsActivityArgs fromSavedStateHandle(@NonNull SavedStateHandle savedStateHandle) {
    MapsActivityArgs __result = new MapsActivityArgs();
    if (savedStateHandle.contains("position")) {
      LatLng position;
      position = savedStateHandle.get("position");
      if (position == null) {
        throw new IllegalArgumentException("Argument \"position\" is marked as non-null but was passed a null value.");
      }
      __result.arguments.put("position", position);
    } else {
      throw new IllegalArgumentException("Required argument \"position\" is missing and does not have an android:defaultValue");
    }
    if (savedStateHandle.contains("customerName")) {
      String customerName;
      customerName = savedStateHandle.get("customerName");
      if (customerName == null) {
        throw new IllegalArgumentException("Argument \"customerName\" is marked as non-null but was passed a null value.");
      }
      __result.arguments.put("customerName", customerName);
    } else {
      throw new IllegalArgumentException("Required argument \"customerName\" is missing and does not have an android:defaultValue");
    }
    return __result;
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

  @SuppressWarnings("unchecked")
  @NonNull
  public Bundle toBundle() {
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

  @SuppressWarnings("unchecked")
  @NonNull
  public SavedStateHandle toSavedStateHandle() {
    SavedStateHandle __result = new SavedStateHandle();
    if (arguments.containsKey("position")) {
      LatLng position = (LatLng) arguments.get("position");
      if (Parcelable.class.isAssignableFrom(LatLng.class) || position == null) {
        __result.set("position", Parcelable.class.cast(position));
      } else if (Serializable.class.isAssignableFrom(LatLng.class)) {
        __result.set("position", Serializable.class.cast(position));
      } else {
        throw new UnsupportedOperationException(LatLng.class.getName() + " must implement Parcelable or Serializable or must be an Enum.");
      }
    }
    if (arguments.containsKey("customerName")) {
      String customerName = (String) arguments.get("customerName");
      __result.set("customerName", customerName);
    }
    return __result;
  }

  @Override
  public boolean equals(Object object) {
    if (this == object) {
        return true;
    }
    if (object == null || getClass() != object.getClass()) {
        return false;
    }
    MapsActivityArgs that = (MapsActivityArgs) object;
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
    return true;
  }

  @Override
  public int hashCode() {
    int result = 1;
    result = 31 * result + (getPosition() != null ? getPosition().hashCode() : 0);
    result = 31 * result + (getCustomerName() != null ? getCustomerName().hashCode() : 0);
    return result;
  }

  @Override
  public String toString() {
    return "MapsActivityArgs{"
        + "position=" + getPosition()
        + ", customerName=" + getCustomerName()
        + "}";
  }

  public static final class Builder {
    private final HashMap arguments = new HashMap();

    @SuppressWarnings("unchecked")
    public Builder(@NonNull MapsActivityArgs original) {
      this.arguments.putAll(original.arguments);
    }

    @SuppressWarnings("unchecked")
    public Builder(@NonNull LatLng position, @NonNull String customerName) {
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
    public MapsActivityArgs build() {
      MapsActivityArgs result = new MapsActivityArgs(arguments);
      return result;
    }

    @NonNull
    @SuppressWarnings("unchecked")
    public Builder setPosition(@NonNull LatLng position) {
      if (position == null) {
        throw new IllegalArgumentException("Argument \"position\" is marked as non-null but was passed a null value.");
      }
      this.arguments.put("position", position);
      return this;
    }

    @NonNull
    @SuppressWarnings("unchecked")
    public Builder setCustomerName(@NonNull String customerName) {
      if (customerName == null) {
        throw new IllegalArgumentException("Argument \"customerName\" is marked as non-null but was passed a null value.");
      }
      this.arguments.put("customerName", customerName);
      return this;
    }

    @SuppressWarnings({"unchecked","GetterOnBuilder"})
    @NonNull
    public LatLng getPosition() {
      return (LatLng) arguments.get("position");
    }

    @SuppressWarnings({"unchecked","GetterOnBuilder"})
    @NonNull
    public String getCustomerName() {
      return (String) arguments.get("customerName");
    }
  }
}
