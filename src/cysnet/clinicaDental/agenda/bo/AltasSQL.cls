Class cysnet.clinicaDental.agenda.bo.AltasSQL Extends Ens.BusinessOperation
{

/// dar de alta  el paciente
Method AltaPaciente(pRequest As cysnet.clinicaDental.agenda.msg.AltaPacienteRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.AltaPacienteResponse) As %Status
{
  #dim sc As %Status = $$$OK
  Set pResponse = ##class(cysnet.clinicaDental.agenda.msg.AltaPacienteResponse).%New()
  Set pResponse.exito = 1
  
  Try {
    &sql(INSERT INTO cysnet_clinicaDental_agenda_data.Altas (idCita,fechaAlta,indEnviada)
    VALUES (:pRequest.idCita,now(),0))
    If (SQLCODE = 0) {
      Set pResponse.mensaje = "Se da de alta para la cita :"_pRequest.idCita_" altaID:"_%ROWID
    
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
    <MapItem MessageType="cysnet.clinicaDental.agenda.msg.AltaPacienteRequest">
        <Method>AltaPaciente</Method>
    </MapItem>
</MapItems>
}

}
