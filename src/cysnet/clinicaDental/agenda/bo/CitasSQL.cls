Class cysnet.clinicaDental.agenda.bo.CitasSQL Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

/// Método para cancelar una cita
Method cancelarCita(pRequest As cysnet.clinicaDental.agenda.msg.CancelarCitaRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.CancelarCitaResponse) As %Status
{
  #dim sc As %Status = $$$OK
  #dim rs As EnsLib.SQL.GatewayResultSet
  #dim numRows As %Integer = 0

  Set pResponse = ##class(cysnet.clinicaDental.agenda.msg.CancelarCitaResponse).%New()
  Set pResponse.exito = 1
  Try {
    Set rs = ##class(EnsLib.SQL.GatewayResultSet).%New()
    Set sql = "SELECT IdCita FROM ClinicaDental.Cita WHERE IdCita = ?"
    Set sc = ..Adapter.ExecuteQuery(.rs, sql, pRequest.idCita)
    
    If ($$$ISOK(sc)) {
      If (rs.Next(.sc)) {
          Quit:$$$ISERR(sc)
          Set sql = "UPDATE ClinicaDental.Cita SET codEstado = 4 WHERE IdCita = ?"
          Set sc = ..Adapter.ExecuteUpdate(.numRows, sql,pRequest.idCita )
          If ($$$ISOK(sc)) {
            If (numRows = 0) {
              Set pResponse.exito = 0
              Set pResponse.error = ""
            }Else {
              Set pResponse.mensaje = "se cancela cita "_pRequest.idCita
            }
          }
      }Else {
        Set pResponse.exito = 0
        Set pResponse.mensaje = "No se encontró la cita"
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

Method altaCitas(pRequest As cysnet.clinicaDental.agenda.msg.AltaCitasRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.AltaCitasResponse) As %Status
{
    #dim sc As %Status = $$$OK
    #dim numRows As %Integer = 0
    Set pResponse = ##class(cysnet.clinicaDental.agenda.msg.AltaCitasResponse).%New()
    Set pResponse.exito = 1
    Try {
      Set sql = "INSERT INTO ClinicaDental.Cita (idPaciente, descCita, fechaCita, codEstado) VALUES (?,?,?,1)"
      Set sc = ..Adapter.ExecuteUpdate(.numRows, sql, pRequest.idPaciente, pRequest.descCita, pRequest.fechaCita)
      If ($$$ISOK(sc)) {
        If (numRows = 0) {
          Set pResponse.exito = 0
          Set pResponse.error = ""
        }Else {
          Set pResponse.mensaje = "se crea cita"
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

/// actualizar el paciente
Method ModificarCita(pRequest As cysnet.clinicaDental.agenda.msg.ModificarCitaRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.ModificarCitaResponse) As %Status
{
  #dim sc As %Status = $$$OK
  #dim numRows As %Integer = 0
  Set pResponse = ##class(cysnet.clinicaDental.agenda.msg.ModificarCitaResponse).%New()
  Set pResponse.exito = 1
  Try {
    Set sql = "UPDATE ClinicaDental.Cita  SET fechaCita = ? where IdCita = ?"
    Set sc = ..Adapter.ExecuteUpdate(.numRows, sql ,pRequest.fechaCita ,pRequest.ID)
    If ($$$ISOK(sc)) {
      If (numRows = 0) {
        Set pResponse.exito = 0
        Set pResponse.error = ""
      }Else {
        Set pResponse.mensaje = "Se actualiza ID:"_pRequest.ID
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

Method ListarCitas(pRequest As cysnet.clinicaDental.agenda.msg.ListarCitasRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.ListarCitasResponse) As %Status
{
    #dim sc As %Status = $$$OK
    Set pResponse = ##class(cysnet.clinicaDental.agenda.msg.ListarCitasResponse).%New()
    Set pResponse.exito = 1
    
    Try {
      Set pResponse.citas = ##class(%ListOfObjects).%New()

      #dim rs As EnsLib.SQL.GatewayResultSet
      Set rs = ##class(EnsLib.SQL.GatewayResultSet).%New()
      Set sql = "select IdCita, idPaciente, descCita, fechaCita, codEstado from ClinicaDental.Cita where idPaciente = ? "
      If ('pRequest.mostrarCanceladas){
        Set sql = sql_" AND codEstado <> 4"
      }
      Set sc = ..Adapter.ExecuteQuery(.rs, sql, pRequest.idPaciente)
      If ($$$ISOK(sc)) {
        While (rs.Next(.sc)) {
          Quit:$$$ISERR(sc)
          Set cita = ##class(cysnet.clinicaDental.agenda.msg.struct.infoCita).%New()
          Set cita.idCita = rs.Get("IdCita")
          Set cita.idPaciente = rs.Get("idPaciente")
          Set cita.descCita = rs.Get("descCita")
          Set cita.fechaCita = rs.Get("fechaCita")
          Set cita.codEstado = rs.Get("codEstado")
          Do pResponse.citas.Insert(cita)
          Kill cita
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
    <MapItem MessageType="cysnet.clinicaDental.agenda.msg.CancelarCitaRequest">
        <Method>cancelarCita</Method>
    </MapItem>
    <MapItem MessageType="cysnet.clinicaDental.agenda.msg.AltaCitasRequest">
        <Method>altaCitas</Method>
    </MapItem>
    <MapItem MessageType="cysnet.clinicaDental.agenda.msg.ModificarCitaRequest">
        <Method>ModificarCita</Method>
    </MapItem>
    <MapItem MessageType="cysnet.clinicaDental.agenda.msg.ListarCitasRequest">
        <Method>ListarCitas</Method>
    </MapItem>
</MapItems>
}

}
