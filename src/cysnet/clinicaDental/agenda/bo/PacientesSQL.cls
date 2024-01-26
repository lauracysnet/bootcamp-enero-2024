Class cysnet.clinicaDental.agenda.bo.PacientesSQL Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method BuscarPacientePorEmail(pRequest As cysnet.clinicaDental.agenda.msg.BuscarPacientePorEmailRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.BuscarPacientePorEmailResponse) As %Status
{
  #dim sc As %Status = $$$OK
  #dim rs As EnsLib.SQL.GatewayResultSet

  Set pResponse = ##class(cysnet.clinicaDental.agenda.msg.BuscarPacientePorEmailResponse).%New()
  Set pResponse.exito = 1
  
  Try {
    set rs = ##class(EnsLib.SQL.GatewayResultSet).%New()
    set sql = "SELECT idPaciente,nombre,apellidos,email,baja,permiteNotificaciones FROM Paciente WHERE email = ? "

    set sc = ..Adapter.ExecuteQuery(.rs, sql, pRequest.email)
    if ($$$ISOK(sc)) {
      If (rs.%Next(.sc)) {
        Quit:$$$ISERR(sc)
        Set pResponse.ID = rs.Get("idPaciente")
        Set pResponse.nombre = rs.Get("nombre")
        Set pResponse.apellidos = rs.Get("apellidos")
        Set pResponse.email = rs.Get("email")
        Set pResponse.baja = rs.Get("baja")
        Set pResponse.permiteNotificaciones = rs.Get("permiteNotificaciones")
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
  Return $$$OK
}

/// Crear un paciente nuevo
Method NuevoPaciente(pRequest As cysnet.clinicaDental.agenda.msg.NuevoPacienteRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.NuevoPacienteResponse) As %Status
{
  #dim sc As %Status = $$$OK
  #dim numRows As %Integer = 0

  Set pResponse = ##class(cysnet.clinicaDental.agenda.msg.NuevoPacienteResponse).%New()
  Set pResponse.exito = 1
  
  Try {
    set sql = "INSERT INTO Paciente (Nombre,Apellidos,Email,PermiteNotificaciones,Baja) VALUES (?,?,?,?,?)"
    set sc = ..Adapter.ExecuteUpdate(.numRows, sql, pRequest.nombre, pRequest.apellidos, pRequest.email, 1, 0)
    if ($$$ISOK(sc)) {
      if (numRows = 0) {
        Set pResponse.exito = 0
        Set pResponse.error = "No se ha guardado el paciente"
      }else{
        Set pResponse.mensaje = "Se crea"
      }
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

/// dar de baja pacientep  por id
Method BajaPaciente(pRequest As cysnet.clinicaDental.agenda.msg.BajaPacienteRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.BajaPacienteResponse) As %Status
{
  #dim sc As %Status = $$$OK
   #dim numRows As %Integer = 0
 Set pResponse = ##class(cysnet.clinicaDental.agenda.msg.BajaPacienteResponse).%New()
  Set pResponse.mensaje = "Se da de baja al ID:"_pRequest.ID
  Set pResponse.exito = 1
  Try{
    set sql = "UPDATE Paciente SET baja = 1 where idPaciente = ?"
    set sc = ..Adapter.ExecuteUpdate(.numRows, sql, pRequest.ID)
    if ($$$ISOK(sc)) {
      if (numRows = 0) {
        Set pResponse.exito = 0
        Set pResponse.error = "No se ha modificado el paciente"
      }else{
        Set pResponse.mensaje = "Se modifico"
      }
    }
  }Catch(err){
    If (err.%ClassName(1)="common.err.exception") && ($$$ISERR(err.status)) {
      Set sc = err.status
    } Else {
      Set sc = $System.Status.Error(err.Code, err.Name, err.Location, err.InnerException)
    }
  }
    Return $$$OK
}

/// actualizar el paciente
Method ModificarPaciente(pRequest As cysnet.clinicaDental.agenda.msg.ModificarPacienteRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.ModificarPacienteResponse) As %Status
{
  #dim sc As %Status = $$$OK
  #dim rs As EnsLib.SQL.GatewayResultSet
  #dim numRows As %Integer = 0
  
  Set pResponse = ##class(cysnet.clinicaDental.agenda.msg.ModificarPacienteResponse).%New()
  set pResponse.exito = 1

  Try{
    set rs = ##class(EnsLib.SQL.GatewayResultSet).%New()
    set sql = "SELECT idPaciente FROM Paciente WHERE email = ?  and idPaciente <> ?"
    set sc = ..Adapter.ExecuteQuery(.rs, sql, pRequest.email, pRequest.ID)
    if ($$$ISOK(sc)) {
      If (rs.%Next(.sc)) {
        Set pResponse.mensaje = "El email ya esta en uso"
      } Else {
        Set pResponse.mensaje = "Se actualiza ID:"_pRequest.ID
        set sql = "UPDATE Paciente  SET Nombre = ?, Apellidos = ?, Email = ?, PermiteNotificaciones = ? where idPaciente = ?"
        set sc = ..Adapter.ExecuteUpdate(.numRows, sql, pRequest.nombre, pRequest.apellidos, pRequest.email, pRequest.permiteNotificaciones, pRequest.ID)
        
        if ($$$ISOK(sc)) {
           if (numRows = 0) {
            Set pResponse.exito = 0
            Set pResponse.error = "No se ha modificado el paciente" 
          }else{
            Set pResponse.error = "Se ha modificado el paciente"  
          }
        } 
      }
    }
  }Catch(err){
    if (err.%ClassName(1)="common.err.exception") && ($$$ISERR(err.status)) {
      set sc = err.status
    } else {
        set sc = $System.Status.Error(err.Code,err.Name,err.Location,err.InnerException)
    }
  }

  if ($$$ISERR(sc)) {
      set pResponse.exito = 0
      set pResponse.error = $System.Status.GetErrorText(sc)
  }
  Return $$$OK
}

/// Método que obtiene los datos de un paciente a partir de su ID
Method ListarPacientes(pRequest As cysnet.clinicaDental.agenda.msg.ListarPacientesRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.ListarPacientesResponse) As %Status
{
    #dim sc As %Status = $$$OK
    #dim rs As EnsLib.SQL.GatewayResultSet

    Set pResponse = ##class(cysnet.clinicaDental.agenda.msg.ListarPacientesResponse).%New()
    set pResponse.exito = 1
    Try{
      Set pacientes = ##class(%ListOfObjects).%New()
      set rs = ##class(EnsLib.SQL.GatewayResultSet).%New()

      If (pRequest.mostrarBajas = 1){
        Set where = ""
      }
        Else{
        Set where = " WHERE  baja = 0"
      }

      set sql = "SELECT idPaciente, nombre, apellidos, email, baja, permiteNotificaciones FROM Paciente "_where
      set sc = ..Adapter.ExecuteQuery(.rs, sql)
      if ($$$ISOK(sc)) {
        While rs.%Next(.sc) {
            Set paciente = ##class(cysnet.clinicaDental.agenda.msg.struct.Paciente).%New()
           // Set paciente.idPaciente = rs.ID
            Set paciente.nombre = rs.Get("nombre")
            Set paciente.apellidos = rs.Get("apellidos")
            Set paciente.email = rs.Get("email")
            Set paciente.baja = rs.Get("baja")
            Set paciente.permiteNotificaciones = rs.Get("permiteNotificaciones")
            do pResponse.pacientes.Insert(paciente)
            Kill paciente
        }
      }
    }Catch(err){
      If (err.%ClassName(1)="common.err.exception") && ($$$ISERR(err.status)) {
        Set sc = err.status
      } Else {
        Set sc = $System.Status.Error(err.Code,err.Name,err.Location,err.InnerException)
      }
    }
    
    if ($$$ISERR(sc)) {
        set pResponse.exito = 0
        set pResponse.error = $System.Status.GetErrorText(sc)
    }
    

    Quit $$$OK
}

/// Método que obtiene los datos de un paciente a partir de su ID
Method BuscarPacientePorID(pRequest As cysnet.clinicaDental.agenda.msg.BuscarPacientePorIDRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.BuscarPacientePorIDResponse) As %Status
{
    #dim sc As %Status = $$$OK
    #dim rs As EnsLib.SQL.GatewayResultSet

    Set pResponse = ##class(cysnet.clinicaDental.agenda.msg.BuscarPacientePorIDResponse).%New()
    Set pResponse.exito = 1
    Try{
      set rs = ##class(EnsLib.SQL.GatewayResultSet).%New()
      set sql = "SELECT idPaciente, nombre, apellidos, email, baja, permiteNotificaciones FROM Paciente WHERE idPaciente = ?"
      set sc = ..Adapter.ExecuteQuery(.rs, sql, pRequest.idPaciente)
      If ($$$ISOK(sc)) {
        If (rs.%Next(.sc)) {
            Quit:$$$ISERR(sc)
            Set pResponse.idPaciente = rs.Get("idPaciente")
            Set pResponse.nombre = rs.Get("nombre")
            Set pResponse.apellidos = rs.Get("apellidos")
            Set pResponse.email = rs.Get("email")
            Set pResponse.baja = rs.Get("baja")
            Set pResponse.permiteNotificaciones = rs.Get("permiteNotificaciones")
        } Else {
            Set pResponse.mensaje = "No existen datos para ese identificador ("_pRequest.idPaciente_")"
        }
      }
    }Catch(err){
      If (err.%ClassName(1)="common.err.exception") && ($$$ISERR(err.status)) {
            set sc = err.status
        } else {
            set sc = $System.Status.Error(err.Code,err.Name,err.Location,err.InnerException)
      }
    }

    if ($$$ISERR(sc)) {
        set pResponse.exito = 0
        set pResponse.error = $System.Status.GetErrorText(sc)
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
