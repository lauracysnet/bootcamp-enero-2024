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
<process language='objectscript' request='Ens.Request' response='Ens.Response' height='3850' width='2420' >
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
<property name='infoModifcarCita' type='cysnet.clinicaDental.agenda.msg.struct.InfoModificarCita' instantiate='0' />
<property name='InfoAdmision' type='cysnet.clinicaDental.agenda.msg.struct.InfoAdmision' instantiate='0' />
</context>
<sequence xend='200' yend='3200' >
<assign name="Asinar Request" property="context.objReq" value="request" action="set" xpos='200' ypos='250' />
<assign name="Asinar nombre de la clase" property="context.nombreClase" value="request.%ClassName()" action="set" xpos='200' ypos='350' />
<rule name='Validar Datos' rule='cysnet.clinicaDental.agenda.rules.CheckDatosProcesosCitas'  resultLocation='context.resultadoRegla' ruleContext='context' xpos='200' ypos='450' >
</rule>
<code name='loginfo' xpos='200' ypos='550' >
<![CDATA[ $$$LOGINFO("obtenerCita:"_context.obtenerCita)
 $$$LOGINFO("obtenerPaciente:"_context.obtenerPaciente)
 $$$LOGINFO("obtenerAdmision:"_context.obtenerAdmision)
   ]]>
</code>
<if name='Datos Correctos' condition='context.resultadoRegla = 1' xpos='200' ypos='650' xend='200' yend='3100' >
<true>
<if name='obtener Admision' condition='context.obtenerAdmision = 1' xpos='335' ypos='800' xend='335' yend='1050' >
<true>
<call name='Obtener Admision' target='AdmisionesSQL' async='0' xpos='470' ypos='950' >
<request type='cysnet.clinicaDental.agenda.msg.BuscarAdmisionPorCitaRequest' >
<assign property="callrequest.idCita" value="request.idCita" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.BuscarAdmisionPorCitaResponse' >
<assign property="context.admision" value="callresponse" action="set" />
</response>
</call>
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
<if name='obtenerPaciente ' condition='context.obtenerPaciente = 1' xpos='335' ypos='1600' xend='335' yend='1850' >
<true>
<call name='Obtener Paciente' target='PacientesSQL' async='0' xpos='470' ypos='1750' >
<request type='cysnet.clinicaDental.agenda.msg.BuscarPacientePorIDRequest' >
<assign property="callrequest.idPaciente" value="context.idPaciente" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.BuscarPacientePorIDResponse' >
<assign property="context.paciente" value="callresponse" action="set" />
</response>
</call>
</true>
</if>
<switch name='selecionar mensaje' xpos='335' ypos='1950' xend='335' yend='3000' >
<case condition='request.%ClassName() = "ListarCitasRequest"' name='ListarCitas' >
<call name='ListarCitas' target='CitasSQL' async='0' xpos='470' ypos='2100' >
<request type='cysnet.clinicaDental.agenda.msg.ListarCitasRequest' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.ListarCitasResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</case>
<case condition='request.%ClassName() = "CancelarCitaRequest"' name='CancelarCita' >
<call name='CancelarCita' target='CitasSQL' async='0' xpos='740' ypos='2100' >
<request type='cysnet.clinicaDental.agenda.msg.CancelarCitaRequest' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.CancelarCitaResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
<call name='notificar cancelacion' target='NotificacionesSQL' async='1' xpos='740' ypos='2200' >
<request type='cysnet.clinicaDental.notificaciones.msg.GenerarNotificacionRequest' >
<assign property="callrequest.idPaciente" value="context.idPaciente" action="set" />
<assign property="callrequest.asunto" value="&quot;cancelacion de cita:&quot;_context.idCita" action="set" />
<assign property="callrequest.mensaje" value="&quot;mensaje para el paciente &quot;_context.idPaciente_&quot; se cancela la cita &quot;_context.idCita" action="set" />
</request>
<response type='cysnet.clinicaDental.notificaciones.msg.GenerarNotificacionResponse' />
</call>
</case>
<case condition='request.%ClassName() = "AdmitirPacienteRequest"' >
<assign name="asignar paciente" property="context.InfoAdmision.paciente" value="context.paciente" action="set" xpos='1010' ypos='2100' />
<assign name="asignar admision" property="context.InfoAdmision.admision" value="context.admision" action="set" xpos='1010' ypos='2200' />
<transform name='Transformar' class='cysnet.clinicaDental.agenda.dtl.InfoAdmisionToADTA01' source='context.InfoAdmision' target='context.mensajeHL7' xpos='1010' ypos='2300' />
<call name='Enviar ADTA01' target='OutFileHL7' async='0' xpos='1010' ypos='2400' >
<request type='EnsLib.HL7.Message' >
<assign property="callrequest" value="context.mensajeHL7" action="set" />
</request>
<response type='EnsLib.HL7.Message' />
</call>
</case>
<case condition='request.%ClassName() = "AltaCitasRequest"' name='AltaCitas' >
<call name='AltaCitas' target='CitasSQL' async='0' xpos='1280' ypos='2100' >
<request type='cysnet.clinicaDental.agenda.msg.AltaCitasRequest' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.AltaCitasResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
<call name='traer cita' target='CitasSQL' async='0' xpos='1280' ypos='2200' >
<request type='cysnet.clinicaDental.agenda.msg.UltimaCitaDePacientePorEstadoRequest' >
<assign property="callrequest.idPaciente" value="context.idPaciente" action="set" />
<assign property="callrequest.codEstado" value="&quot;1&quot;" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.UltimaCitaDePacientePorEstadoResponse' >
<assign property="context.infoModifcarCita.cita.idCita" value="callresponse.idCita" action="set" />
<assign property="context.infoModifcarCita.cita.idPaciente" value="callresponse.idPaciente" action="set" />
<assign property="context.infoModifcarCita.cita.descCita" value="callresponse.descCita" action="set" />
<assign property="context.infoModifcarCita.cita.fechaCita" value="callresponse.fechaCita" action="set" />
<assign property="context.infoModifcarCita.cita.codEstado" value="callresponse.codEstado" action="set" />
<assign property="context.infoModifcarCita.cita.mensaje" value="callresponse.mensaje" action="set" />
<assign property="context.infoModifcarCita.cita.exito" value="callresponse.exito" action="set" />
</response>
</call>
<assign name="asignar paciente" property="context.infoModifcarCita.paciente" value="context.paciente" action="set" xpos='1280' ypos='2300' />
<transform name='Transformar' class='cysnet.clinicaDental.agenda.dtl.InfoModificarCitaToSIUS12' source='context.infoModifcarCita' target='context.mensajeHL7' xpos='1280' ypos='2400' />
<call name='Enviar SIUS12 creacion' target='OutFileHL7' async='0' xpos='1280' ypos='2500' >
<request type='EnsLib.HL7.Message' >
<assign property="callrequest" value="context.mensajeHL7" action="set" />
</request>
<response type='EnsLib.HL7.Message' />
</call>
</case>
<case condition='request.%ClassName() = "AltaPacienteRequest"' name='Alta Pacientes' >
<call name='Obtener Alta' target='AltasSQL' async='0' xpos='1550' ypos='2100' >
<request type='cysnet.clinicaDental.agenda.msg.BuscarAltaPacientePorCitaRequest' >
<assign property="callrequest.idCita" value="request.idCita" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.BuscarAltaPacientePorCitaResponse' >
<assign property="context.alta" value="callresponse" action="set" />
<assign property="context.infoAltaP.fechaAlta" value="callresponse.fechaAlta" action="set" />
</response>
</call>
<assign name="Asignar admision" property="context.infoAltaP.admision" value="context.admision" action="set" xpos='1550' ypos='2200' />
<assign name="asignar paciente" property="context.infoAltaP.paciente" value="context.paciente" action="set" xpos='1550' ypos='2300' />
<transform name='Transformar' class='cysnet.clinicaDental.agenda.dtl.InfoAltaPacienteToADTA03' source='context.infoAltaP' target='context.mensajeHL7' xpos='1550' ypos='2400' />
<call name='Enviar ADTA03' target='OutFileHL7' async='0' xpos='1550' ypos='2500' >
<request type='EnsLib.HL7.Message' >
<assign property="callrequest" value="context.mensajeHL7" action="set" />
</request>
<response type='EnsLib.HL7.Message' />
</call>
</case>
<case condition='request.%ClassName() = "ModificarCitaRequest"' >
<assign name="asignar cita" property="context.infoModifcarCita.cita" value="context.cita" action="set" xpos='1820' ypos='2100' />
<assign name="asignar paciente" property="context.infoModifcarCita.paciente" value="context.paciente" action="set" xpos='1820' ypos='2200' />
<transform name='Transformar' class='cysnet.clinicaDental.agenda.dtl.InfoModificarCitaToSIUS15' source='context.infoModifcarCita' target='context.mensajeHL7' xpos='1820' ypos='2300' />
<call name='Enviar SIUS15' target='OutFileHL7' async='0' xpos='1820' ypos='2400' >
<request type='EnsLib.HL7.Message' >
<assign property="callrequest" value="context.mensajeHL7" action="set" />
</request>
<response type='EnsLib.HL7.Message' />
</call>
<call name='ModificarCita' target='CitasSQL' async='0' xpos='1820' ypos='2500' >
<request type='cysnet.clinicaDental.agenda.msg.ModificarCitaRequest' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.ModificarCitaResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
<assign name="asignar fecha cita nueva" property="context.infoModifcarCita.cita.fechaCita" value="request.fechaCita" action="set" xpos='1820' ypos='2600' />
<transform name='Transformar' class='cysnet.clinicaDental.agenda.dtl.InfoModificarCitaToSIUS12' source='context.infoModifcarCita' target='context.mensajeHL7' xpos='1820' ypos='2700' />
<call name='Enviar SIUS12' target='OutFileHL7' async='0' xpos='1820' ypos='2800' >
<request type='EnsLib.HL7.Message' >
<assign property="callrequest" value="context.mensajeHL7" action="set" />
</request>
<response type='EnsLib.HL7.Message' />
</call>
<call name='notificar cambio fecha' target='NotificacionesSQL' async='1' xpos='1820' ypos='2900' >
<request type='cysnet.clinicaDental.notificaciones.msg.GenerarNotificacionRequest' >
<assign property="callrequest.idPaciente" value="context.idPaciente" action="set" />
<assign property="callrequest.asunto" value="&quot;Cambio de cita:&quot;_context.idCita" action="set" />
<assign property="callrequest.mensaje" value="&quot;mensaje para el paciente &quot;_context.idPaciente_&quot; la cita &quot;_context.idCita_&quot; se movio para la fecha:&quot;_request.fechaCita" action="set" />
</request>
<response type='cysnet.clinicaDental.notificaciones.msg.GenerarNotificacionResponse' />
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
