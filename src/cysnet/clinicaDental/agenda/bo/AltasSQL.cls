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

Method BuscarAltaPacientePorCita(pRequest As cysnet.clinicaDental.agenda.msg.BuscarAltaPacientePorCitaRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.BuscarAltaPacientePorCitaResponse) As %Status
{
  #dim sc As %Status = $$$OK
   #dim rs As EnsLib.SQL.GatewayResultSet
  Set pResponse = ##class(cysnet.clinicaDental.agenda.msg.BuscarAltaPacientePorCitaResponse).%New()
  Set pResponse.exito = 1
  
  Try {
    set rs = ##class(EnsLib.SQL.GatewayResultSet).%New()
    Set sql = "SELECT idAlta, idCita,fechaAlta FROM ClinicaDental.Alta WHERE idCita = ?"
    
    set sc = ..Adapter.ExecuteQuery(.rs, sql, pRequest.idCita)
    
    If ($$$ISOK(sc)) {
      If (rs.Next(.sc)) {
          Quit:$$$ISERR(sc)
          Set pResponse.idAlta = rs.Get("idAlta")
          Set pResponse.idCita = rs.Get("idCita")
          Set pResponse.fechaAlta = rs.Get("fechaAlta")
      }else{
      }
    }
  }
  Catch err {
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
    <MapItem MessageType="cysnet.clinicaDental.agenda.msg.BuscarAltaPacientePorCitaRequest">
        <Method>BuscarAltaPacientePorCita</Method>
    </MapItem>
</MapItems>
}

}
