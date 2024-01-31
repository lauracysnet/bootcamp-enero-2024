/// 
Class cysnet.clinicaDental.notificaciones.bp.ProcesoNotificaciones Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='cysnet.clinicaDental.notificaciones.msg.GenerarNotificacionRequest' response='cysnet.clinicaDental.notificaciones.msg.GenerarNotificacionResponse' height='2000' width='2000' >
<context>
<property name='paciente' type='cysnet.clinicaDental.agenda.msg.BuscarPacientePorIDResponse' instantiate='0' />
</context>
<sequence xend='200' yend='950' >
<call name='Obtener paciente' target='PacientesSQL' async='0' xpos='200' ypos='250' >
<request type='cysnet.clinicaDental.agenda.msg.BuscarPacientePorIDRequest' >
<assign property="callrequest.idPaciente" value="request.idPaciente" action="set" />
</request>
<response type='cysnet.clinicaDental.agenda.msg.BuscarPacientePorIDResponse' >
<assign property="context.paciente" value="callresponse" action="set" />
</response>
</call>
<if name='Existe Paciente' condition='context.paciente.exito = 1' xpos='200' ypos='350' xend='200' yend='850' >
<true>
<if name='Paciente Permite Notificaciones' condition='context.paciente.permiteNotificaciones = 1' xpos='470' ypos='500' xend='470' yend='750' >
<true>
<call name='Enviar Email' target='EnviarEmail' async='0' xpos='605' ypos='650' >
<request type='cysnet.clinicaDental.notificaciones.msg.EnviarEmailRequest' >
<assign property="callrequest.asunto" value="request.asunto" action="set" />
<assign property="callrequest.mensaje" value="request.mensaje" action="set" />
<assign property="callrequest.destinatario" value="context.paciente.email" action="set" />
<assign property="callrequest.nombre" value="context.paciente.nombre" action="set" />
<assign property="callrequest.apellidos" value="context.paciente.apellidos" action="set" />
</request>
<response type='cysnet.clinicaDental.notificaciones.msg.EnviarEmailResponse' />
</call>
</true>
</if>
</true>
<false>
<call name='Enviar email de notificación de Error' target='EnviarEmail' async='0' xpos='200' ypos='500' >
<request type='cysnet.clinicaDental.notificaciones.msg.GenerarNotificacionRequest' >
<assign property="callrequest.asunto" value="&quot;&quot;" action="set" />
</request>
<response type='cysnet.clinicaDental.notificaciones.msg.EnviarEmailResponse' />
</call>
</false>
</if>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
