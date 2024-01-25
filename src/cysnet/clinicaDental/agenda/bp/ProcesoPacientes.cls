/// 
Class cysnet.clinicaDental.agenda.bp.ProcesoPacientes Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' height='2000' width='2690' >
<context>
<property name='BPEmailResponse' type='cysnet.clinicaDental.agenda.msg.BuscarPacientePorEmailResponse' instantiate='0' />
</context>
<sequence xend='200' yend='1300' >
<switch name='identifcar flujo' xpos='200' ypos='250' xend='200' yend='1200' >
<case condition='request.%ClassName() = "ModificarPacienteRequest"' name='modificar paciente' >
<call name='modificar paciente' target='PacientesSQL' async='0' xpos='335' ypos='400' >
<request type='cysnet.clinicaDental.agenda.msg.ModificarPacienteRequest' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.ModificarPacienteResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</case>
<case condition='request.%ClassName() = "ListarPacientesRequest"' name='Listar Pacientes' >
<call name='listar pacientes' target='PacientesSQL' async='0' xpos='605' ypos='400' >
<request type='cysnet.clinicaDental.agenda.msg.ListarPacientesRequest' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.ListarPacientesResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</case>
<case condition='request.%ClassName() = "BuscarPacientePorIDRequest"' name='BuscarPacientePorID' >
<call name='BuscarPacientePorID' target='PacientesSQL' async='0' xpos='875' ypos='400' >
<request type='cysnet.clinicaDental.agenda.msg.BuscarPacientePorIDRequest' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.BuscarPacientePorIDResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</case>
<case condition='request.%ClassName() = "BajaPacienteRequest"' name='Baja paciente' >
<call name='Baja paciente' target='PacientesSQL' async='0' xpos='1145' ypos='400' >
<request type='cysnet.clinicaDental.agenda.msg.BajaPacienteRequest' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.BajaPacienteResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
<if name='se da de baja' condition='response.exito = 1' xpos='1145' ypos='500' xend='1145' yend='750' >
<true>
<assign name="despedida" property="response.mensaje" value="&quot;Chao del sistema&quot;" action="set" xpos='1280' ypos='650' />
</true>
</if>
</case>
<case condition='request.%ClassName() = "NuevoPacienteRequest"' name='CrearPaciente' >
<call name='buscar pacienter paciente' target='PacientesSQL' async='0' xpos='1685' ypos='400' >
<request type='cysnet.clinicaDental.agenda.msg.BuscarPacientePorEmailRequest' >
<assign property="callrequest.email" value="request.email" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.BuscarPacientePorEmailResponse' >
<assign property="context.BPEmailResponse" value="callresponse" action="set" />
</response>
</call>
<if name='no se esta usando email' condition='&apos;context.BPEmailResponse.ID' xpos='1685' ypos='500' xend='1685' yend='1100' >
<true>
<call name='crear paciente' target='PacientesSQL' async='0' xpos='1955' ypos='650' >
<request type='cysnet.clinicaDental.agenda.msg.NuevoPacienteRequest' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.NuevoPacienteResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
<if name='se crea ?' condition='response.mensaje = "Se crea"' xpos='1955' ypos='750' xend='1955' yend='1000' >
<true>
<assign name="bienvenida" property="response.mensaje" value="&quot;Bienvenido al Sistema&quot;" action="set" xpos='2090' ypos='900' />
</true>
</if>
</true>
<false>
<assign name="set response" property="response" value="##class(cysnet.clinicaDental.agenda.msg.NuevoPacienteResponse).%New()" action="set" xpos='1685' ypos='650' />
<assign name="mesaje " property="response.mensaje" value="&quot;Email en uso&quot;" action="set" xpos='1685' ypos='750' />
</false>
</if>
</case>
<default name='default' />
</switch>
</sequence>
</process>
}

}
