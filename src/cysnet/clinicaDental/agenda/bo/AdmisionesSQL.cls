Class cysnet.clinicaDental.agenda.bo.AdmisionesSQL Extends Ens.BusinessOperation
{

Method ExisteAdmision(pRequest As cysnet.clinicaDental.agenda.msg.ExisteAdmisionRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.ExisteAdmisionResponse) As %Status
{
  #dim sc As %Status = $$$OK
  #dim stm As %SQL.Statement
  #dim rs As %SQL.StatementResult

  Set pResponse = ##class(cysnet.clinicaDental.agenda.msg.ExisteAdmisionResponse).%New()
  Set pResponse.exito = 1
  Set pResponse.existe = 0

  Try {
    Set stm = ##class(%SQL.Statement).%New()
    Do stm.%Prepare("SELECT ID FROM cysnet_clinicaDental_agenda_data.Admisiones WHERE idCita = ?")

    Set rs = stm.%Execute(pRequest.idCita)
    If ($$$ISOK(sc)) {
      If (rs.%Next(.sc)) {
        Quit:$$$ISERR(sc)
        Set pResponse.existe = 1
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
  Return $$$OK
}

/// admitir el paciente
Method AdmitirPaciente(pRequest As cysnet.clinicaDental.agenda.msg.AdmitirPacienteRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.AdmitirPacienteResponse) As %Status
{
  #dim sc As %Status = $$$OK

  Set pResponse = ##class(cysnet.clinicaDental.agenda.msg.AdmitirPacienteResponse).%New()
  Set pResponse.exito = 1
  Try {
      &sql(INSERT INTO cysnet_clinicaDental_agenda_data.Admisiones (idCita,fechaAdmision,indEnviada)
      VALUES (:pRequest.idCita,now(),0))
      If (SQLCODE = 0) {
        Set pResponse.mensaje = "Se crea admision "_%ROWID
      } Else {
        set pResponse.exito = 0
        set pResponse.error = $System.SQL.Functions.SQLCODE(SQLCODE)
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
  Return $$$OK
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
</MapItems>
}

}
