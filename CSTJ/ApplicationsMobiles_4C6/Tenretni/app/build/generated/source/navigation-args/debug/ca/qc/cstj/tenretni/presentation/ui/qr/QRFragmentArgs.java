package ca.qc.cstj.tenretni.presentation.ui.qr;

import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.lifecycle.SavedStateHandle;
import androidx.navigation.NavArgs;
import java.lang.IllegalArgumentException;
import java.lang.Object;
import java.lang.Override;
import java.lang.String;
import java.lang.SuppressWarnings;
import java.util.HashMap;

public class QRFragmentArgs implements NavArgs {
  private final HashMap arguments = new HashMap();

  private QRFragmentArgs() {
  }

  @SuppressWarnings("unchecked")
  private QRFragmentArgs(HashMap argumentsMap) {
    this.arguments.putAll(argumentsMap);
  }

  @NonNull
  @SuppressWarnings("unchecked")
  public static QRFragmentArgs fromBundle(@NonNull Bundle bundle) {
    QRFragmentArgs __result = new QRFragmentArgs();
    bundle.setClassLoader(QRFragmentArgs.class.getClassLoader());
    if (bundle.containsKey("customerId")) {
      String customerId;
      customerId = bundle.getString("customerId");
      if (customerId == null) {
        throw new IllegalArgumentException("Argument \"customerId\" is marked as non-null but was passed a null value.");
      }
      __result.arguments.put("customerId", customerId);
    } else {
      throw new IllegalArgumentException("Required argument \"customerId\" is missing and does not have an android:defaultValue");
    }
    if (bundle.containsKey("href")) {
      String href;
      href = bundle.getString("href");
      if (href == null) {
        throw new IllegalArgumentException("Argument \"href\" is marked as non-null but was passed a null value.");
      }
      __result.arguments.put("href", href);
    } else {
      throw new IllegalArgumentException("Required argument \"href\" is missing and does not have an android:defaultValue");
    }
    return __result;
  }

  @NonNull
  @SuppressWarnings("unchecked")
  public static QRFragmentArgs fromSavedStateHandle(@NonNull SavedStateHandle savedStateHandle) {
    QRFragmentArgs __result = new QRFragmentArgs();
    if (savedStateHandle.contains("customerId")) {
      String customerId;
      customerId = savedStateHandle.get("customerId");
      if (customerId == null) {
        throw new IllegalArgumentException("Argument \"customerId\" is marked as non-null but was passed a null value.");
      }
      __result.arguments.put("customerId", customerId);
    } else {
      throw new IllegalArgumentException("Required argument \"customerId\" is missing and does not have an android:defaultValue");
    }
    if (savedStateHandle.contains("href")) {
      String href;
      href = savedStateHandle.get("href");
      if (href == null) {
        throw new IllegalArgumentException("Argument \"href\" is marked as non-null but was passed a null value.");
      }
      __result.arguments.put("href", href);
    } else {
      throw new IllegalArgumentException("Required argument \"href\" is missing and does not have an android:defaultValue");
    }
    return __result;
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

  @SuppressWarnings("unchecked")
  @NonNull
  public Bundle toBundle() {
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

  @SuppressWarnings("unchecked")
  @NonNull
  public SavedStateHandle toSavedStateHandle() {
    SavedStateHandle __result = new SavedStateHandle();
    if (arguments.containsKey("customerId")) {
      String customerId = (String) arguments.get("customerId");
      __result.set("customerId", customerId);
    }
    if (arguments.containsKey("href")) {
      String href = (String) arguments.get("href");
      __result.set("href", href);
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
    QRFragmentArgs that = (QRFragmentArgs) object;
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
    return true;
  }

  @Override
  public int hashCode() {
    int result = 1;
    result = 31 * result + (getCustomerId() != null ? getCustomerId().hashCode() : 0);
    result = 31 * result + (getHref() != null ? getHref().hashCode() : 0);
    return result;
  }

  @Override
  public String toString() {
    return "QRFragmentArgs{"
        + "customerId=" + getCustomerId()
        + ", href=" + getHref()
        + "}";
  }

  public static final class Builder {
    private final HashMap arguments = new HashMap();

    @SuppressWarnings("unchecked")
    public Builder(@NonNull QRFragmentArgs original) {
      this.arguments.putAll(original.arguments);
    }

    @SuppressWarnings("unchecked")
    public Builder(@NonNull String customerId, @NonNull String href) {
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
    public QRFragmentArgs build() {
      QRFragmentArgs result = new QRFragmentArgs(arguments);
      return result;
    }

    @NonNull
    @SuppressWarnings("unchecked")
    public Builder setCustomerId(@NonNull String customerId) {
      if (customerId == null) {
        throw new IllegalArgumentException("Argument \"customerId\" is marked as non-null but was passed a null value.");
      }
      this.arguments.put("customerId", customerId);
      return this;
    }

    @NonNull
    @SuppressWarnings("unchecked")
    public Builder setHref(@NonNull String href) {
      if (href == null) {
        throw new IllegalArgumentException("Argument \"href\" is marked as non-null but was passed a null value.");
      }
      this.arguments.put("href", href);
      return this;
    }

    @SuppressWarnings({"unchecked","GetterOnBuilder"})
    @NonNull
    public String getCustomerId() {
      return (String) arguments.get("customerId");
    }

    @SuppressWarnings({"unchecked","GetterOnBuilder"})
    @NonNull
    public String getHref() {
      return (String) arguments.get("href");
    }
  }
}
