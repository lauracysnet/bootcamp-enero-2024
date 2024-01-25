Class cysnet.clinicaDental.agenda.bo.PacientesSQL Extends Ens.BusinessOperation
{

Method BuscarPacientePorEmail(pRequest As cysnet.clinicaDental.agenda.msg.BuscarPacientePorEmailRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.BuscarPacientePorEmailResponse) As %Status
{
  #dim sc As %Status = $$$OK
  Set pResponse = ##class(cysnet.clinicaDental.agenda.msg.BuscarPacientePorEmailResponse).%New()
  Set pResponse.exito = 1
  
  Try {
    #dim stm As %SQL.Statement
    #dim rs As %SQL.StatementResult
    Set stm = ##class(%SQL.Statement).%New()
    Do stm.%Prepare("SELECT ID,nombre,apellidos,email,baja,permiteNotificaciones FROM cysnet_clinicaDental_agenda_data.Pacientes WHERE email = ? ")

    Set rs = stm.%Execute(pRequest.email)
    If (rs.%Next()) {
      Set pResponse.ID = rs.ID
      Set pResponse.nombre = rs.nombre
      Set pResponse.apellidos = rs.apellidos
      Set pResponse.email = rs.email
      Set pResponse.baja = rs.baja
      Set pResponse.permiteNotificaciones = rs.permiteNotificaciones
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
  Return sc
}

/// Crear un paciente nuevo
Method NuevoPaciente(pRequest As cysnet.clinicaDental.agenda.msg.NuevoPacienteRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.NuevoPacienteResponse) As %Status
{
  #dim sc As %Status = $$$OK
  set pResponse = ##class(cysnet.clinicaDental.agenda.msg.NuevoPacienteResponse).%New()
  set pResponse.exito = 1
  
  try {
    &sql(INSERT INTO cysnet_clinicaDental_agenda_data.Pacientes (apellidos,baja,email,nombre,permiteNotificaciones)
    VALUES (:pRequest.apellidos,0,:pRequest.email,:pRequest.nombre,1))
    If (SQLCODE = 0) {
      Set pResponse.idPaciente = %ROWID
      Set pResponse.mensaje = "Se crea"
    } Else {
      Set pResponse.exito = 0
      Set pResponse.error = $System.SQL.Functions.SQLCODE(SQLCODE)
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
  Return sc
}

/// dar de baja pacientep  por id
Method BajaPaciente(pRequest As cysnet.clinicaDental.agenda.msg.BajaPacienteRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.BajaPacienteResponse) As %Status
{
  Set pResponse = ##class(cysnet.clinicaDental.agenda.msg.BajaPacienteResponse).%New()
  Set pResponse.mensaje = "Se da de baja al ID:"_pRequest.ID
  Set pResponse.exito = 1

  &sql(UPDATE cysnet_clinicaDental_agenda_data.Pacientes  SET baja = 1 where id = :pRequest.ID)
  Return $$$OK
}

/// actualizar el paciente
Method ModificarPaciente(pRequest As cysnet.clinicaDental.agenda.msg.ModificarPacienteRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.ModificarPacienteResponse) As %Status
{
  #dim stm As %SQL.Statement
  #dim rs As %SQL.StatementResult
  
  Set pResponse = ##class(cysnet.clinicaDental.agenda.msg.ModificarPacienteResponse).%New()
  
  Set stm = ##class(%SQL.Statement).%New()
  Do stm.%Prepare("SELECT ID FROM cysnet_clinicaDental_agenda_data.Pacientes WHERE email = ?  and ID <> ?")

  Set rs = stm.%Execute(pRequest.email,pRequest.ID)
  If (rs.%Next()) {
    Set pResponse.mensaje = "El email ya esta en uso"
  } Else {
    Set pResponse.mensaje = "Se actualiza ID:"_pRequest.ID
    
    &sql(UPDATE cysnet_clinicaDental_agenda_data.Pacientes  SET  apellidos = :pRequest.apellidos, email = :pRequest.email, nombre = :pRequest.nombre, permiteNotificaciones = :pRequest.permiteNotificaciones where id = :pRequest.ID)
  }
  Return $$$OK
}

/// Método que obtiene los datos de un paciente a partir de su ID
Method ListarPacientes(pRequest As cysnet.clinicaDental.agenda.msg.ListarPacientesRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.ListarPacientesResponse) As %Status
{
    Set pResponse = ##class(cysnet.clinicaDental.agenda.msg.ListarPacientesResponse).%New()

    Set pacientes = ##class(%ListOfObjects).%New()

    Set stm = ##class(%SQL.Statement).%New()

    If (pRequest.mostrarBajas = 1){
      Set where = ""
    }
      Else{
      Set where = " WHERE  baja = 0"
    }

    Do stm.%Prepare("SELECT ID, nombre, apellidos, email, baja, permiteNotificaciones FROM cysnet_clinicaDental_agenda_data.Pacientes "_where)

    Set rs = stm.%Execute()

    While rs.%Next() {
        Set paciente = ##class(cysnet.clinicaDental.agenda.data.Pacientes).%New()
        // Set paciente.idPaciente = rs.ID
        Set paciente.nombre = rs.nombre
        Set paciente.apellidos = rs.apellidos
        Set paciente.email = rs.email
        Set paciente.baja = rs.baja
        Set paciente.permiteNotificaciones = rs.permiteNotificaciones
        Do pacientes.Insert(paciente)
        Kill paciente
    }
    $$$LOGINFO(pacientes)

    Set pResponse.pacientes = pacientes

    Quit $$$OK
}

/// Método que obtiene los datos de un paciente a partir de su ID
Method BuscarPacientePorID(pRequest As cysnet.clinicaDental.agenda.msg.BuscarPacientePorIDRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.BuscarPacientePorIDResponse) As %Status
{
    Set pResponse = ##class(cysnet.clinicaDental.agenda.msg.BuscarPacientePorIDResponse).%New()

    $$$LOGINFO(pRequest.idPaciente)

    Set stm = ##class(%SQL.Statement).%New()
    Do stm.%Prepare("SELECT ID, nombre, apellidos, email, baja, permiteNotificaciones FROM cysnet_clinicaDental_agenda_data.Pacientes WHERE ID = "_pRequest.idPaciente)

    Set rs = stm.%Execute()

    If (rs.%Next()) {
        Set pResponse.idPaciente = rs.ID
        Set pResponse.nombre = rs.nombre
        Set pResponse.apellidos = rs.apellidos
        Set pResponse.email = rs.email
        Set pResponse.baja = rs.baja
        Set pResponse.permiteNotificaciones = rs.permiteNotificaciones
    } Else {
        Set pResponse.mensaje = "No existen datos para ese identificador ("_pRequest.idPaciente_")"
    }
    
    Quit $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="cysnet.clinicaDental.agenda.msg.NuevoPacienteRequest">
        <Method>NuevoPaciente</Method>
    </MapItem>
    <MapItem MessageType="cysnet.clinicaDental.agenda.msg.BajaPacienteRequest">
        <Method>BajaPaciente</Method>
    </MapItem>
    <MapItem MessageType="cysnet.clinicaDental.agenda.msg.ModificarPacienteRequest">
        <Method>ModificarPaciente</Method>
    </MapItem>
    <MapItem MessageType="cysnet.clinicaDental.agenda.msg.ListarPacientesRequest">
        <Method>ListarPacientes</Method>
    </MapItem>
    <MapItem MessageType="cysnet.clinicaDental.agenda.msg.BuscarPacientePorIDRequest">
        <Method>BuscarPacientePorID</Method>
    </MapItem>
    <MapItem MessageType="cysnet.clinicaDental.agenda.msg.BuscarPacientePorEmailRequest">
        <Method>BuscarPacientePorEmail</Method>
    </MapItem>

</MapItems>
}

}
