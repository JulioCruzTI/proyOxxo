
package WebServices;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.xml.bind.annotation.XmlSeeAlso;
import javax.xml.ws.Action;
import javax.xml.ws.RequestWrapper;
import javax.xml.ws.ResponseWrapper;


/**
 * This class was generated by the JAX-WS RI.
 * JAX-WS RI 2.2.6-1b01 
 * Generated source version: 2.2
 * 
 */
@WebService(name = "WSTelefonia", targetNamespace = "http://service/")
@XmlSeeAlso({
    ObjectFactory.class
})
public interface WSTelefonia {


    /**
     * 
     * @param monto
     * @param noCel
     * @param idTelefonia
     * @return
     *     returns WebServices.Respuesta
     */
    @WebMethod(operationName = "Recarga")
    @WebResult(targetNamespace = "")
    @RequestWrapper(localName = "Recarga", targetNamespace = "http://service/", className = "WebServices.Recarga")
    @ResponseWrapper(localName = "RecargaResponse", targetNamespace = "http://service/", className = "WebServices.RecargaResponse")
    @Action(input = "http://service/WSTelefonia/RecargaRequest", output = "http://service/WSTelefonia/RecargaResponse")
    public Respuesta recarga(
        @WebParam(name = "noCel", targetNamespace = "")
        String noCel,
        @WebParam(name = "idTelefonia", targetNamespace = "")
        int idTelefonia,
        @WebParam(name = "monto", targetNamespace = "")
        float monto);

    /**
     * 
     * @param tiempo
     * @param idTipoMovimiento
     * @param noCel
     * @param idTelefonia
     * @return
     *     returns WebServices.Respuesta
     */
    @WebMethod(operationName = "UsoTelefono")
    @WebResult(targetNamespace = "")
    @RequestWrapper(localName = "UsoTelefono", targetNamespace = "http://service/", className = "WebServices.UsoTelefono")
    @ResponseWrapper(localName = "UsoTelefonoResponse", targetNamespace = "http://service/", className = "WebServices.UsoTelefonoResponse")
    @Action(input = "http://service/WSTelefonia/UsoTelefonoRequest", output = "http://service/WSTelefonia/UsoTelefonoResponse")
    public Respuesta usoTelefono(
        @WebParam(name = "idTipoMovimiento", targetNamespace = "")
        int idTipoMovimiento,
        @WebParam(name = "idTelefonia", targetNamespace = "")
        int idTelefonia,
        @WebParam(name = "tiempo", targetNamespace = "")
        float tiempo,
        @WebParam(name = "noCel", targetNamespace = "")
        String noCel);

    /**
     * 
     * @param cliente
     * @return
     *     returns WebServices.Respuesta
     */
    @WebMethod(operationName = "InsertaCliente")
    @WebResult(targetNamespace = "")
    @RequestWrapper(localName = "InsertaCliente", targetNamespace = "http://service/", className = "WebServices.InsertaCliente")
    @ResponseWrapper(localName = "InsertaClienteResponse", targetNamespace = "http://service/", className = "WebServices.InsertaClienteResponse")
    @Action(input = "http://service/WSTelefonia/InsertaClienteRequest", output = "http://service/WSTelefonia/InsertaClienteResponse")
    public Respuesta insertaCliente(
        @WebParam(name = "cliente", targetNamespace = "")
        Cliente cliente);

    /**
     * 
     * @param proveedor
     * @return
     *     returns WebServices.Respuesta
     */
    @WebMethod(operationName = "InsertaProveedor")
    @WebResult(targetNamespace = "")
    @RequestWrapper(localName = "InsertaProveedor", targetNamespace = "http://service/", className = "WebServices.InsertaProveedor")
    @ResponseWrapper(localName = "InsertaProveedorResponse", targetNamespace = "http://service/", className = "WebServices.InsertaProveedorResponse")
    @Action(input = "http://service/WSTelefonia/InsertaProveedorRequest", output = "http://service/WSTelefonia/InsertaProveedorResponse")
    public Respuesta insertaProveedor(
        @WebParam(name = "proveedor", targetNamespace = "")
        ProveedoresTelefonia proveedor);

    /**
     * 
     * @param noCel
     * @return
     *     returns WebServices.RespuestaSaldo
     */
    @WebMethod(operationName = "Saldo")
    @WebResult(targetNamespace = "")
    @RequestWrapper(localName = "Saldo", targetNamespace = "http://service/", className = "WebServices.Saldo")
    @ResponseWrapper(localName = "SaldoResponse", targetNamespace = "http://service/", className = "WebServices.SaldoResponse")
    @Action(input = "http://service/WSTelefonia/SaldoRequest", output = "http://service/WSTelefonia/SaldoResponse")
    public RespuestaSaldo saldo(
        @WebParam(name = "noCel", targetNamespace = "")
        String noCel);

    /**
     * 
     * @return
     *     returns WebServices.RespuestaGetProveedoresTelefonia
     */
    @WebMethod(operationName = "GetProveedoresTelefonia")
    @WebResult(targetNamespace = "")
    @RequestWrapper(localName = "GetProveedoresTelefonia", targetNamespace = "http://service/", className = "WebServices.GetProveedoresTelefonia")
    @ResponseWrapper(localName = "GetProveedoresTelefoniaResponse", targetNamespace = "http://service/", className = "WebServices.GetProveedoresTelefoniaResponse")
    @Action(input = "http://service/WSTelefonia/GetProveedoresTelefoniaRequest", output = "http://service/WSTelefonia/GetProveedoresTelefoniaResponse")
    public RespuestaGetProveedoresTelefonia getProveedoresTelefonia();

    /**
     * 
     * @return
     *     returns WebServices.RespuestaTiposMovimiento
     */
    @WebMethod(operationName = "GetTiposMovimiento")
    @WebResult(targetNamespace = "")
    @RequestWrapper(localName = "GetTiposMovimiento", targetNamespace = "http://service/", className = "WebServices.GetTiposMovimiento")
    @ResponseWrapper(localName = "GetTiposMovimientoResponse", targetNamespace = "http://service/", className = "WebServices.GetTiposMovimientoResponse")
    @Action(input = "http://service/WSTelefonia/GetTiposMovimientoRequest", output = "http://service/WSTelefonia/GetTiposMovimientoResponse")
    public RespuestaTiposMovimiento getTiposMovimiento();

    /**
     * 
     * @param tiposMovimiento
     * @return
     *     returns WebServices.Respuesta
     */
    @WebMethod(operationName = "InsertaTipoMovimiento")
    @WebResult(targetNamespace = "")
    @RequestWrapper(localName = "InsertaTipoMovimiento", targetNamespace = "http://service/", className = "WebServices.InsertaTipoMovimiento")
    @ResponseWrapper(localName = "InsertaTipoMovimientoResponse", targetNamespace = "http://service/", className = "WebServices.InsertaTipoMovimientoResponse")
    @Action(input = "http://service/WSTelefonia/InsertaTipoMovimientoRequest", output = "http://service/WSTelefonia/InsertaTipoMovimientoResponse")
    public Respuesta insertaTipoMovimiento(
        @WebParam(name = "tiposMovimiento", targetNamespace = "")
        TiposMovimiento tiposMovimiento);

}