Class cysnet.clinicaDental.notificaciones.bo.NotificacionesSQL Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method GenerarNotificacion(pRequest As cysnet.clinicaDental.notificaciones.msg.GenerarNotificacionRequest, Output pResponse As cysnet.clinicaDental.notificaciones.msg.GenerarNotificacionResponse) As %Status
{
  #dim sc As %Status = $$$OK
  #dim numRows As %Integer = 0
  Set pResponse = ##class(cysnet.clinicaDental.notificaciones.msg.GenerarNotificacionResponse).%New()
  Set pResponse.exito = 1
 
  Try {
   set sql = "INSERT INTO ClinicaDental.Notificacion(idPaciente,asunto,mensaje,indEnviada) VALUES (?,?,?,0)"
    set sc = ..Adapter.ExecuteUpdate(.numRows, sql, pRequest.idPaciente, pRequest.asunto, pRequest.mensaje)

    if ($$$ISOK(sc)) {
      if (numRows = 0) {
        Set pResponse.exito = 0
        Set pResponse.error = "No se pudo enviar notificacion"
      }else{
        Set pResponse.mensaje = "Se notifica paciente: "_pRequest.idPaciente_"notificaion: "_numRows
      }
    }
  } Catch (err) {
    If (err.%ClassName(1)="common.err.exception") && ($$$ISERR(err.status)) {
        Set sc = err.status
    } Else {
        Set sc = $SYSTEM.Status.Error(err.Code,err.Name,err.Location,err.InnerException)
    }
  }
  
  If ($$$ISERR(sc)) {
      Set pResponse.exito = 0
      Set pResponse.error = $SYSTEM.Status.GetErrorText(sc)
  }
  Quit $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="cysnet.clinicaDental.notificaciones.msg.GenerarNotificacionRequest">
        <Method>GenerarNotificacion</Method>
    </MapItem>
</MapItems>
}

}
