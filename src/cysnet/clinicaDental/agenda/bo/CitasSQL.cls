Class cysnet.clinicaDental.agenda.bo.CitasSQL Extends Ens.BusinessOperation
{

/// Método para cancelar una cita
Method cancelarCita(pRequest As cysnet.clinicaDental.agenda.msg.CancelarCitaRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.CancelarCitaResponse) As %Status
{
  #dim sc As %Status = $$$OK
  Set pResponse = ##class(cysnet.clinicaDental.agenda.msg.CancelarCitaResponse).%New()
  Set pResponse.exito = 1
  Try {
    Set stm = ##class(%SQL.Statement).%New()
    Do stm.%Prepare("SELECT ID FROM cysnet_clinicaDental_agenda_data.Citas WHERE ID = "_pRequest.idCita)

    Set rs = stm.%Execute()

    If (rs.%Next(.sc)) {
        Quit:$$$ISERR(sc)
        &sql(UPDATE cysnet_clinicaDental_agenda_data.Citas SET codEstado = 4 WHERE ID = :pRequest.idCita)
    } Else {
        Set pResponse.mensaje = "No se encontró la cita"
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
    Set pResponse = ##class(cysnet.clinicaDental.agenda.msg.AltaCitasResponse).%New()
    Set pResponse.exito = 1
    Try {
      Set stm = ##class(%SQL.Statement).%New()
      Do stm.%Prepare("INSERT INTO cysnet_clinicaDental_agenda_data.Citas (idPaciente, descCita, fechaCita, codEstado) VALUES (?,?,?,?) ")
      Set rs = stm.%Execute(pRequest.idPaciente, pRequest.descCita, pRequest.fechaCita, 1)
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
  #dim stm As %SQL.Statement
  #dim rs As %SQL.StatementResult
  Set pResponse = ##class(cysnet.clinicaDental.agenda.msg.ModificarCitaResponse).%New()
  Set pResponse.exito = 1
  Try {
    &sql(UPDATE cysnet_clinicaDental_agenda_data.Citas SET fechaCita = :pRequest.fechaCita where id = :pRequest.ID)
    If (SQLCODE = 0) {
      Set pResponse.mensaje = "Se actualiza ID:"_pRequest.ID
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

Method ListarCitas(pRequest As cysnet.clinicaDental.agenda.msg.ListarCitasRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.ListarCitasResponse) As %Status
{
    #dim sc As %Status = $$$OK
    Set pResponse = ##class(cysnet.clinicaDental.agenda.msg.ListarCitasResponse).%New()
    Set pResponse.exito = 1
    
    Try {
      Set pResponse.citas = ##class(%ListOfObjects).%New()

      Set stm = ##class(%SQL.Statement).%New()

      If (pRequest.mostrarCanceladas = 1){
        Set where = " AND codEstado <> 4"
      }
        Else{
        Set where = ""
      }
      Do stm.%Prepare("select idPaciente, descCita, fechaCita, codEstado from cysnet_clinicaDental_agenda_data.Citas  where idPaciente  = ? "_where)

      Set rs = stm.%Execute(pRequest.idPaciente)

      While rs.%Next(.sc) {
        Quit:$$$ISERR(sc)
        Set cita = ##class(cysnet.clinicaDental.agenda.data.Citas).%New()
        // Set paciente.idPaciente = rs.ID
        Set cita.idPaciente = rs.idPaciente
        Set cita.descCita = rs.descCita
        Set cita.fechaCita = rs.fechaCita
        Set cita.codEstado = rs.codEstado
        Do pResponse.citas.Insert(cita)
        Kill cita
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
