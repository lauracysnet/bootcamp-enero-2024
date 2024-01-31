Class cysnet.clinicaDental.agenda.bo.AdmisionesSQL Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method ExisteAdmision(pRequest As cysnet.clinicaDental.agenda.msg.ExisteAdmisionRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.ExisteAdmisionResponse) As %Status
{
  #dim sc As %Status = $$$OK
  #dim rs As EnsLib.SQL.GatewayResultSet

  Set pResponse = ##class(cysnet.clinicaDental.agenda.msg.ExisteAdmisionResponse).%New()
  Set pResponse.exito = 1

  Try {
    Set rs = ##class(EnsLib.SQL.GatewayResultSet).%New()
    Set sql = "SELECT IdAdmision FROM ClinicaDental.Admision WHERE idCita = ?"
    Set sc = ..Adapter.ExecuteQuery(.rs, sql, pRequest.idCita)
    
    If ($$$ISOK(sc)) {
      If (rs.Next(.sc)) {
          Quit:$$$ISERR(sc)
          Set pResponse.IdAdmision = rs.Get("IdAdmision")
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

/// admitir el paciente
Method AdmitirPaciente(pRequest As cysnet.clinicaDental.agenda.msg.AdmitirPacienteRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.AdmitirPacienteResponse) As %Status
{
  #dim sc As %Status = $$$OK

  Set pResponse = ##class(cysnet.clinicaDental.agenda.msg.AdmitirPacienteResponse).%New()
  Set pResponse.exito = 1
  Try {
    #dim numRows As %Integer = 0
    
    Set sql = "INSERT INTO ClinicaDental.Admision (idCita,fechaAdmision,indEnviada) VALUES (?,now(),0)"
    
    Set sc = ..Adapter.ExecuteUpdate(.numRows, sql, pRequest.idCita)
    If ($$$ISOK(sc)) {
       If (numRows = 0) {
         Set pResponse.exito = 0
         Set pResponse.error = ""
       }Else{
        ///Set newId = ..Adapter.%GetResult()
        Set pResponse.mensaje = "Se crea admision " ///_%newId
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

Method BuscarAdmisionPorCita(pRequest As cysnet.clinicaDental.agenda.msg.BuscarAdmisionPorCitaRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.BuscarAdmisionPorCitaResponse) As %Status
{
  #dim sc As %Status = $$$OK
  #dim rs As EnsLib.SQL.GatewayResultSet
  Set pResponse = ##class(cysnet.clinicaDental.agenda.msg.BuscarAdmisionPorCitaResponse).%New()
  Set pResponse.exito = 1
  
  Try {
    set rs = ##class(EnsLib.SQL.GatewayResultSet).%New()
    Set sql = "SELECT idAdmision, idCita,fechaAdmision FROM ClinicaDental.Admision WHERE idCita = ?"
    
    set sc = ..Adapter.ExecuteQuery(.rs, sql, pRequest.idCita)
    
    If ($$$ISOK(sc)) {
      If (rs.Next(.sc)) {
          Quit:$$$ISERR(sc)
          Set pResponse.idAdmision = rs.Get("idAdmision")
          Set pResponse.idCita = rs.Get("idCita")
          Set pResponse.fechaAdmision = rs.Get("fechaAdmision")
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
    <MapItem MessageType="cysnet.clinicaDental.agenda.msg.AdmitirPacienteRequest">
        <Method>AdmitirPaciente</Method>
    </MapItem>
    <MapItem MessageType="cysnet.clinicaDental.agenda.msg.ExisteAdmisionRequest">
        <Method>ExisteAdmision</Method>
    </MapItem>
    <MapItem MessageType="cysnet.clinicaDental.agenda.msg.BuscarAdmisionPorCitaRequest">
        <Method>BuscarAdmisionPorCita</Method>
    </MapItem>
</MapItems>
}

}
