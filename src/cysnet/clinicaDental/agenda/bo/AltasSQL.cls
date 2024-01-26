Class cysnet.clinicaDental.agenda.bo.AltasSQL Extends Ens.BusinessOperation
{

/// dar de alta  el paciente
Method AltaPaciente(pRequest As cysnet.clinicaDental.agenda.msg.AltaPacienteRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.AltaPacienteResponse) As %Status
{
  #dim sc As %Status = $$$OK
  Set pResponse = ##class(cysnet.clinicaDental.agenda.msg.AltaPacienteResponse).%New()
  set pResponse.exito = 1
  
  try {
    &sql(INSERT INTO cysnet_clinicaDental_agenda_data.Altas (idCita,fechaAlta,indEnviada)
    VALUES (:pRequest.idCita,now(),0))
    If (SQLCODE = 0) {
      Set pResponse.mensaje = "Se da de alta para la cita :"_pRequest.idCita_" altaID:"_%ROWID
    
    } Else {
      set pResponse.exito = 0
      set pResponse.error = $System.SQL.Functions.SQLCODE(SQLCODE)
    }
  } catch (err) {
    If (err.%ClassName(1)="common.err.exception") && ($$$ISERR(err.status)) {
        Set sc = err.status
    } Else {
        Set sc = $SYSTEM.Status.Error(err.Code,err.Name,err.Location,err.InnerException)
    }
  }
  if ($$$ISERR(sc)) {
      Set pResponse.exito = 0
      Set pResponse.error = $SYSTEM.Status.GetErrorText(sc)
  }
  Return $$$OK
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
