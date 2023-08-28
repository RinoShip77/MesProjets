package ca.qc.cstj.tenretni.presentation.ui.gateways;

import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.navigation.NavDirections;
import ca.qc.cstj.tenretni.R;
import java.lang.IllegalArgumentException;
import java.lang.Object;
import java.lang.Override;
import java.lang.String;
import java.lang.SuppressWarnings;
import java.util.HashMap;

public class GatewaysFragmentDirections {
  private GatewaysFragmentDirections() {
  }

  @NonNull
  public static ActionNavGatewaysToNavDetailGateway actionNavGatewaysToNavDetailGateway(
      @NonNull String href) {
    return new ActionNavGatewaysToNavDetailGateway(href);
  }

  public static class ActionNavGatewaysToNavDetailGateway implements NavDirections {
    private final HashMap arguments = new HashMap();

    @SuppressWarnings("unchecked")
    private ActionNavGatewaysToNavDetailGateway(@NonNull String href) {
      if (href == null) {
        throw new IllegalArgumentException("Argument \"href\" is marked as non-null but was passed a null value.");
      }
      this.arguments.put("href", href);
    }

    @NonNull
    @SuppressWarnings("unchecked")
    public ActionNavGatewaysToNavDetailGateway setHref(@NonNull String href) {
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
      if (arguments.containsKey("href")) {
        String href = (String) arguments.get("href");
        __result.putString("href", href);
      }
      return __result;
    }

    @Override
    public int getActionId() {
      return R.id.action_nav_gateways_to_nav_detail_gateway;
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
      ActionNavGatewaysToNavDetailGateway that = (ActionNavGatewaysToNavDetailGateway) object;
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
      result = 31 * result + (getHref() != null ? getHref().hashCode() : 0);
      result = 31 * result + getActionId();
      return result;
    }

    @Override
    public String toString() {
      return "ActionNavGatewaysToNavDetailGateway(actionId=" + getActionId() + "){"
          + "href=" + getHref()
          + "}";
    }
  }
}
