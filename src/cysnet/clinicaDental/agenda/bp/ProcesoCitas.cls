/// 
Class cysnet.clinicaDental.agenda.bp.ProcesoCitas Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' height='2000' width='2000' >
<sequence xend='200' yend='600' >
<switch name='selecionar mensaje' xpos='200' ypos='250' xend='200' yend='500' >
<case condition='request.%ClassName() = "AltaCitasResponse"' name='Crear Cita' >
<call name='altaCitas' target='CitasSQL' async='0' xpos='335' ypos='400' >
<request type='cysnet.clinicaDental.agenda.msg.AltaCitasRequest' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.AltaCitasResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</case>
<case condition='request.%ClassName() = "CancelarCitaResponse"' name='CancelarCita' >
<call name='CancelarCita' target='CitasSQL' async='0' xpos='605' ypos='400' >
<request type='cysnet.clinicaDental.agenda.msg.CancelarCitaRequest' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.CancelarCitaResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</case>
<case condition='request.%ClassName() = "ModificarCitaResponse"' name='ModificarCita' >
<call name='ModificarCita' target='CitasSQL' async='0' xpos='875' ypos='400' >
<request type='cysnet.clinicaDental.agenda.msg.ModificarCitaRequest' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.ModificarCitaResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</case>
<case condition='request.%ClassName() = "ListarCitasResponse"' name='ListarCitas' >
<call name='ListarCitas' target='CitasSQL' async='0' xpos='1145' ypos='400' >
<request type='cysnet.clinicaDental.agenda.msg.ListarCitasRequest' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.ListarCitasResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</case>
<default name='default' />
</switch>
</sequence>
</process>
}

}
