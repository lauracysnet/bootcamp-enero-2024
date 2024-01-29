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
<process language='objectscript' request='Ens.Request' response='Ens.Response' height='3350' width='2150' >
<context>
<property name='nombreClase' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='250' />
</parameters>
</property>
<property name='objReq' type='Ens.Request' instantiate='0' />
<property name='resultadoRegla' type='%Boolean' initialexpression='0' instantiate='0' />
<property name='obtenerCita' type='%Boolean' initialexpression='0' instantiate='0' />
<property name='obtenerPaciente' type='%Boolean' initialexpression='0' instantiate='0' />
<property name='obtenerAdmision' type='%Boolean' initialexpression='0' instantiate='0' />
<property name='idPaciente' type='%Integer' initialexpression='0' instantiate='0' />
<property name='idCita' type='%Integer' instantiate='0' />
<property name='cita' type='cysnet.clinicaDental.agenda.msg.TraerCitaResponse' instantiate='0' />
<property name='paciente' type='cysnet.clinicaDental.agenda.msg.BuscarPacientePorIDResponse' instantiate='0' />
<property name='alta' type='cysnet.clinicaDental.agenda.msg.BuscarAltaPacientePorCitaResponse' instantiate='0' />
<property name='admision' type='cysnet.clinicaDental.agenda.msg.BuscarAdmisionPorCitaResponse' instantiate='0' />
<property name='infoAltaP' type='cysnet.clinicaDental.agenda.msg.struct.InfoAltaPaciente' instantiate='0' />
<property name='mensajeHL7' type='EnsLib.HL7.Message' instantiate='0' />
</context>
<sequence xend='200' yend='3100' >
<assign name="Asinar Request" property="context.objReq" value="request" action="set" xpos='200' ypos='250' />
<assign name="Asinar nombre de la clase" property="context.nombreClase" value="request.%ClassName()" action="set" xpos='200' ypos='350' />
<rule name='Validar Datos' rule='cysnet.clinicaDental.agenda.rules.CheckDatosProcesosCitas'  resultLocation='context.resultadoRegla' ruleContext='context' xpos='200' ypos='450' >
</rule>
<if name='Datos Correctos' condition='context.resultadoRegla = 1' xpos='200' ypos='550' xend='200' yend='3000' >
<true>
<if name='obtener Admision' condition='context.obtenerAdmision = 1' xpos='335' ypos='700' xend='335' yend='1050' >
<true>
<call name='Obtener Admision' target='AdmisionesSQL' async='0' xpos='470' ypos='850' >
<request type='cysnet.clinicaDental.agenda.msg.BuscarAdmisionPorCitaRequest' >
<assign property="callrequest.idCita" value="request.idCita" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.BuscarAdmisionPorCitaResponse' >
<assign property="context.admision" value="callresponse" action="set" />
</response>
</call>
<assign name="Asignar idAdmision" property="context.infoAltaP.idAdmision" value="context.admision.idAdmision" action="set" xpos='470' ypos='950' />
</true>
</if>
<if name='obtenerCita' condition='context.obtenerCita = 1' xpos='335' ypos='1150' xend='335' yend='1500' >
<true>
<call name='Obtener Cita' target='CitasSQL' async='0' xpos='470' ypos='1300' >
<request type='cysnet.clinicaDental.agenda.msg.TraerCitaRequest' >
<assign property="callrequest.idCita" value="context.idCita" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.TraerCitaResponse' >
<assign property="context.cita" value="callresponse" action="set" />
</response>
</call>
<assign name="Asignar idPaciente" property="context.idPaciente" value="context.cita.idPaciente" action="set" xpos='470' ypos='1400' />
</true>
</if>
<if name='obtenerPaciente ' condition='context.obtenerPaciente = 1' xpos='335' ypos='1600' xend='335' yend='2150' >
<true>
<call name='Obtener Paciente' target='PacientesSQL' async='0' xpos='470' ypos='1750' >
<request type='cysnet.clinicaDental.agenda.msg.BuscarPacientePorIDRequest' >
<assign property="callrequest.idPaciente" value="context.idPaciente" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.BuscarPacientePorIDResponse' >
<assign property="context.paciente" value="callresponse" action="set" />
</response>
</call>
<assign name="Asignar idPaciente" property="context.infoAltaP.idPaciente" value="context.paciente.idPaciente" action="set" xpos='470' ypos='1850' />
<assign name="Asignar Nombre" property="context.infoAltaP.nombre" value="context.paciente.nombre" action="set" xpos='470' ypos='1950' />
<assign name="Asignar Apellido" property="context.infoAltaP.apellido" value="context.paciente.apellidos" action="set" xpos='470' ypos='2050' />
</true>
</if>
<switch name='selecionar mensaje' xpos='335' ypos='2250' xend='335' yend='2900' >
<case condition='request.%ClassName() = "AltaCitasRequest"' name='AltaCitas' >
<call name='AltaCitas' target='CitasSQL' async='0' xpos='470' ypos='2400' >
<request type='cysnet.clinicaDental.agenda.msg.AltaCitasRequest' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.AltaCitasResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</case>
<case condition='request.%ClassName() = "CancelarCitaRequest"' name='CancelarCita' >
<call name='CancelarCita' target='CitasSQL' async='0' xpos='740' ypos='2400' >
<request type='cysnet.clinicaDental.agenda.msg.CancelarCitaRequest' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.CancelarCitaResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</case>
<case condition='request.%ClassName() = "ModificarCitaRequest"' name='ModificarCita' >
<call name='ModificarCita' target='CitasSQL' async='0' xpos='1010' ypos='2400' >
<request type='cysnet.clinicaDental.agenda.msg.ModificarCitaRequest' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.ModificarCitaResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</case>
<case condition='request.%ClassName() = "ListarCitasRequest"' name='ListarCitas' >
<call name='ListarCitas' target='CitasSQL' async='0' xpos='1280' ypos='2400' >
<request type='cysnet.clinicaDental.agenda.msg.ListarCitasRequest' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.ListarCitasResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</case>
<case condition='request.%ClassName() = "AltaPacienteRequest"' name='Alta Pacientes' >
<call name='Obtener Alta' target='AltasSQL' async='0' xpos='1550' ypos='2400' >
<request type='cysnet.clinicaDental.agenda.msg.BuscarAltaPacientePorCitaRequest' >
<assign property="callrequest.idCita" value="request.idCita" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.BuscarAltaPacientePorCitaResponse' >
<assign property="context.alta" value="callresponse" action="set" />
</response>
</call>
<assign name="Asignar fechaAdmision" property="context.infoAltaP.fechaAdmision" value="context.admision.fechaAdmision" action="set" xpos='1550' ypos='2500' />
<assign name="Asignar fechaAlta" property="context.infoAltaP.fechaAlta" value="context.alta.fechaAlta" action="set" xpos='1550' ypos='2600' />
<transform name='Transformar' class='cysnet.clinicaDental.agenda.dtl.InfoAltaPacienteToADTA03' source='context.infoAltaP' target='context.mensajeHL7' xpos='1550' ypos='2700' />
<call name='Enviar HL7' target='OutFileHL7' async='0' xpos='1550' ypos='2800' >
<request type='EnsLib.HL7.Message' >
<assign property="callrequest" value="context.mensajeHL7" action="set" />
</request>
<response type='EnsLib.HL7.Message' />
</call>
</case>
<default name='default' />
</switch>
</true>
</if>
</sequence>
</process>
}

}
