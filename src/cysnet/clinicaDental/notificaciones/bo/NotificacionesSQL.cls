Class cysnet.clinicaDental.notificaciones.bo.NotificacionesSQL Extends Ens.BusinessOperation
{

Method GenerarNotificacion(pRequest As cysnet.clinicaDental.notificaciones.msg.GenerarNotificacionRequest, Output pResponse As cysnet.clinicaDental.notificaciones.msg.GenerarNotificacionResponse) As %Status
{
    #dim sc As %Status = $$$OK
  Set pResponse = ##class(cysnet.clinicaDental.notificaciones.msg.GenerarNotificacionResponse).%New()
  Set pResponse.exito = 1
    
  Try {
    &sql(INSERT INTO cysnet_clinicaDental_notificaciones_data.Notificaciones (idPaciente,asunto,mensaje,indEnviado) VALUES (:pRequest.idPaciente,:pRequest.asunto,:pRequest.mensaje,0))
    If (SQLCODE = 0) {
      Set pResponse.mensaje = "Se notifica paciente:"_pRequest.idPaciente_"notificaion:"_%ROWID
    } Else {
      Set pResponse.exito = 0
      Set pResponse.error = $SYSTEM.SQL.Functions.SQLCODE(SQLCODE)
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
