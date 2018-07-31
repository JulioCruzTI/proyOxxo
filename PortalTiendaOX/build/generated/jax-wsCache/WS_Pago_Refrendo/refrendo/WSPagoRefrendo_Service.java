
package refrendo;

import java.net.MalformedURLException;
import java.net.URL;
import javax.xml.namespace.QName;
import javax.xml.ws.Service;
import javax.xml.ws.WebEndpoint;
import javax.xml.ws.WebServiceClient;
import javax.xml.ws.WebServiceException;
import javax.xml.ws.WebServiceFeature;


/**
 * This class was generated by the JAX-WS RI.
 * JAX-WS RI 2.2.6-1b01 
 * Generated source version: 2.2
 * 
 */
@WebServiceClient(name = "WS_Pago_Refrendo", targetNamespace = "http://refrendo/", wsdlLocation = "http://127.0.0.1:8090/Oxxo/WS_Pago_Refrendo?wsdl")
public class WSPagoRefrendo_Service
    extends Service
{

    private final static URL WSPAGOREFRENDO_WSDL_LOCATION;
    private final static WebServiceException WSPAGOREFRENDO_EXCEPTION;
    private final static QName WSPAGOREFRENDO_QNAME = new QName("http://refrendo/", "WS_Pago_Refrendo");

    static {
        URL url = null;
        WebServiceException e = null;
        try {
            url = new URL("http://127.0.0.1:8090/Oxxo/WS_Pago_Refrendo?wsdl");
        } catch (MalformedURLException ex) {
            e = new WebServiceException(ex);
        }
        WSPAGOREFRENDO_WSDL_LOCATION = url;
        WSPAGOREFRENDO_EXCEPTION = e;
    }

    public WSPagoRefrendo_Service() {
        super(__getWsdlLocation(), WSPAGOREFRENDO_QNAME);
    }

    public WSPagoRefrendo_Service(WebServiceFeature... features) {
        super(__getWsdlLocation(), WSPAGOREFRENDO_QNAME, features);
    }

    public WSPagoRefrendo_Service(URL wsdlLocation) {
        super(wsdlLocation, WSPAGOREFRENDO_QNAME);
    }

    public WSPagoRefrendo_Service(URL wsdlLocation, WebServiceFeature... features) {
        super(wsdlLocation, WSPAGOREFRENDO_QNAME, features);
    }

    public WSPagoRefrendo_Service(URL wsdlLocation, QName serviceName) {
        super(wsdlLocation, serviceName);
    }

    public WSPagoRefrendo_Service(URL wsdlLocation, QName serviceName, WebServiceFeature... features) {
        super(wsdlLocation, serviceName, features);
    }

    /**
     * 
     * @return
     *     returns WSPagoRefrendo
     */
    @WebEndpoint(name = "WS_Pago_RefrendoPort")
    public WSPagoRefrendo getWSPagoRefrendoPort() {
        return super.getPort(new QName("http://refrendo/", "WS_Pago_RefrendoPort"), WSPagoRefrendo.class);
    }

    /**
     * 
     * @param features
     *     A list of {@link javax.xml.ws.WebServiceFeature} to configure on the proxy.  Supported features not in the <code>features</code> parameter will have their default values.
     * @return
     *     returns WSPagoRefrendo
     */
    @WebEndpoint(name = "WS_Pago_RefrendoPort")
    public WSPagoRefrendo getWSPagoRefrendoPort(WebServiceFeature... features) {
        return super.getPort(new QName("http://refrendo/", "WS_Pago_RefrendoPort"), WSPagoRefrendo.class, features);
    }

    private static URL __getWsdlLocation() {
        if (WSPAGOREFRENDO_EXCEPTION!= null) {
            throw WSPAGOREFRENDO_EXCEPTION;
        }
        return WSPAGOREFRENDO_WSDL_LOCATION;
    }

}
