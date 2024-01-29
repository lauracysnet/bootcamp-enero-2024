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
<context>
<property name='cita' type='cysnet.clinicaDental.agenda.msg.TraerCitaResponse' instantiate='0' />
<property name='paciente' type='cysnet.clinicaDental.agenda.msg.BuscarPacientePorIDResponse' instantiate='0' />
<property name='alta' type='cysnet.clinicaDental.agenda.msg.BuscarAltaPacientePorCitaResponse' instantiate='0' />
<property name='admision' type='cysnet.clinicaDental.agenda.msg.BuscarAdmisionPorCitaResponse' instantiate='0' />
<property name='infoAltaP' type='cysnet.clinicaDental.agenda.msg.struct.InfoAltaPaciente' instantiate='0' />
<property name='mensajeHL7' type='EnsLib.HL7.Message' instantiate='0' />
</context>
<sequence xend='200' yend='1700' >
<call name='Obtener Admision' target='AdmisionesSQL' async='0' xpos='200' ypos='250' >
<request type='cysnet.clinicaDental.agenda.msg.BuscarAdmisionPorCitaRequest' >
<assign property="callrequest.idCita" value="request.idCita" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.BuscarAdmisionPorCitaResponse' >
<assign property="context.admision" value="callresponse" action="set" />
</response>
</call>
<call name='Obtener Cita' target='CitasSQL' async='0' xpos='200' ypos='350' >
<request type='cysnet.clinicaDental.agenda.msg.TraerCitaRequest' >
<assign property="callrequest.idCita" value="request.idCita" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.TraerCitaResponse' >
<assign property="context.cita" value="callresponse" action="set" />
</response>
</call>
<call name='Obtener Paciente' target='PacientesSQL' async='0' xpos='200' ypos='450' >
<request type='cysnet.clinicaDental.agenda.msg.BuscarPacientePorIDRequest' >
<assign property="callrequest.idPaciente" value="context.cita.idPaciente" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.BuscarPacientePorIDResponse' >
<assign property="context.paciente" value="callresponse" action="set" />
</response>
</call>
<assign name="Asignar idPaciente" property="context.infoAltaP.idPaciente" value="context.paciente.idPaciente" action="set" xpos='200' ypos='550' />
<assign name="Asignar Nombre" property="context.infoAltaP.nombre" value="context.paciente.nombre" action="set" xpos='200' ypos='650' />
<assign name="Asignar Apellido" property="context.infoAltaP.apellido" value="context.paciente.apellidos" action="set" xpos='200' ypos='750' />
<assign name="Asignar idAdmision" property="context.infoAltaP.idAdmision" value="context.admision.idAdmision" action="set" xpos='200' ypos='850' />
<switch name='selecionar mensaje' xpos='200' ypos='950' xend='200' yend='1600' >
<case condition='request.%ClassName() = "CancelarCitaResponse"' name='CancelarCita' >
<call name='CancelarCita' target='CitasSQL' async='0' xpos='335' ypos='1100' >
<request type='cysnet.clinicaDental.agenda.msg.CancelarCitaRequest' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.CancelarCitaResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</case>
<case condition='request.%ClassName() = "ModificarCitaResponse"' name='ModificarCita' >
<call name='ModificarCita' target='CitasSQL' async='0' xpos='605' ypos='1100' >
<request type='cysnet.clinicaDental.agenda.msg.ModificarCitaRequest' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.ModificarCitaResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</case>
<case condition='request.%ClassName() = "ListarCitasResponse"' name='ListarCitas' >
<call name='ListarCitas' target='CitasSQL' async='0' xpos='875' ypos='1100' >
<request type='cysnet.clinicaDental.agenda.msg.ListarCitasRequest' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.ListarCitasResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</case>
<case condition='request.%ClassName() = "AltaPacienteRequest"' name='Alta Pacientes' >
<call name='Obtener Alta' target='AltasSQL' async='0' xpos='1145' ypos='1100' >
<request type='cysnet.clinicaDental.agenda.msg.BuscarAltaPacientePorCitaRequest' >
<assign property="callrequest.idCita" value="request.idCita" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.BuscarAltaPacientePorCitaResponse' >
<assign property="context.alta" value="callresponse" action="set" />
</response>
</call>
<assign name="Asignar fechaAdmision" property="context.infoAltaP.fechaAdmision" value="context.admision.fechaAdmision" action="set" xpos='1145' ypos='1200' />
<assign name="Asignar fechaAlta" property="context.infoAltaP.fechaAlta" value="context.alta.fechaAlta" action="set" xpos='1145' ypos='1300' />
<transform name='Transformar' class='cysnet.clinicaDental.agenda.dtl.InfoAltaPacienteToADTA03' source='context.infoAltaP' target='context.mensajeHL7' xpos='1145' ypos='1400' />
<call name='Enviar HL7' target='OutFileHL7' async='0' xpos='1145' ypos='1500' >
<request type='EnsLib.HL7.Message' >
<assign property="callrequest" value="context.mensajeHL7" action="set" />
</request>
<response type='EnsLib.HL7.Message' />
</call>
</case>
<default name='default' />
</switch>
</sequence>
</process>
}

}
