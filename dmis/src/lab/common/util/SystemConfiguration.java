package lab.common.util;

import java.util.ArrayList;
import java.util.List;
import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.commons.configuration.reloading.FileChangedReloadingStrategy;

public class SystemConfiguration
{
  private static CompositeConfiguration config = new CompositeConfiguration();
  private static PropertiesConfiguration propertiesConfig;

  public static String getString(String paramString)
  {
    return config.getString(paramString);
  }

  public static String getString(String paramString1, String paramString2)
  {
    return config.getString(paramString1, paramString2);
  }

  public static int getInt(String paramString)
  {
    return config.getInt(paramString);
  }

  public static int getInt(String paramString, int paramInt)
  {
    return config.getInt(paramString, paramInt);
  }

  public static float getFloat(String paramString)
  {
    return config.getFloat(paramString);
  }

  public static float getFloat(String paramString, float paramFloat)
  {
    return config.getFloat(paramString, paramFloat);
  }

  public static boolean getBoolean(String paramString)
  {
    return config.getBoolean(paramString);
  }

  public static boolean getBoolean(String paramString, boolean paramBoolean)
  {
    return config.getBoolean(paramString, paramBoolean);
  }

  public static String[] getStringArray(String paramString)
  {
    return config.getStringArray(paramString);
  }

  @SuppressWarnings("unchecked")
public static List<String> getStringList(String paramString)
  {
    ArrayList localArrayList = new ArrayList();
    String[] arrayOfString1 = getStringArray(paramString);
    String[] arrayOfString2 = arrayOfString1;
    int i = arrayOfString2.length;
    for (int j = 0; j < i; ++j)
    {
      String str = arrayOfString2[j];
      localArrayList.add(str);
    }
    return localArrayList;
  }

  @SuppressWarnings("unchecked")
public static List getList(String paramString)
  {
    return config.getList(paramString);
  }

  static
  {
    if (propertiesConfig == null)
      try
      {
        propertiesConfig = new PropertiesConfiguration("config.properties");
        propertiesConfig.setReloadingStrategy(new FileChangedReloadingStrategy());
        config.addConfiguration(propertiesConfig);
      }
      catch (ConfigurationException localConfigurationException)
      {
        localConfigurationException.printStackTrace();
      }
  }
}
