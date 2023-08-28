package ca.qc.cstj.tenretni.presentation.ui.gateways;

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

public class DetailGatewayFragmentArgs implements NavArgs {
  private final HashMap arguments = new HashMap();

  private DetailGatewayFragmentArgs() {
  }

  @SuppressWarnings("unchecked")
  private DetailGatewayFragmentArgs(HashMap argumentsMap) {
    this.arguments.putAll(argumentsMap);
  }

  @NonNull
  @SuppressWarnings("unchecked")
  public static DetailGatewayFragmentArgs fromBundle(@NonNull Bundle bundle) {
    DetailGatewayFragmentArgs __result = new DetailGatewayFragmentArgs();
    bundle.setClassLoader(DetailGatewayFragmentArgs.class.getClassLoader());
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
  public static DetailGatewayFragmentArgs fromSavedStateHandle(
      @NonNull SavedStateHandle savedStateHandle) {
    DetailGatewayFragmentArgs __result = new DetailGatewayFragmentArgs();
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
  public String getHref() {
    return (String) arguments.get("href");
  }

  @SuppressWarnings("unchecked")
  @NonNull
  public Bundle toBundle() {
    Bundle __result = new Bundle();
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
    DetailGatewayFragmentArgs that = (DetailGatewayFragmentArgs) object;
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
    result = 31 * result + (getHref() != null ? getHref().hashCode() : 0);
    return result;
  }

  @Override
  public String toString() {
    return "DetailGatewayFragmentArgs{"
        + "href=" + getHref()
        + "}";
  }

  public static final class Builder {
    private final HashMap arguments = new HashMap();

    @SuppressWarnings("unchecked")
    public Builder(@NonNull DetailGatewayFragmentArgs original) {
      this.arguments.putAll(original.arguments);
    }

    @SuppressWarnings("unchecked")
    public Builder(@NonNull String href) {
      if (href == null) {
        throw new IllegalArgumentException("Argument \"href\" is marked as non-null but was passed a null value.");
      }
      this.arguments.put("href", href);
    }

    @NonNull
    public DetailGatewayFragmentArgs build() {
      DetailGatewayFragmentArgs result = new DetailGatewayFragmentArgs(arguments);
      return result;
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
    public String getHref() {
      return (String) arguments.get("href");
    }
  }
}
