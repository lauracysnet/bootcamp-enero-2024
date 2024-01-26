Class cysnet.clinicaDental.agenda.bo.AltasSQL Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

/// dar de alta  el paciente
Method AltaPaciente(pRequest As cysnet.clinicaDental.agenda.msg.AltaPacienteRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.AltaPacienteResponse) As %Status
{
  #dim sc As %Status = $$$OK
  Set pResponse = ##class(cysnet.clinicaDental.agenda.msg.AltaPacienteResponse).%New()
  Set pResponse.exito = 1
  
  Try {
    #dim numRows As %Integer = 0
    
    Set sql = "INSERT INTO ClinicaDental.Alta (idCita,fechaAlta,indEnviada) VALUES (?,now(),0)"
    
    Set sc = ..Adapter.ExecuteUpdate(.numRows, sql, pRequest.idCita)
    $$$LOGINFO(numRows)
    If ($$$ISOK(sc)) {
      If (numRows = 0) {
        Set pResponse.exito = 0
        Set pResponse.error = ""
      }Else{
        /// Set newId = ..Adapter.%GetInsertedId()
        Set pResponse.mensaje = "Se da de alta para la cita :"_pRequest.idCita ///_" altaID:"_newId
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
    <MapItem MessageType="cysnet.clinicaDental.agenda.msg.AltaPacienteRequest">
        <Method>AltaPaciente</Method>
    </MapItem>
</MapItems>
}

}
